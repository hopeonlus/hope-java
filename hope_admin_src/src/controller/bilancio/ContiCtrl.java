package controller.bilancio;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.swing.text.DefaultEditorKit.InsertContentAction;

import mapping.*;

import org.hibernate.*;
import org.hibernate.cfg.Configuration;

import eccezioni.ContoException;
import eccezioni.GruppoException;
import eccezioni.LoginException;

import system.*;

public class ContiCtrl extends HttpServlet{

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
				action = "view";
			if (what == null)
				what = "conti";
			
			if(action.equals("view"))
			{
				if(what.equals("conti"))
				{
					pageConti(request, response);
				}
				else if(what.equals("gruppi"))
				{
					pageGruppi(request, response);
				}
			}
			else if(action.equals("del"))
			{
				if(what.equals("conti"))
				{
					delConto(request, response);
				}
				else if(what.equals("gruppi"))
				{
					delGruppi(request, response);
				}
			}
			else if(action.equals("new"))
			{
				if(what.equals("conti"))
				{
					newConto(request, response);
				}
				else if(what.equals("gruppi"))
				{
					newGruppo(request, response);
				}
			}
			else if(action.equals("insert"))
			{
				if(what.equals("conti"))
				{
					insertConto(request, response);
				}
				else if(what.equals("gruppi"))
				{
					insertGruppo(request, response);
				}
			}
			else if(action.equals("mostra"))
			{
				mostra(request, response);
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

	private void mostra(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		String mostra = request.getParameter("mostra");
		
		Query q = hsession.createQuery("FROM Conto WHERE id = :id");
		q.setString("id", id);
		Conto c = (Conto) q.list().get(0);
		if(mostra.equals("true"))
			c.setMostra(true);
		else
			c.setMostra(false);
		hsession.saveOrUpdate(c);
		tx.commit();
		
		pageConti(request, response);
	}

	private void insertGruppo(HttpServletRequest request, HttpServletResponse response) {
		
		String nome = request.getParameter("nome");
		String tipo = request.getParameter("tipo");
		
		Query q = hsession.createQuery("FROM Gruppo WHERE nome = :nome AND tipo = :tipo");
		q.setString("nome", nome);
		q.setString("tipo", tipo);
		
		try {
			if(q.list().size() > 0)
				throw new GruppoException("ERRORE! Esiste già un gruppo con lo stesso nome e dello stesso tipo.");
			else
			{
				Gruppo g = new Gruppo();
				g.setNome(nome);
				g.setTipo(new Integer(tipo));
				
				hsession.saveOrUpdate(g);
				tx.commit();
				
				pageGruppi(request, response);
			}
		} catch (GruppoException ex){
			
			Avviso err = new Avviso (ex.getMessage());
			request.setAttribute("err", err);
			
			nextview = "/bilancio/gruppi_new.jsp?nome=" + nome + "&tipo=" + tipo;
		}
	}

	private void insertConto(HttpServletRequest request, HttpServletResponse response) {
		
		String nome = request.getParameter("nome");
		String gruppoid = request.getParameter("gruppo");
		
		Query q = hsession.createQuery("FROM Conto WHERE nome = :nome AND gruppo = :gruppo");
		q.setString("nome", nome);
		q.setString("gruppo", gruppoid);
		
		try{
			if(q.list().size() > 0)
				throw new ContoException("ERRORE! Esiste già un Conto con questo nome nello stesso gruppo");
			else
			{
				q = hsession.createQuery("FROM Gruppo WHERE id = :id");
				q.setString("id", gruppoid);
				Gruppo gruppo = (Gruppo) q.list().get(0);
				
				Conto c = new Conto();
				c.setNome(nome);
				c.setGruppo(gruppo);
				c.setMostra(true);
				
				hsession.saveOrUpdate(c);
				tx.commit();
				
				pageConti(request, response);
			}
		}catch (Exception ex) {
			
			Avviso err = new Avviso (ex.getMessage());
			request.setAttribute("err", err);
			
			q = hsession.createQuery("FROM Gruppo ORDER BY Tipo, Nome");
			request.setAttribute("listagruppi", q.list());
			
			nextview = "/bilancio/conti_new.jsp?nome=" + nome + "&gruppo=" + gruppoid;
		}
		
	}

	private void newGruppo(HttpServletRequest request, HttpServletResponse response) {
		
		nextview = "/bilancio/gruppi_new.jsp";
	}

	private void newConto(HttpServletRequest request, HttpServletResponse response) {
		
		Query q = hsession.createQuery("FROM Gruppo ORDER BY Tipo, Nome");
		request.setAttribute("listagruppi", q.list());
		
		nextview = "/bilancio/conti_new.jsp";
	}

	private void delGruppi(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		
		try
		{
			Query q = hsession.createQuery("FROM Gruppibloccati WHERE id = :id");
			q.setString("id", id);
			
			if(q.list().size() > 0)
				throw new GruppoException();
			else
			{
				q = hsession.createQuery("FROM Gruppo WHERE id = :id");
				q.setString("id", id);
				
				Gruppo g = (Gruppo) q.list().get(0);
				hsession.delete(g);
				tx.commit();	
			}
		}
		catch (GruppoException ex)
		{
				Avviso err = new Avviso (ex.getMessage());
				request.setAttribute("err", err);
		}

		pageGruppi(request, response);
	}

	private void delConto(HttpServletRequest request, HttpServletResponse response){
		
		String id = request.getParameter("id");
		
		try
		{
			Query q = hsession.createQuery("FROM Scrittura WHERE (dare = :id1 OR avere = :id2)");
			q.setString("id1", id);
			q.setString("id2", id);
			
			if(q.list().size() > 0)
				throw new ContoException();
			else
			{
				q = hsession.createQuery("FROM Conto WHERE id = :id");
				q.setString("id", id);
				
				Conto c = (Conto) q.list().get(0);
				hsession.delete(c);
				tx.commit();
			}
		}
		catch (Exception ex)
		{
				Avviso err = new Avviso (ex.getMessage());
				request.setAttribute("err", err);
		}

		pageConti(request, response);
	}

	private void pageGruppi(HttpServletRequest request, HttpServletResponse response) {
		
		Query q = hsession.createQuery("FROM Gruppo");
		request.setAttribute("listagruppi", q.list());
		
		nextview = "/bilancio/gruppi_main.jsp";
	}

	private void pageConti(HttpServletRequest request, HttpServletResponse response) {

		Query q = hsession.createQuery("FROM Contogruppo");
		request.setAttribute("listaconti", q.list());
		
		nextview = "/bilancio/conti_main.jsp";
	}

}
