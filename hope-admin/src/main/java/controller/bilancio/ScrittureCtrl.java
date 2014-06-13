
package controller.bilancio;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Vector;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;

import mapping.Anno;
import mapping.Conto;
import mapping.Movimenti;
import mapping.Scrittura;
import mapping.Users;

import org.hibernate.*;
import org.hibernate.cfg.Configuration;

import eccezioni.ClosedEditException;
import eccezioni.ClosedException;
import eccezioni.LoginException;
import eccezioni.ScritturaException;

import system.*;

public class ScrittureCtrl extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Session hsession = null;
	private HttpSession sessione = null;
	private String nextview = "";
	private Transaction tx;
	
	/**
	 * The doGet method of the servlet.
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException {
		
		controller (request, response);
		
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException {
		
		controller (request, response);
		
	}
	
	public void controller (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
		try {
			
			hsession = HibernateUtil.currentSession();		
			sessione = request.getSession();
			tx = hsession.beginTransaction();
			
			Users u = (Users) sessione.getAttribute("user");	
			
			if (u == null) {
				throw new LoginException();
			}
			else if(u.getTipo().intValue() < 2)
			{
				throw new LoginException();
			}
			
			String action = request.getParameter("action");
			String what = request.getParameter("what");
		
			if (action == null)
				action = "page";	
			
			if(action.equals("new"))
			{
				if(what == null)
					nuovaScrittura(request, response);
				else if(what.equals("movimenti"))
					nuovoMovimento(request, response);
			}
			else if(action.equals("refresh"))
			{
				refreshScrittura(request, response);
			}
			else if(action.equals("insert"))
			{
				if(what == null)
					insertScrittura(request, response);
				else
					insertMovimento(request, response);
			}
			else if(action.equals("page"))
			{
				if(what == null)
					pageScritture(request, response);
				else if(what.equals("movimenti"))
					pageMovimenti(request, response);
			}
			else if(action.equals("view"))
			{
				if(what == null)
					viewScrittura(request, response);
				else if(what.equals("movimenti"))
					viewMovimento(request, response);
				else
					viewScrittura(request, response);
			}
			else if(action.equals("edit"))
			{
				if(what == null)
					editScrittura(request, response);
				else if(what.equals("movimenti"))
					editMovimento(request, response);
				else
					editScrittura(request, response);
			}
			else if(action.equals("del"))
			{
				if(what == null)
					delScrittura(request, response);
				else if(what.equals("movimenti"))
					delMovimento(request, response);
				else
					delScrittura(request, response);
			}
			else if(action.equals("select"))
			{
				selectScritture(request, response);
			}
		
		} catch (LoginException e) {
			
			Avviso err = new Avviso (e.getMessage());
			request.setAttribute("err", err);
			nextview = "/./error.jsp";
			
		} catch (Exception e) {
			
			Avviso err = new Avviso ("Errore indefinito.\n" + e.getMessage());
			request.setAttribute("err", err);
			System.out.println(e.getMessage());
			nextview = "/./error.jsp";

		} finally {
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextview);
			if (dispatcher != null) {
				response.encodeURL(nextview);
				dispatcher.forward(request, response);
			}
			HibernateUtil.closeSession();
			
		}
		
	}

	private void selectScritture(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		
		String what = request.getParameter("what");
		
		if(what.equals("tutte"))
		{
			Query q = hsession.createQuery("FROM Scrittura ORDER BY data");
			request.setAttribute("listascritture", q.list());
		}
		else if(what.equals("anno"))
		{
			String anno = request.getParameter("anno");
			
			String dalStr = anno + "-01-01";
			String alStr = anno + "-12-31";
			
			Query q = hsession.createQuery("FROM Scrittura WHERE data >= :dal AND data <= :al ORDER BY data");
			q.setString("dal", dalStr);
			q.setString("al", alStr);
			
			request.setAttribute("listascritture", q.list());
		}
		else if(what.equals("periodo"))
		{
			String dalStr = request.getParameter("dal");
			String alStr = request.getParameter("al");
			
			SimpleDateFormat sdf = new SimpleDateFormat ("dd/MM/yyyy");
			Date dal = new Date(sdf.parse(dalStr).getTime());
			Date al = new Date(sdf.parse(alStr).getTime());
			SimpleDateFormat sdfDB = new SimpleDateFormat ("yyyy-MM-dd");
			
			Query q = hsession.createQuery("FROM Scrittura WHERE data >= :dal AND data <= :al ORDER BY data");
			q.setString("dal", sdfDB.format(dal));
			q.setString("al", sdfDB.format(al));
			
			request.setAttribute("listascritture", q.list());
		}

		
		nextview = "/bilancio/scrittura_main.jsp";
	}

	private void nuovoMovimento(HttpServletRequest request, HttpServletResponse response) {
		
		Query q = hsession.createQuery("FROM Contogruppo");
		request.setAttribute("listaconti", q.list());
		
		nextview = "/bilancio/movimenti_new.jsp";
	}

	private void insertMovimento(HttpServletRequest request, HttpServletResponse response) {
		
		String nome = request.getParameter("nome");
		String descrizione = request.getParameter("descrizione");
		String dareId = request.getParameter("dare");
		String avereId = request.getParameter("avere");
		
		Query q = hsession.createQuery("FROM Conto WHERE id = :id");
		q.setString("id", dareId);
		Conto dare = (Conto)q.list().get(0);
		q = hsession.createQuery("FROM Conto WHERE id = :id");
		q.setString("id", avereId);
		Conto avere = (Conto)q.list().get(0);
		
		Movimenti m = new Movimenti();
		m.setNome(nome);
		m.setDescrizione(descrizione);
		m.setDare(dare);
		m.setAvere(avere);
		
		hsession.saveOrUpdate(m);
		tx.commit();
		
		pageMovimenti(request, response);
	}

	private void delMovimento(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		
		Query q = hsession.createQuery("FROM Movimenti WHERE id = :id");
		q.setString("id", id);
		
		Movimenti m = (Movimenti) q.list().get(0);
		
		hsession.delete(m);
		tx.commit();
		
		pageMovimenti(request, response);
	}

	private void editMovimento(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		String nome = request.getParameter("nome");
		String descrizione = request.getParameter("descrizione");
		String dareId = request.getParameter("dare");
		String avereId = request.getParameter("avere");
		
		Query q = hsession.createQuery("FROM Conto WHERE id = :id");
		q.setString("id", dareId);
		Conto dare = (Conto)q.list().get(0);
		q = hsession.createQuery("FROM Conto WHERE id = :id");
		q.setString("id", avereId);
		Conto avere = (Conto)q.list().get(0);
		
		q = hsession.createQuery("FROM Movimenti WHERE id = :id");
		q.setString("id", id);
		
		Movimenti m = (Movimenti) q.list().get(0);
		m.setNome(nome);
		m.setDescrizione(descrizione);
		m.setDare(dare);
		m.setAvere(avere);
		
		hsession.saveOrUpdate(m);
		tx.commit();
		
		pageMovimenti(request, response);
	}

	private void viewMovimento(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		
		Query q = hsession.createQuery("FROM Movimenti WHERE id = :id");
		q.setString("id", id);
		
		Movimenti m = (Movimenti) q.list().get(0);
		
		request.setAttribute("movimento", m);
		
		q = hsession.createQuery("FROM Contogruppo");
		request.setAttribute("listaconti", q.list());
		
		nextview = "/bilancio/movimenti_edit.jsp";
	}

	private void pageMovimenti(HttpServletRequest request, HttpServletResponse response) {
		
		Query q = hsession.createQuery("FROM Movimenti");
		request.setAttribute("listamovimenti", q.list());
		
		nextview = "/bilancio/movimenti_main.jsp";
	}

	private void delScrittura(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		
		String id = request.getParameter("id");
		
		Query q = hsession.createQuery("FROM Scrittura WHERE id = :id");
		q.setString("id", id);
		Scrittura scr = (Scrittura) q.list().get(0);
		
		try{
			checkScritturaDelete(scr);
			
			hsession.delete(scr);
			tx.commit();
		}
		catch(Exception ex)
		{
			Avviso err = new Avviso (ex.getMessage());
			request.setAttribute("err", err);
		}
		
		String what = request.getParameter("what");
		String anno = request.getParameter("anno");
		String dal = request.getParameter("dal");
		String al = request.getParameter("al");
		
		nextview = "/bilancio/scritture?action=select&what=" + what + "&anno=" + anno + "&dal=" + dal + "&al=" + al;
		
	}

	private void editScrittura(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		
		String id = request.getParameter("id");
		String dataStr = request.getParameter("data");
		String descrizione = request.getParameter("descrizione");
		Float importo = new Float(request.getParameter("importo"));
		String dareId = request.getParameter("dare");
		String avereId = request.getParameter("avere");
		
		SimpleDateFormat sdf = new SimpleDateFormat ("dd/MM/yyyy");
		Date data = new Date(sdf.parse(dataStr).getTime());
		
		Query q = hsession.createQuery("FROM Conto WHERE id = :id");
		q.setString("id", dareId);
		Conto dare = (Conto)q.list().get(0);
		q = hsession.createQuery("FROM Conto WHERE id = :id");
		q.setString("id", avereId);
		Conto avere = (Conto)q.list().get(0);
		
		Calendar d = new GregorianCalendar();
		d.setTime(data);
		int a = d.get(Calendar.YEAR);
		q = hsession.createQuery("FROM Anno WHERE anno =:a");
		q.setString("a", new Integer(a).toString());
		Anno a1 = (Anno)q.list().get(0);
		
		try{
			checkScritturaInsert(data);
			
			q = hsession.createQuery("FROM Scrittura WHERE id = :id");
			q.setString("id", id);
			Scrittura new_scr = (Scrittura) q.list().get(0);
			new_scr.setData(data);
			new_scr.setDescrizione(descrizione);
			new_scr.setImporto(importo.floatValue());
			new_scr.setDare(dare);
			new_scr.setAvere(avere);
			new_scr.setAutomatico(false);
			new_scr.setAnno(a1);
			
			hsession.saveOrUpdate(new_scr);
			tx.commit();
			
			String what = request.getParameter("what");
			String anno = request.getParameter("anno");
			String dal = request.getParameter("dal");
			String al = request.getParameter("al");
			
			nextview = "/bilancio/scritture?action=select&what=" + what + "&anno=" + anno + "&dal=" + dal + "&al=" + al;
		}
		catch(Exception ex)
		{
			Avviso err = new Avviso (ex.getMessage());
			request.setAttribute("err", err);
			
			nextview = "/bilancio/scritture?action=view&id=" + id;
			
		}
	}

	private void viewScrittura(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		try
		{
			Query q = hsession.createQuery("FROM Scrittura WHERE id = :id");
			q.setString("id", id);
			
			Scrittura scr = (Scrittura) q.list().get(0);
			
			checkScritturaEdit(scr);
			
			request.setAttribute("scrittura", scr);
			
			q = hsession.createQuery("FROM Contogruppo");
			request.setAttribute("listaconti", q.list());
			
			nextview = "/bilancio/scrittura_edit.jsp";
			
		}catch(Exception ex)
		{
			Avviso err = new Avviso (ex.getMessage());
			request.setAttribute("err", err);
			
			pageScritture(request, response);
		}
	}

	private void pageScritture(HttpServletRequest request, HttpServletResponse response) {
		
		nextview = "/bilancio/scrittura_select.jsp";
	}

	private void insertScrittura(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		
		String dataStr = request.getParameter("data");
		String movimento = request.getParameter("movimento");
		String descrizione = request.getParameter("descrizione");
		Float importo = new Float(request.getParameter("importo"));
		String dareId = request.getParameter("dare");
		String avereId = request.getParameter("avere");
		
		SimpleDateFormat sdf = new SimpleDateFormat ("dd/MM/yyyy");
		Date data = new Date(sdf.parse(dataStr).getTime());
		
		Query q = hsession.createQuery("FROM Conto WHERE id = :id");
		q.setString("id", dareId);
		Conto dare = (Conto)q.list().get(0);
		q = hsession.createQuery("FROM Conto WHERE id = :id");
		q.setString("id", avereId);
		Conto avere = (Conto)q.list().get(0);
		
		try{
			checkScritturaInsert(data);
			
			Scrittura new_scr = new Scrittura();
			new_scr.setData(data);
			new_scr.setDescrizione(descrizione);
			new_scr.setImporto(importo.floatValue());
			new_scr.setDare(dare);
			new_scr.setAvere(avere);
			new_scr.setAutomatico(false);
			
			sincronizzaAnno(new_scr);
			
			hsession.saveOrUpdate(new_scr);
			tx.commit();
		}
		catch(Exception ex)
		{
			Avviso err = new Avviso (ex.getMessage());
			request.setAttribute("err", err);
			
			request.setAttribute("data", dataStr);
			request.setAttribute("movId", movimento);
			request.setAttribute("descrizione", descrizione);
			request.setAttribute("importo", importo.toString());
			request.setAttribute("dare", dareId);
			request.setAttribute("avere", avereId);
		}
		
		nuovaScrittura(request, response);
		
	}




	private void refreshScrittura(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("movimento");
		String dataStr = request.getParameter("data");
		
		if(Integer.parseInt(id) > 0)
		{
			Query q = hsession.createQuery("FROM Movimenti WHERE id = :id");
			q.setString("id", id);
			
			request.setAttribute("movimento", q.list().get(0));
		}
		
		request.setAttribute("data", dataStr);
		request.setAttribute("movId", id);
		
		nuovaScrittura(request, response);
	}

	private void nuovaScrittura(HttpServletRequest request, HttpServletResponse response) {
		
		Query q = hsession.createQuery("FROM Contogruppo");
		request.setAttribute("listaconti", q.list());

		q = hsession.createQuery("FROM Movimenti");
		request.setAttribute("listamovimenti", q.list());
		
		nextview = "/bilancio/scrittura_new.jsp";
	}
	
	private void checkScritturaInsert(Date d) throws ClosedException {
		
		Calendar data = new GregorianCalendar();
		data.setTime(d);
		int anno = data.get(Calendar.YEAR);
		
		Query q = hsession.createQuery("FROM Anno");
		List anni = q.list();
		
		for(int i=0; i < anni.size(); i++)
		{
			Anno tmp = (Anno) anni.get(i);
			if(tmp.getAnno().intValue() == anno)
				if(tmp.isChiuso())
					throw new ClosedException();
		}
	}
	
	private void checkScritturaEdit(Scrittura new_scr) throws ClosedEditException {
		
		Calendar data = new GregorianCalendar();
		data.setTime(new_scr.getData());
		int anno = data.get(Calendar.YEAR);
		
		Query q = hsession.createQuery("FROM Anno");
		List anni = q.list();
		
		for(int i=0; i < anni.size(); i++)
		{
			Anno tmp = (Anno) anni.get(i);
			if(tmp.getAnno().intValue() == anno)
				if(tmp.isChiuso())
					throw new ClosedEditException();
		}
	}
	
	private void checkScritturaDelete(Scrittura scr) throws ScritturaException{
		
		Calendar data = new GregorianCalendar();
		data.setTime(scr.getData());
		int anno = data.get(Calendar.YEAR);
		
		Query q = hsession.createQuery("FROM Anno");
		List anni = q.list();
		
		for(int i=0; i < anni.size(); i++)
		{
			Anno tmp = (Anno) anni.get(i);
			if(tmp.getAnno().intValue() == anno)
				if(tmp.isChiuso())
					throw new ScritturaException("si riferisce ad un bilancio già chiuso.");
		}
		
		if(scr.isAutomatico())
			throw  new ScritturaException("inserita automaticamente alla chiusura del bilancio.");
	}
	
	private void sincronizzaAnno(Scrittura scr) {
		
		Calendar data = new GregorianCalendar();
		data.setTime(scr.getData());
		int anno = data.get(Calendar.YEAR);
		
		Query q = hsession.createQuery("FROM Anno WHERE anno = :anno");
		q.setString("anno", new Integer(anno).toString());
		List tmp = q.list();
		
		Anno a = new Anno();
		
		if(tmp.size() == 0)
		{
			a.setAnno(new Integer(anno));
			a.setChiuso(false);
			
			hsession.saveOrUpdate(a);
			
		}
		
		q = hsession.createQuery("FROM Anno WHERE anno = :anno");
		q.setString("anno", new Integer(anno).toString());
		tmp = q.list();
		
		scr.setAnno((Anno)tmp.get(0));
	}
}
