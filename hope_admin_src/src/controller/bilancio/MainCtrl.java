package controller.bilancio;

import java.io.IOException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;

import mapping.*;

import org.hibernate.*;
import org.hibernate.cfg.Configuration;

import eccezioni.LoginException;

import system.*;

public class MainCtrl extends HttpServlet{

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
		
			if (action == null)
				action = "home";
			
			/*if(action.equals("login"))
				login(request, response);*/
			
			Users u = (Users) sessione.getAttribute("user");	
			
			if (u == null) {
				throw new LoginException();
			}
			else if(u.getTipo().intValue() < 2)
			{
				throw new LoginException();
			}
			
			if(action.equals("home"))
				accedi(request, response);
			else if(action.equals("chiudi"))
				chiudiBilancio(request, response);
			


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

	private void chiudiBilancio(HttpServletRequest request, HttpServletResponse response) {
		
		String page = request.getParameter("page");
		String anno = request.getParameter("anno");
		
		if(page.equals("1"))
		{
			nextview = "/bilancio/chiudi_bilancio.jsp?anno=" + anno;
		}
		else
		{
			Query q = hsession.createQuery("FROM Anno WHERE anno = :anno");
			q.setString("anno", anno);
			
			Anno a = (Anno) q.list().get(0);
			a.setChiuso(true);
			
			hsession.saveOrUpdate(a);
			
			tx.commit();
			
			accedi(request, response);
		}
	}

	private void accedi(HttpServletRequest request, HttpServletResponse response) {
		
		Query q = hsession.createQuery("FROM Anno ORDER BY anno");
		request.setAttribute("listaanni", q.list());
		
		nextview = "/bilancio/home.jsp";
	}


	/*private void login(HttpServletRequest request, HttpServletResponse response) throws IOException, LoginException {
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		try{
			Query q = hsession.createQuery("FROM User WHERE username = :u AND password = :p");
			q.setString("u", username);
			q.setString("p", password);
			
			List tmp = q.list();
			
			if(tmp.size() != 1)
				throw new LoginException();
			else
			{
				User u = (User) tmp.get(0);
				sessione.setAttribute("user", u);
				
				accedi(request, response);
			}
		}catch (LoginException ex) {

			Avviso err = new Avviso (ex.getMessage());
			request.setAttribute("err", err);
			
			nextview = "/bilancio/index.jsp";
		}

	}*/

}
