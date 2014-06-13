package controller.sito;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.*;
import javax.servlet.http.*;

import mapping.*;

import org.hibernate.*;
import org.hibernate.cfg.Configuration;

import eccezioni.LoginException;

import system.*;

public class NewsCtrl extends HttpServlet{

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
			String page = request.getParameter("page");
			
			if (action == null)
				action = "insert";
			if(page == null)
				page = "page";
			
			Users u = (Users) sessione.getAttribute("user");	
			
			if (u == null) {
				throw new LoginException();
			}
			else if(u.getTipo().intValue() < 0)
			{
				throw new LoginException();
			}
			
			if(action.equals("insert"))
			{
				if(page.equals("page"))
					nextview = "/sito/news_new.jsp";
				else if(page.equals("insert"))
					insert(request, response);
			}
			else if(action.equals("showeventi"))
				nextview = "/sito/eventi_new.jsp";
			else if(action.equals("insertevento"))
				insertEvento(request, response);
				
		} catch (LoginException e) {
			
			Avviso err = new Avviso (e.getMessage());
			request.setAttribute("err", err);
			nextview = "/./error.jsp";

		} catch (Exception e) {
			
			Avviso err = new Avviso ("Errore indefinito. Non usare il pulsante REFRESH!");
			request.setAttribute("err", err);
			e.printStackTrace();
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

	private void insertEvento(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		
		String dataStr = request.getParameter("data");
		String titolo = request.getParameter("titolo");
		String luogo = request.getParameter("luogo");
		String ora = request.getParameter("ora");
		
		SimpleDateFormat sdf = new SimpleDateFormat ("dd/MM/yyyy");
		Date data = new Date(sdf.parse(dataStr).getTime());
		
		Eventi e = new Eventi();
		
		e.setData(data);
		e.setTitolo(titolo);
		e.setLuogo(luogo);
		e.setOra(ora);
		
		Query q = hsession.createQuery("FROM News where id = :id");
		q.setString("id", "0");
		News n = (News)q.list().get(0);
		
		e.setNews(n);
		
		hsession.save(e);
		
		tx.commit();
		
		Avviso err = new Avviso ("EVENTO INSERITO CORRETTAMENTE!");
		request.setAttribute("err", err);
		
		nextview = "/sito/eventi_new.jsp";
	}

	private void insert(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		
		String dataStr = request.getParameter("data");
		String titolo = request.getParameter("titolo");
		String sottotitolo = request.getParameter("sottotitolo");
		String testo = request.getParameter("testo");
		
		SimpleDateFormat sdf = new SimpleDateFormat ("dd/MM/yyyy");
		Date data = new Date(sdf.parse(dataStr).getTime());
		
		News n = new News();
		
		n.setData(data);
		n.setTitolo(titolo);
		n.setSottotitolo(sottotitolo);
		n.setTesto(testo);
		
		Query q = hsession.createQuery("FROM Categorienews where id = :id");
		q.setString("id", "1");
		Categorienews cn = (Categorienews)q.list().get(0);
		
		n.setHome("1");
		n.setCategorienews(cn);
		
		hsession.save(n);
		
		tx.commit();
		
		Avviso err = new Avviso ("NEWS INSERITA CORRETTAMENTE!");
		request.setAttribute("err", err);
		
		nextview = "/sito/news_new.jsp";
	}

}
