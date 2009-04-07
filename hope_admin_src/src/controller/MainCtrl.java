package controller;

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
		
		new Configuration().configure().buildSessionFactory();

		try {
			
			hsession = HibernateUtil.currentSession();		
			sessione = request.getSession();
			tx = hsession.beginTransaction();
					
			String action = request.getParameter("action");
			String what = request.getParameter("what");
		
			if (action == null)
				action = "home";
			
			if(what == null)
				what = "users";
			
			if(action.equals("login"))
				login(request, response);
			
			Users u = (Users) sessione.getAttribute("user");	
			
			if (u == null) {
				throw new LoginException();
			}
			
			if(action.equals("home"))
				accedi(request, response);
			else if(action.equals("logout"))
				logout(request, response);
			else if(action.equals("password"))
				password(request, response);
			else if(action.equals("ctrl"))
			{
				if(u.getTipo().intValue() < 3)
				{
					throw new LoginException();
				}
				if(what.equals("users"))
					pageUsers(request, response);
				else if(what.equals("deluser"))
					delUser(request, response);
				else if(what.equals("new"))
					nextview = "/users_new.jsp";
				else if(what.equals("insert"))
					insertUser(request, response);
				else if(what.equals("edit"))
					editUser(request, response);
				else if(what.equals("save"))
					saveUser(request, response);
			}

		} catch (LoginException e) {
			
			Avviso err = new Avviso (e.getMessage());
			request.setAttribute("err", err);
			nextview = "/index.jsp";

		} catch (Exception e) {
			
			String st = "";
			StackTraceElement[] ste = e.getStackTrace();
			for(int i = 0; i< ste.length; i++)
				st += ste[i].toString() + "<BR>";
			
			Avviso err = new Avviso ("ERRORE INDEFINITOOOOOOO: \"" + e.getMessage() + "\"<BR>STACK TRACE:<BR>" + st);
			request.setAttribute("err", err);
			System.out.println(e.getMessage());
			e.printStackTrace();
			nextview = "/error.jsp";
			
			String st1 = "jufewiuhjnfkeoihubjnkojihubjnkopijhubjnklpijhujbnjhujb";

		} finally {
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextview);
			if (dispatcher != null) {
				response.encodeURL(nextview);
				dispatcher.forward(request, response);
			}
			HibernateUtil.closeSession();
			
		}
		
	}

	private void saveUser(HttpServletRequest request, HttpServletResponse response) {
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String tipo = request.getParameter("tipo");
		
		Query q = hsession.createQuery("FROM Users WHERE username = :id");
		q.setString("id", username);
		
		Users u = (Users) q.list().get(0);
		
		u.setPassword(password);
		u.setTipo(new Integer(tipo));
		
		hsession.saveOrUpdate(u);
		
		tx.commit();
		
		pageUsers(request, response);
	}

	private void editUser(HttpServletRequest request, HttpServletResponse response) {
		
		String username = request.getParameter("username");
		
		Query q = hsession.createQuery("FROM Users WHERE username = :id");
		q.setString("id", username);
		
		request.setAttribute("user_edit", q.list().get(0));
		
		nextview = "/users_edit.jsp";
	}

	private void insertUser(HttpServletRequest request, HttpServletResponse response) {
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String tipo = request.getParameter("tipo");
		
		try{
						
			Query q = hsession.createQuery("FROM Users WHERE username = :id");
			q.setString("id", username);
			
			if(q.list().size() > 0)
			{
				throw new Exception("Username <B>" + username + "</B> già usato!");
			}
			
			Users u = new Users();
			u.setUsername(username);
			u.setPassword(password);
			u.setTipo(new Integer(tipo));
			
			hsession.saveOrUpdate(u);
			
			tx.commit();
			
			pageUsers(request, response);
		
		}catch(Exception ex){
			
			Avviso err = new Avviso (ex.getMessage());
			request.setAttribute("err", err);
			
			nextview = "/users_new.jsp";
		}
	}

	private void delUser(HttpServletRequest request, HttpServletResponse response) {
		
		String user = request.getParameter("user");
		
		Query q = hsession.createQuery("FROM Users WHERE username = :id");
		q.setString("id", user);
		
		Users u = (Users) q.list().get(0);
		
		hsession.delete(u);
		
		tx.commit();
		
		pageUsers(request, response);
	}

	private void pageUsers(HttpServletRequest request, HttpServletResponse response) {
		
		Query q = hsession.createQuery("FROM Users ORDER BY username");
		
		request.setAttribute("users", q.list());
		
		nextview = "/users_main.jsp";
		
		//SendMail.sendMail("smtp.libero.it", "zanitete@gmail.com", "prova da java!", "messaggio di prova da javA!tiscali!", "c://01.jpg", "zanitete@libero.it", "zanitete@libero.it" );
	}

	private void password(HttpServletRequest request, HttpServletResponse response) {
		
		String what = request.getParameter("what");
		
		if(what.equals("page"))
			nextview = "/cambia_password.jsp";
		else
		{
			String oldpwd = request.getParameter("oldpwd");
			String newpwd = request.getParameter("newpwd");
			
			try{
				Users u = (Users) sessione.getAttribute("user");
				String username = u.getUsername();
				
				Query q = hsession.createQuery("FROM Users WHERE username = :u AND password = :p");
				q.setString("u", username);
				q.setString("p", oldpwd);
				
				List tmp = q.list();
				
				if(tmp.size() != 1)
					throw new LoginException();
				else
				{
					sessione.removeAttribute("user");
					
					Users u2 = (Users) tmp.get(0);
					u2.setPassword(newpwd);
					
					hsession.saveOrUpdate(u2);
					
					tx.commit();
					
					sessione.setAttribute("user", u2);
					
					accedi(request, response);
				}
			}catch (LoginException ex) {

				Avviso err = new Avviso ("Password attuale non corretta!");
				request.setAttribute("err", err);
				
				nextview = "/cambia_password.jsp";
			}
		}
		
	}

	private void accedi(HttpServletRequest request, HttpServletResponse response) {
		
		//Users u = (Users) sessione.getAttribute("user");

		nextview = "/home.jsp";
			
	}

	private void logout(HttpServletRequest request, HttpServletResponse response) {
		
		sessione.removeAttribute("user");
		
		nextview = "/index.jsp";
	}
	

	private void login(HttpServletRequest request, HttpServletResponse response) throws IOException, LoginException {
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		try{
			Query q = hsession.createQuery("FROM Users WHERE username = :u AND password = :p");
			q.setString("u", username);
			q.setString("p", password);
			
			List tmp = q.list();
			
			if(tmp.size() != 1)
				throw new LoginException();
			else
			{
				Users u = (Users) tmp.get(0);
				sessione.setAttribute("user", u);
				
				accedi(request, response);
			}
		}catch (LoginException ex) {

			Avviso err = new Avviso (ex.getMessage());
			request.setAttribute("err", err);
			
			nextview = "/index.jsp";
		}

	}

}
