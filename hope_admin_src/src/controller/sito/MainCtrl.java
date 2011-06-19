package controller.sito;

import java.io.IOException;

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
		
		try {
			
			hsession = HibernateUtil.currentSession();		
			sessione = request.getSession();
			tx = hsession.beginTransaction();
					
			String action = request.getParameter("action");
			String what = request.getParameter("what");
			
			if(what == null)
				what = "home";
			
			Users u = (Users) sessione.getAttribute("user");	
			
			if (u == null) {
				throw new LoginException();
			}
			else if(u.getTipo().intValue() < 0)
			{
				throw new LoginException();
			}
			
			if(action == null)
					nextview = "/sito/" + what.toLowerCase() + ".jsp";
			else if(action.equals("home"))
					accedi(request, response);

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

	private void accedi(HttpServletRequest request, HttpServletResponse response) {
		
		nextview = "/sito/home.jsp";
	}

}
