/*
 * Created on 9-set-2005
 *
 * To change the template for this generated file go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
package controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mapping.High;
import mapping.News;
import mapping.Newsimg;

import org.hibernate.Query;
import org.hibernate.Session;
import system.HibernateUtil;

public class NewsCtrl extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	
	HttpSession sessione = null; 
	Session hsession = null; 
	String nextview = "";
	String pag = "";
	static int n_per_pag = 15; // 15 risultati per pagina;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		controller (request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		controller (request, response);
		
	}
	

	private void controller(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		
		//new Configuration().configure().buildSessionFactory();
		hsession = HibernateUtil.currentSession();
		sessione = request.getSession();
		
		String action = request.getParameter("action");
		String what = request.getParameter("what");
		pag = request.getParameter("pag");
		
		if(action == null){
			action = "SHOW";
		}
		if(what == null){
			what = "ALL";
		}
		
		if (action.equals("SHOW"))
		{
			if(what.equals("NEWS"))
			{
				generaNews(request, response);
			}
			else if(what.equals("ALL"))
			{
				generaTutte(request, response);
			}
		}
		
		setHighAndEventi(request, response);
		
		HibernateUtil.closeSession();
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextview);
		if (dispatcher != null)
			dispatcher.forward(request, response);
		
	}


	private void generaImg(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		String n_img = request.getParameter("n_img");
		
		Query q = hsession.createQuery("FROM Newsimg WHERE idnews = :id");
		q.setString("id", id);
		List param = q.list();
		List id_img = new ArrayList();
		
		for(int i = 0; i < param.size(); i++)
		{
			id_img.add(((Newsimg)param.get(i)).getId().getIdimg().toString());
		}
		int totImg = param.size();
		
		if(id_img.size() > 0)
		{
			q = hsession.createQuery("FROM Immagini WHERE Id in (:lista)");
			q.setParameterList("lista", id_img);
			
			List ListaImg = new ArrayList();
			
			if (n_img == null)
			{	
				ListaImg = q.list();
			}
			else
			{
				int corrente = Integer.parseInt(n_img);
				q.setFirstResult((corrente - 1));
				q.setMaxResults(1);
				ListaImg = q.list();
				
				if(ListaImg != null){
					if(corrente > 1){
						String prev = Integer.toString(corrente - 1);
						request.setAttribute("prev", prev);
					}
					if(corrente < totImg){
						String next = Integer.toString(corrente + 1);
						request.setAttribute("next", next);
					}
				}
			}
			
			request.setAttribute("totImg", Integer.toString(totImg));
			request.setAttribute("ListaImg", ListaImg);
		}

	}

	private void generaTutte(HttpServletRequest request, HttpServletResponse response) {
		
		Query q = hsession.createQuery("FROM News ORDER BY data DESC");
		int Tutte = q.list().size();
		int totPag = 0;
		
		if((Tutte%n_per_pag) == 0)
			totPag = (Tutte)/n_per_pag;
		else
		{
			totPag = Tutte/n_per_pag + 1;
		}
		
		request.setAttribute("totPag", Integer.toString(totPag));
		
		if (pag == null) {
			pag = "1";
		}
		
		int corrente = Integer.parseInt(pag);
		q.setFirstResult((corrente - 1) * n_per_pag);
		q.setMaxResults(n_per_pag);
		
		List data = q.list();
		
		if(data != null){
			
			if(corrente > 1){
				String prev = Integer.toString(corrente - 1);
				request.setAttribute("prev", prev);
			}
			if(corrente < totPag){
				String next = Integer.toString(corrente + 1);
				request.setAttribute("next", next);
			}
		}
		
		List imgs = new ArrayList();
		
		for(int i = 0; i < data.size(); i++)
		{
			String id = ((News) data.get(i)).getId().toString();
			q = hsession.createQuery("FROM Newsimg WHERE idnews = :id");
			q.setString("id", id);
			
			List tmp = q.list();
			String id_img = "";
			
			if(tmp.size() == 0)
				id_img = "0";
			else
				id_img = ((Newsimg) tmp.get(0)).getId().getIdimg().toString();
			
			q = hsession.createQuery("FROM Immagini WHERE id = :id");
			q.setString("id", id_img);
			Object img = q.list().get(0);
			imgs.add(img);
		
		}
		
		request.setAttribute("dati", data);
		request.setAttribute("img", imgs);
		
		nextview = "/archivio_news.jsp";
	}

	private void generaNews(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		Query q = hsession.createQuery("FROM News WHERE id = :id");
		q.setString("id", id);
		List data = q.list();
		
		if(data != null)
		{			
			
			q = hsession.createQuery("FROM Newsimg WHERE idnews = :id");
			q.setString("id", id);
			List img = q.list();
			List imgs = new ArrayList();
			
			if(img.size() == 0)
			{
				q = hsession.createQuery("FROM Immagini WHERE id = :id");
				q.setString("id", "0");
				imgs = q.list();
			}
			else
			{
				for(int i = 0; i < img.size(); i++)
				{
					String tmp = ((Newsimg) img.get(i)).getId().getIdimg().toString();
					q = hsession.createQuery("FROM Immagini WHERE id = :id");
					q.setString("id", tmp);
					List tmp2 = q.list();
					imgs.add(tmp2.get(0));
				}
			}
			
			request.setAttribute("img", imgs);
			request.setAttribute("dati", data.get(0));
		}
		
		generaImg(request, response);
		
		nextview = "/news.jsp";
	}
	
	private void setHighAndEventi(HttpServletRequest request, HttpServletResponse response) {

		//Imposta gli highlights
		Query q = hsession.createQuery("FROM High WHERE visibile = :v");
		q.setString("v", "1");
		List tmp = q.list();
		String high = "";
		
		for(int i = 0; i < tmp.size(); i++)
		{
			High tmp1 = (High) tmp.get(i);	
			
			Date d = tmp1.getData();
			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("dd-MM-yyyy");
			String data = formatter.format(d);
					
			high += "- " + data + " -<BR>" + tmp1.getTesto() + "<BR><BR><BR>";
		}
		
		request.setAttribute("high", high);
		
		//Imposta gli eventi!
		String mese = request.getParameter("mese");
		String anno = request.getParameter("anno");
		
		int anno_int = 0;
		
		if(mese == null)
			mese = new Integer(new GregorianCalendar().get(Calendar.MONTH) + 1).toString();
		else
		{
			int mese_int = new Integer(mese).intValue();
			anno_int = new Integer(anno).intValue(); 
			
			if(mese_int == 12)
			{
				mese_int = 0;
				anno_int = anno_int + 1;
			}
			if(mese_int == -1)
			{
				mese_int = 11;
				anno_int = anno_int - 1;
			}
			
			mese = new Integer(mese_int + 1).toString();
		}
		
		if(anno == null)
			anno = new Integer(new GregorianCalendar().get(Calendar.YEAR)).toString();
		else
			anno = new Integer(anno_int).toString();
		
		if(Integer.parseInt(mese) < 10)
			mese = "0" + mese;
		
		String dalStr = anno + "-" + mese + "-01";
		String alStr = anno + "-" + mese +"-31";
		
		q = hsession.createQuery("FROM Eventi WHERE data >= :dalStr AND data <= :alStr");
		q.setString("dalStr", dalStr);
		q.setString("alStr", alStr);
		
		tmp = q.list();
		
		request.setAttribute("eventi", tmp);
		
	}
	
}