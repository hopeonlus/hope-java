package controller.soci;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;

import mapping.*;

import org.hibernate.*;
import org.hibernate.cfg.Configuration;

import eccezioni.LoginException;

import system.*;

public class AnagrafeCtrl extends HttpServlet{

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
		String a = request.getParameter("action");
		if((a!= null)&&(a.equals("refresh")))
		{
			refreshData(request, response);
		} else {
			controller (request, response);
		}
		
	}
	
	public void controller (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		hsession = new Configuration().configure().buildSessionFactory().openSession();

		try {
			
			hsession = HibernateUtil.currentSession();		
			sessione = request.getSession();
			tx = hsession.beginTransaction();
					
			String action = request.getParameter("action");
			String what = request.getParameter("what");
			
			if (action == null)
				action = "page";
			
			
			Users u = (Users) sessione.getAttribute("user");	
			
			if (u == null) {
				throw new LoginException();
			}
			else if(u.getTipo().intValue() < 1)
			{
				throw new LoginException();
			}
			
			if(action.equals("page"))
				pageAnagrafe(request, response);
			else if(action.equals("view"))
			{
				viewScheda(request, response);
			}
			else if(action.equals("edit"))
			{
				editScheda(request, response);
			}
			else if(action.equals("del"))
			{
				delScheda(request, response);
			}
			else if(action.equals("famiglia"))
			{
				if(what.equals("del"))
					delFamiglia(request, response);
				else if(what.equals("add"))
					addFamiglia(request, response);
			}


		} catch (LoginException e) {
			
			Avviso err = new Avviso (e.getMessage());
			request.setAttribute("err", err);
			nextview = "/./error.jsp";

		} catch (Exception e) {
			
			Avviso err = new Avviso ("Errore indefinito. Ricorda di non usare il tasto REFRESH di Explorer!");
			request.setAttribute("err", err);
			e.printStackTrace();
			System.out.println(e.getMessage());
			nextview = "/./error.jsp";
			
		} finally {

			HibernateUtil.closeSession();
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextview);
			if (dispatcher != null) {
				response.encodeURL(nextview);
				dispatcher.forward(request, response);
			}
			
		}
		
	}

	private void addFamiglia(HttpServletRequest request, HttpServletResponse response) {
		
		String id1 = request.getParameter("id1");
		String id2 = request.getParameter("id2");
		
		Query q = hsession.createQuery("FROM Anagrafe WHERE id = :id");
		q.setString("id", id1);
		
		Anagrafe a1 = (Anagrafe) q.list().get(0);
		
		q = hsession.createQuery("FROM Anagrafe WHERE id = :id");
		q.setString("id", id2);
		
		Anagrafe a2 = (Anagrafe) q.list().get(0);
		
		FamigliaId fid = new FamigliaId();
		
		fid.setId1(new Integer(id1));
		fid.setId2(new Integer(id2));
		
		Famiglia f = new Famiglia(fid);
		f.setAnagrafeById1(a1);
		f.setAnagrafeById2(a2);
		
		hsession.saveOrUpdate(f);
		
		tx.commit();
		
		viewScheda(request, response);
	}

	private void delFamiglia(HttpServletRequest request, HttpServletResponse response) {
		
		String id1 = request.getParameter("id1");
		String id2 = request.getParameter("id2");
		
		Query q = hsession.createQuery("FROM Famiglia WHERE id1 = :id1 AND id2 = :id2");
		q.setString("id1", id1);
		q.setString("id2", id2);
		
		Famiglia f = (Famiglia) q.list().get(0);
		
		hsession.delete(f);
		
		tx.commit();
		
		viewScheda(request, response);
	}

	private void delScheda(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		
		Query q = hsession.createQuery("FROM Anagrafe WHERE id = :id");
		q.setString("id", id);
		
		Anagrafe n = (Anagrafe) q.list().get(0);
		
		hsession.delete(n);
		
		tx.commit();
		
		pageAnagrafe(request, response);
	}

	private void editScheda(HttpServletRequest request, HttpServletResponse response) {
		
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
		String posta = request.getParameter("posta");
		
		String nextpage = request.getParameter("nextpage");
		
		Query q = hsession.createQuery("FROM Anagrafe WHERE id = :id");
		q.setString("id", id);
		
		Anagrafe n = (Anagrafe) q.list().get(0);
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
		n.setPosta(new Boolean(posta).booleanValue());
		
		hsession.saveOrUpdate(n);
		tx.commit();
		
		if(nextpage.equals("null"))
			pageAnagrafe(request, response);
		else
			nextview = "/" + nextpage;
	}

	private void viewScheda(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		
		Query q = hsession.createQuery("FROM Anagrafe WHERE id = :id");
		q.setString("id", id);
		
		request.setAttribute("nominativo", q.list().get(0));
		
		//non mi ricordo perchè!!
		q = hsession.createQuery("FROM Pagamenti WHERE id = :id");
		q.setString("id", id);
		List pagamenti = q.list();
		
		if(pagamenti.size() > 0)
			request.setAttribute("pagamenti", pagamenti);
		
		q = hsession.createQuery("FROM Anagrafe WHERE id != :id ORDER BY cognome, nome, citta");
		q.setString("id", id);
		
		request.setAttribute("anagrafe", q.list());
		
		nextview = "/soci/anagrafe_edit.jsp";
	}

	private void pageAnagrafe(HttpServletRequest request, HttpServletResponse response) {
		
		String orderby = request.getParameter("orderby");
		
		if(orderby == null)
		{
			orderby = "id";
		}
		
		Query q = hsession.createQuery("FROM Anagrafe ORDER BY " + orderby);
		
		request.setAttribute("listaNomi", q.list());
		
		nextview="/soci/anagrafe_main.jsp";
	}
	
	private void refreshData(HttpServletRequest request, HttpServletResponse response) {
		
		String id = (request.getParameter("id")).split("_")[0];
		String op = request.getParameter("operation") == null ? "" : request.getParameter("operation") ;
		
		if(op.equals("update")) {
			
			hsession = new Configuration().configure().buildSessionFactory().openSession();
			hsession = HibernateUtil.currentSession();		
			tx = hsession.beginTransaction();
			
			String name = request.getParameter("name");
			String value = request.getParameter("value");
			
			Query q = hsession.createQuery("FROM Anagrafe WHERE id = :id");
			q.setString("id", id);
			
			Anagrafe n = (Anagrafe) q.list().get(0);
			if(name.equals("nome"))
				n.setNome(value);
			else if(name.equals("cognome"))
				n.setCognome(value);
			else if(name.equals("indirizzo"))
				n.setIndirizzo(value);
			else if(name.equals("cap"))
				n.setCap(value);
			else if(name.equals("nazione"))
				n.setNazione(value);
			else if(name.equals("codfiscale"))
				n.setCodfiscale(value);
			else if(name.equals("citta"))
				n.setCitta(value);
			
			hsession.saveOrUpdate(n);
			tx.commit();

			HibernateUtil.closeSession();
			
			PrintWriter output;
			try {
				output = response.getWriter();
				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				output.print("<ok><id>" + id +"_"+ name + "</id><val>" + value + "</val></ok>");
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			
		} else if(op.equals("delete")) {

			hsession = new Configuration().configure().buildSessionFactory().openSession();
			hsession = HibernateUtil.currentSession();		
			tx = hsession.beginTransaction();

			Query q = hsession.createQuery("FROM Anagrafe WHERE id = :id");
			q.setString("id", id);
			
			Anagrafe n = (Anagrafe) q.list().get(0);
			
			hsession.delete(n);
			
			tx.commit();

			HibernateUtil.closeSession();
			
			PrintWriter output;
			try {
				output = response.getWriter();
				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				output.print("<ok><id>" + id + "</id><val>none</val></ok>");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

}
