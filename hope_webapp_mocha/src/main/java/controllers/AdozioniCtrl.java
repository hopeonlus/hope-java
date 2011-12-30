/*
 * Created on 9-set-2005
 *
 * To change the template for this generated file go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
package controllers;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;


import mapping.High;
import org.hibernate.*;

import system.*;

public class AdozioniCtrl extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	
	HttpSession sessione = null; 
	Session hsession = null; 
	String nextview = "";
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		controller (request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		controller (request, response);
		
	}
	

	private void controller(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		
		hsession = HibernateUtil.currentSession();
		sessione = request.getSession();
		
		nextview = "/adozioni.jsp";
		
		setHighAndEventi(request, response);
		
		HibernateUtil.closeSession();
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextview);
		if (dispatcher != null)
			dispatcher.forward(request, response);
		
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