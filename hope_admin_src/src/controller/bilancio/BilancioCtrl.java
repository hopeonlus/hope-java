package controller.bilancio;

import java.awt.Color;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Vector;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;

import mapping.*;

import org.hibernate.*;
import org.hibernate.cfg.Configuration;

import com.lowagie.text.Cell;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.HeaderFooter;
import com.lowagie.text.PageSize;
import com.lowagie.text.Phrase;
import com.lowagie.text.Table;
import com.lowagie.text.pdf.PdfWriter;

import eccezioni.ClosedException;
import eccezioni.ContoException;
import eccezioni.GruppoException;
import eccezioni.LoginException;

import system.*;

public class BilancioCtrl extends HttpServlet{

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
			if (what == null)
				what = "bilancio";
			
			if(action.equals("page"))
			{
				if(what.equals("conti"))
				{
					pageConti(request, response);
				}
				else if(what.equals("select"))
				{
					pageSelect(request, response);
				}
				else if(what.equals("bilancio"))
				{
					pageBilancio(request, response);
				}
			}
			else if(action.equals("scheda"))
			{
				schedaConto(request, response);
			}
			else if(action.equals("select"))
			{
				generaBilancio(request, response, false);
			}
			else if(action.equals("stampa"))
			{
				generaBilancio(request, response, true);
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

	private void pageBilancio(HttpServletRequest request, HttpServletResponse response) {
		
		Query q = hsession.createQuery("FROM Anno ORDER BY anno");
		List anni = q.list();
		int size = anni.size();
		String anno = ((Anno) anni.get(size-1)).getAnno().toString();
		
		request.setAttribute("anno", anno);
		
		nextview = "/bilancio/bilancio_select.jsp";
	}

	private void pageSelect(HttpServletRequest request, HttpServletResponse response) {

		Query q = hsession.createQuery("FROM Anno ORDER BY anno");
		List anni = q.list();
		int size = anni.size();
		String anno = ((Anno) anni.get(size-1)).getAnno().toString();
		
		request.setAttribute("anno", anno);
		
		nextview = "/bilancio/bilancio_conti_select.jsp";
	}

	private void schedaConto(HttpServletRequest request, HttpServletResponse response) throws ParseException {

		String what = request.getParameter("what");
		String id = request.getParameter("id");
		String anno = request.getParameter("anno");
		String dalStr = request.getParameter("dal");
		String alStr = request.getParameter("al");
		
		Query q = null;
		
		if(what.equals("tutte"))
		{
			q = hsession.createQuery("FROM Scrittura WHERE dare = :id1 OR avere = :id2 ORDER BY data");
			q.setString("id1", id);
			q.setString("id2", id);
		}
		else if(what.equals("periodo"))
		{
			SimpleDateFormat sdf = new SimpleDateFormat ("dd/MM/yyyy");
			Date dal = new Date(sdf.parse(dalStr).getTime());
			Date al = new Date(sdf.parse(alStr).getTime());
			SimpleDateFormat sdfDB = new SimpleDateFormat ("yyyy-MM-dd");
			
			q = hsession.createQuery("FROM Scrittura WHERE (data >= :dal AND data <= :al)AND(dare = :id1 OR avere = :id2) ORDER BY data");
			q.setString("dal", sdfDB.format(dal));
			q.setString("al", sdfDB.format(al));
			q.setString("id1", id);
			q.setString("id2", id);
		}
		else if(what.equals("anno"))
		{
			String dal = anno + "-01-01";
			String al = anno + "-12-31";
			
			q = hsession.createQuery("FROM Scrittura WHERE (data >= :dal AND data <= :al)AND(dare = :id1 OR avere = :id2) ORDER BY data");
			q.setString("dal", dal);
			q.setString("al", al);
			q.setString("id1", id);
			q.setString("id2", id);
		}
		

		
		List listascritture = q.list();
		String[] riga = new String[3];
		List scritture = new ArrayList();
		float totale = 0;

		for(int i = 0; i < listascritture.size(); i++)
		{
			Scrittura s = (Scrittura) listascritture.get(i);
			
			if(s.getDare().getId().toString().equals(id))
			{
				riga = new String[3];
				SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
				riga[0] = formatter.format(s.getData());
				riga[1] = s.getDescrizione();
				riga[2] = "-" + new Float(s.getImporto()).toString();
				scritture.add(riga);
				
				totale = totale - s.getImporto();
			}
			
			if(s.getAvere().getId().toString().equals(id))
			{
				riga = new String[3];
				SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
				riga[0] = formatter.format(s.getData());
				riga[1] = s.getDescrizione();
				riga[2] = new Float(s.getImporto()).toString();
				scritture.add(riga);
				
				totale = totale + s.getImporto();
			}
				
		}
		
		request.setAttribute("listascritture", scritture);
		request.setAttribute("totale", new Float(totale).toString());
		
		q = hsession.createQuery("FROM Conto WHERE id = :id");
		q.setString("id", id);
		
		request.setAttribute("conto", q.list().get(0));
		
		nextview = "/bilancio/bilancio_conti_scheda.jsp";
	}

	private void pageConti(HttpServletRequest request, HttpServletResponse response) {
		
		Query q = hsession.createQuery("FROM Contogruppo");
		request.setAttribute("listaconti", q.list());
		
		nextview = "/bilancio/bilancio_conti_main.jsp";
	}
	
	private void generaBilancio(HttpServletRequest request, HttpServletResponse response, boolean popup) throws ParseException {
		
		String what = request.getParameter("what");
		String anno = request.getParameter("anno");
		String dalStr = request.getParameter("dal");
		String alStr = request.getParameter("al");
		String bilancio = "";
		
		Query q = null;
		
		if(what.equals("anno"))
		{
			String dal = anno + "-01-01";
			String al = anno + "-12-31";
			bilancio = "Anno " + anno;  
			
			q = hsession.createQuery("FROM Scrittura WHERE data >= :dal AND data <= :al ORDER BY data");
			q.setString("dal", dal);
			q.setString("al", al);
		}
		else if(what.equals("periodo"))
		{
			SimpleDateFormat sdf = new SimpleDateFormat ("dd/MM/yyyy");
			Date dal = new Date(sdf.parse(dalStr).getTime());
			Date al = new Date(sdf.parse(alStr).getTime());
			SimpleDateFormat sdfDB = new SimpleDateFormat ("yyyy-MM-dd");
			bilancio = "dal " + dalStr + " al " + alStr;
			
			q = hsession.createQuery("FROM Scrittura WHERE data >= :dal AND data <= :al ORDER BY data");
			q.setString("dal", sdfDB.format(dal));
			q.setString("al", sdfDB.format(al));
		}
		
		List scritture = q.list();
		List conti = new ArrayList();
		List costi = new ArrayList();
		List ricavi = new ArrayList();
		List attivita = new ArrayList();
		List passivita = new ArrayList();
		float totalecosti = 0;
		float totalericavi = 0;
		float totaleattivita = 0;
		float totalepassivita = 0;
		
		q = hsession.createQuery("FROM Contogruppo");
		conti = q.list();
		
		int gruppo_prev = -1;
		int tipo_prev = -1;
		List gruppo = new ArrayList();
		float totalegruppo = 0;
		
		for(int i=0;i < conti.size();i ++)
		{
			ContogruppoId cg = ((Contogruppo) conti.get(i)).getId();
			int tipocg = cg.getTipo().intValue();
			int gruppocg = cg.getGruppo().intValue();
			
			if(gruppocg == gruppo_prev)
			{
				//System.out.println("GRUPPOUGUALE\n\t" + cg.getNomegruppo() + "\n\t\t" + cg.getNomeconto());
				totalegruppo = addConto(scritture, cg, gruppo, totalegruppo);
			}
			else
			{
				//System.out.println("GRUPPODIVERSO\n\t" + cg.getNomegruppo() + "\n\t\t" + cg.getNomeconto() + "\n\t\t\t" + gruppo.size() + " " +tipo_prev);
				if(gruppo.size() > 0)
				{
					if(tipo_prev == 1)
					{
						costi.add(gruppo);
						totalecosti += totalegruppo;
					}
					else if(tipo_prev == 2)
					{
						ricavi.add(gruppo);
						totalericavi += totalegruppo;
					}
					else if(tipo_prev == 3)
					{
						attivita.add(gruppo);
						totaleattivita += totalegruppo;
					}
					else
					{
						passivita.add(gruppo);
						totalepassivita += totalegruppo;
					}
				}
				
				gruppo = new ArrayList();
				totalegruppo = 0;
				totalegruppo = addConto(scritture, cg, gruppo, totalegruppo);
				
				if(i == conti.size()-1)
				{
					if(gruppo.size() > 0)
					{
						if(tipocg == 1)
						{
							costi.add(gruppo);
							totalecosti += totalegruppo;
						}
						else if(tipocg == 2)
						{
							ricavi.add(gruppo);
							totalericavi += totalegruppo;
						}
						else if(tipocg == 3)
						{
							attivita.add(gruppo);
							totaleattivita += totalegruppo;
						}
						else
						{
							passivita.add(gruppo);
							totalepassivita += totalegruppo;
						}
					}
				}
			}
			
			gruppo_prev = gruppocg;
			tipo_prev = tipocg;
		}
		
		request.setAttribute("costi", costi);
		request.setAttribute("totalecosti", new Float(totalecosti));
		request.setAttribute("ricavi", ricavi);
		request.setAttribute("totalericavi", new Float(totalericavi));
		request.setAttribute("attivita", attivita);
		request.setAttribute("totaleattivita", new Float(totaleattivita));
		request.setAttribute("passivita", passivita);
		request.setAttribute("totalepassivita", new Float(totalepassivita));
		request.setAttribute("bilancio", bilancio);
		
		if(popup)
			nextview = "/bilancio/bilancio_stampa.jsp";
		else
			nextview = "/bilancio/bilancio.jsp";
	}

	private float addConto(List scritture, ContogruppoId cg, List gruppo, float totalegruppo) {
		
		float totaleconto = 0;
		String[] conto = new String[4];
		for(int y = 0; y < scritture.size(); y++)
		{
			Scrittura s = (Scrittura) scritture.get(y);
			int dare = s.getDare().getId().intValue();
			int avere = s.getAvere().getId().intValue();
			int tipo = cg.getTipo().intValue();
			
			if(dare == cg.getId().intValue())
			{
				if((tipo == 1)||(tipo == 3))
				{
					totaleconto += s.getImporto();
				}
				else
				{
					totaleconto -= s.getImporto();
				}
			}
			if(avere == cg.getId().intValue())
			{
				if((tipo == 1)||(tipo == 3))
				{
					totaleconto -= s.getImporto();
				}
				else
				{
					totaleconto += s.getImporto();
				}
			}
		}
		totalegruppo = totalegruppo + totaleconto;
		
		if(totaleconto != 0)
		{
			conto[0] = cg.getNomegruppo();
			conto[1] = cg.getNomeconto();
			conto[2] = new Float(totaleconto).toString();
			conto[3] = new Float(totalegruppo).toString();
			
			//System.out.println(totalegruppo +" = " + totalegruppo + " + " + totaleconto);
			
			gruppo.add(conto);
		}
			return totalegruppo;
		
	}

}
