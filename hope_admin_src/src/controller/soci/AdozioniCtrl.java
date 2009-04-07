package controller.soci;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import mapping.*;

import org.hibernate.*;
import org.hibernate.cfg.Configuration;

import eccezioni.AdozioniException;
import eccezioni.LoginException;

import system.*;

public class AdozioniCtrl extends HttpServlet{

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
		
		hsession = new Configuration().configure().buildSessionFactory().openSession();

		try {
			
			hsession = HibernateUtil.currentSession();		
			sessione = request.getSession();
			tx = hsession.beginTransaction();
					
			String action = request.getParameter("action");
			String page = request.getParameter("page");
		
			if (action == null)
				action = "page";
			if(page == null)
				page = "adottanti";
			
			Users u = (Users) sessione.getAttribute("user");	
			
			if (u == null) {
				throw new LoginException();
			}
			else if(u.getTipo().intValue() < 1)
			{
				throw new LoginException();
			}
			
			if(action.equals("page"))
			{
				if(page.equals("adottanti"))
				{
					pageAdottanti(request, response);
				}
				else if(page.equals("bambini"))
				{
					pageBambini(request, response);
				}
			}
			else if(action.equals("select"))
			{
				
			}
			else if(action.equals("view"))
			{
				if(page.equals("bambino"))
				{
					viewBambino(request, response);
				}
			}
			else if(action.equals("insert"))
			{
				if(page.equals("first"))
				{
					pageInsertAdozione(request, response);
				}
				else if(page.equals("new"))
				{
					pageInsertNew(request, response);
				}
				else if(page.equals("anagrafe"))
				{
					pageInsertNew2(request, response);
				}
				else if(page.equals("insert"))
				{
					insertAdozione(request, response);
				}
			}
			else if(action.equals("stampa"))
			{

			}
			else if(action.equals("save"))
			{
				saveAdottante(request, response);
			}
			else if(action.equals("del"))
			{
				if(page.equals("adottante"))
				{
					eliminaAdottante(request, response);
				}
				else if(page.equals("bambino"))
				{
					eliminaBambino(request, response);
				}
				else if(page.equals("anno"))
				{
					eliminaAnnoBambino(request, response);
				}
			}
			else if(action.equals("insertbambino"))
			{
				if(page.equals("first"))
				{
					pageInsertBambino(request, response);
				}
				else if(page.equals("insert"))
				{
					insertBambino(request, response);
				}
				else if(page.equals("anno"))
				{
					nuovoAnnoBambino(request, response);
				}
				else if(page.equals("save"))
				{
					saveBambino(request, response);
				}
			}


		} catch (LoginException e) {
			
			Avviso err = new Avviso (e.getMessage());
			request.setAttribute("err", err);
			nextview = "/./error.jsp";

		} catch (Exception e) {
			
			Avviso err = new Avviso ("Errore indefinito. Ricorda di non usare il tasto REFRESH di Explorer!");
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

	private void saveBambino(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		
		String id = request.getParameter("id");
		String nome = request.getParameter("nome");
		String sesso = request.getParameter("sesso");
		String indirizzo = request.getParameter("indirizzo");
		String citta = request.getParameter("citta");
		String nazione = request.getParameter("nazione");
		String datanascita = request.getParameter("datanascita");
		String scuola = request.getParameter("scuola");
		String descrizione = request.getParameter("descrizione");
		
		Query q = hsession.createQuery("FROM Bambino WHERE id = :id");
		q.setString("id", id);
		
		Bambino b = (Bambino) q.list().get(0);
		
		b.setNome(nome);
		b.setSesso(sesso);
		b.setIndirizzo(indirizzo);
		b.setCitta(citta);
		b.setNazione(nazione);
		
		SimpleDateFormat sdf = new SimpleDateFormat ("dd/MM/yyyy");
		Date data = new Date(sdf.parse(datanascita).getTime());
		b.setDatanascita(data);
		
		b.setScuola(scuola);
		b.setDescrizione(descrizione);
		
		hsession.saveOrUpdate(b);
		
		tx.commit();
		
		pageBambini(request, response);
	}

	private void eliminaAnnoBambino(HttpServletRequest request, HttpServletResponse response) {
		
		String anno = request.getParameter("annob");
		String id = request.getParameter("id");
		
		Query q = hsession.createQuery("FROM Bambinoanno WHERE idbambino = :id AND anno = :anno");
		q.setString("anno", anno);
		q.setString("id", id);
		
		Bambinoanno ba = (Bambinoanno) q.list().get(0);
		
		hsession.delete(ba);
		
		q = hsession.createQuery("FROM Adottanti WHERE idbambino = :id AND anno = :anno");
		q.setString("anno", anno);
		q.setString("id", id);
		
		List tmp = q.list();
		
		if(tmp.size() > 0)
		{
			Adottanti a = (Adottanti) tmp.get(0);
		
			hsession.delete(a);
		}
		
		tx.commit();
		
		viewBambino(request, response);
	}

	private void nuovoAnnoBambino(HttpServletRequest request, HttpServletResponse response) {
		
		String anno = request.getParameter("annob");
		String costo = request.getParameter("costob");
		String id = request.getParameter("id");
		
		try {
			
			Query q = hsession.createQuery("FROM Bambinoanno WHERE idbambino = :id AND anno = :anno");
			q.setString("anno", anno);
			q.setString("id", id);
			
			if(q.list().size() > 0)
			{
				throw new AdozioniException("L'anno inserito è già presente per il bambino selezionato!");
			}
			
			q = hsession.createQuery("FROM Bambino WHERE id = :id");
			q.setString("id", id);
			
			Bambino b = (Bambino) q.list().get(0);
			
			Bambinoanno ba = new Bambinoanno();
			ba.setAnno(new Integer(anno));
			ba.setCosto(new Integer(costo));
			ba.setBambino(b);
			ba.setNote("");
			
			hsession.saveOrUpdate(ba);
			
			tx.commit();
			
			viewBambino(request, response);
		
		} catch (AdozioniException ex) {
			
			Avviso err = new Avviso (ex.getMessage());
			request.setAttribute("err", err);
			
			viewBambino(request, response);
		}
	}

	private void viewBambino(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		
		Query q = hsession.createQuery("FROM Bambinoannoview WHERE id = :id ORDER BY anno");
		q.setString("id", id);
		
		request.setAttribute("bambino", q.list());
		
		nextview = "/soci/bambini_edit.jsp";
	}

	private void insertBambino(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		
		String nome = request.getParameter("nome");
		String sesso = request.getParameter("sesso");
		String indirizzo = request.getParameter("indirizzo");
		String citta = request.getParameter("citta");
		String nazione = request.getParameter("nazione");
		String datanascita = request.getParameter("datanascita");
		String scuola = request.getParameter("scuola");
		String descrizione = request.getParameter("descrizione");
		String anno = request.getParameter("anno");
		String costo = request.getParameter("costo");
		
		Bambino b = new Bambino();
		
		b.setNome(nome);
		b.setSesso(sesso);
		b.setIndirizzo(indirizzo);
		b.setCitta(citta);
		b.setNazione(nazione);
		
		SimpleDateFormat sdf = new SimpleDateFormat ("dd/MM/yyyy");
		Date data = new Date(sdf.parse(datanascita).getTime());
		b.setDatanascita(data);
		
		b.setScuola(scuola);
		b.setDescrizione(descrizione);
		
		hsession.saveOrUpdate(b);
		
		Bambinoanno ba = new Bambinoanno();
		ba.setAnno(new Integer(anno));
		ba.setBambino(b);
		ba.setNote("");
		ba.setCosto(new Integer(costo));
		
		hsession.saveOrUpdate(ba);
		
		tx.commit();
		
		pageBambini(request, response);
	}

	private void pageInsertBambino(HttpServletRequest request, HttpServletResponse response) {
		
		nextview = "/soci/bambini_insert_new.jsp";
	}

	private void eliminaBambino(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		
		Query q = hsession.createQuery("FROM Bambino WHERE id = :id");
		q.setString("id", id);
		
		Bambino b = (Bambino) q.list().get(0);
		
		hsession.delete(b);
		
		tx.commit();
		
		pageBambini(request, response);
	}

	private void eliminaAdottante(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		
		Query q = hsession.createQuery("FROM Adottanti WHERE id = :id");
		q.setString("id", id);
		
		Adottanti a = (Adottanti) q.list().get(0);
		
		hsession.delete(a);
		
		tx.commit();
		
		pageAdottanti(request, response);
	}

	private void saveAdottante(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		String p1 = request.getParameter("p1");
		String p2 = request.getParameter("p2");
		String p3 = request.getParameter("p3");
		
		Query q = hsession.createQuery("FROM Adottanti WHERE id = :id");
		q.setString("id", id);
		
		Adottanti a = (Adottanti) q.list().get(0);
		a.setP1(new Integer(p1));
		a.setP2(new Integer(p2));
		a.setP3(new Integer(p3));
		
		hsession.saveOrUpdate(a);
		
		tx.commit();
		
		pageAdottanti(request, response);
	}

	private void insertAdozione(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		String cognome = request.getParameter("cognome");
		String nome = request.getParameter("nome");
		String indirizzo = request.getParameter("indirizzo");
		String cap = request.getParameter("cap");
		String citta = request.getParameter("citta");
		String nazione = request.getParameter("nazione");
		String telefono = request.getParameter("telefono");
		String cellulare = request.getParameter("cellulare");
		String email = request.getParameter("email");
		String codfiscale = request.getParameter("codfiscale");
		
		String idb = request.getParameter("bambino");
		String anno = request.getParameter("anno");
		
		Anagrafe n = new Anagrafe();
		
		try
		{			
			if(!id.equals(""))
			{
				Query q = hsession.createQuery("FROM Anagrafe WHERE id = :id");
				q.setString("id", id);
				
				n = (Anagrafe) q.list().get(0);
			}
			
			n.setCognome(cognome);
			n.setNome(nome);
			n.setIndirizzo(indirizzo);
			n.setCap(cap);
			n.setCitta(citta);
			n.setNazione(nazione);
			n.setTelefono(telefono);
			n.setCellulare(cellulare);
			n.setEmail(email);
			n.setCodfiscale(codfiscale);
			
			Query q = hsession.createQuery("FROM Adottanti WHERE idbambino = :id AND anno = :anno");
			q.setString("id", idb);
			q.setString("anno", anno);
			List tmp = q.list();
			
			if(tmp.size() > 0)
			{
				throw new AdozioniException(((Adottanti)tmp.get(0)).getBambino().getNome(), anno);
			}
			
			hsession.saveOrUpdate(n);
			
			q = hsession.createQuery("FROM Bambino WHERE id = :id");
			q.setString("id", idb);
			
			Adottanti a = new Adottanti();
			
			a.setAnagrafe(n);
			a.setBambino((Bambino)q.list().get(0));
			a.setAnno(new Integer(anno));
			a.setP1(new Integer(0));
			a.setP2(new Integer(0));
			a.setP3(new Integer(0));
			
			hsession.saveOrUpdate(a);
			
			tx.commit();
			
			pageAdottanti(request, response);
		}
		catch (AdozioniException ex) {
			
			Avviso err = new Avviso (ex.getMessage());
			request.setAttribute("err", err);
			
			//request.setAttribute("nominativo", n);
			
			pageInsertNew2(request, response);
		}
	}

	private void pageInsertNew2(HttpServletRequest request, HttpServletResponse response) {
		
		String anno = request.getParameter("anno");
		
		Query q = hsession.createQuery("FROM Bambiniliberi WHERE anno = :anno ORDER BY nazione, citta, sesso, nome");
		q.setString("anno", anno);
		
		request.setAttribute("listabambini", q.list());
		
		nextview = "/soci/adozioni_insert_new_bambino.jsp";
	}

	private void pageInsertNew(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		
		Query q = hsession.createQuery("FROM Anagrafe WHERE id = :id");
		q.setString("id", id);
		
		request.setAttribute("nominativo", q.list().get(0));
		
		nextview = "/soci/adozioni_insert_new.jsp";
	}

	private void pageInsertAdozione(HttpServletRequest request, HttpServletResponse response) {
		
		String what = request.getParameter("what");
		String cognome = request.getParameter("cognome");
		
		Query q = null;
		
		if(what == null)
		{
			q = hsession.createQuery("FROM Anagrafe ORDER BY cognome, nome, citta");
		}
		else
		{
			q = hsession.createQuery("FROM Anagrafe WHERE cognome LIKE '%" + cognome +  "%' ORDER BY cognome, nome, citta");
		}
		
		request.setAttribute("anagrafe", q.list());
		
		nextview = "/soci/adozioni_insert_main.jsp";
	}

	private void pageBambini(HttpServletRequest request, HttpServletResponse response) {
		
		String anno = request.getParameter("anno");
		
		Query q = null;
		
		if(anno == null)
		{
			Date oggi = new Date();
			Calendar cal = new GregorianCalendar();
			cal.setTime(oggi);
			int annoint = cal.get(Calendar.YEAR);
			anno = new Integer(annoint).toString();
		}
		
		if((anno.equals(""))||(anno.equals("tutti")))
		{
			q = hsession.createQuery("FROM Bambinoannoview order by nome");
		}
		else
		{
			q = hsession.createQuery("FROM Bambinoannoview WHERE anno = :anno ORDER BY nome");
			q.setString("anno", anno);
		}
		
		request.setAttribute("listabambini", q.list());
		request.setAttribute("anno", anno);
		
		nextview = "/soci/bambini_main.jsp";
	}

	private void pageAdottanti(HttpServletRequest request, HttpServletResponse response) {
		
		String anno = request.getParameter("anno");
		
		if(anno == null)
		{
			Date oggi = new Date();
			Calendar cal = new GregorianCalendar();
			cal.setTime(oggi);
			int annoint = cal.get(Calendar.YEAR);
			anno = new Integer(annoint).toString();
		}
		
		Query q = hsession.createQuery("FROM Adottantiview WHERE anno = :anno ORDER BY cognome, nome");
		q.setString("anno", anno);
		
		request.setAttribute("listaadottanti", q.list());
		request.setAttribute("anno", anno);
		
		nextview = "/soci/adozioni_main.jsp";
	}

}
