package controller.soci;

import java.awt.Color;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mapping.Anagrafe;
import mapping.Famiglia;
import mapping.Users;

import org.hibernate.Query;
import org.hibernate.Session;

import system.Avviso;
import system.HibernateUtil;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.HeaderFooter;
import com.lowagie.text.PageSize;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfPageEventHelper;
import com.lowagie.text.pdf.PdfWriter;

import eccezioni.LoginException;

public class StampaCtrl extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Session hsession = null;
	private HttpSession sessione = null;
	private String nextview = "";
	private List printed = new ArrayList();
	
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
					
			String action = request.getParameter("action");
		
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
		System.out.println("tete 1");	
			if(action.equals("page"))
				accedi(request, response);
			else if(action.equals("stampa"))
				stampa(request, response);

		} catch (LoginException e) {
			
			Avviso err = new Avviso (e.getMessage());
			request.setAttribute("err", err);
			nextview = "/./error.jsp";

		} catch (Exception e) {
			
			Avviso err = new Avviso ("Errore indefinito. Ricorda di non usare il pulsante \"Aggiorna\"");
			request.setAttribute("err", err);
			System.out.println(e.getMessage());
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

	private void stampa(HttpServletRequest request, HttpServletResponse response) {
		
		String what = request.getParameter("what");
		String whatT = request.getParameter("whatT");
		String anno = "";
		String annob = request.getParameter("annob");
		String annoT = "";
		
		String nome_file = "anagrafe";
		
		String page = request.getParameter("page");
		
		if(what.equals("soci"))
			anno = request.getParameter("anno");
		else if(what.equals("adottanti"))
			anno = request.getParameter("annoa");
		
		if(whatT.equals("soci"))
			annoT = request.getParameter("annoT");
		else if(whatT.equals("adottanti"))
			annoT = request.getParameter("annoaT");
		
		boolean where = false;
		boolean setanno = false;
		boolean setanno2 = false;
	System.out.println("tete 2");	
		if(!what.equals("bambini"))
		{
			String query = "FROM Anagrafe ";
			
			if(what.equals("soci"))
			{
				nome_file = "soci";
				if(!anno.equals(""))
				{
					query += "WHERE (id IN (SELECT s.anagrafe FROM Socio s, Pagamentosoci p WHERE p.anno = :anno AND s.tessera = p.socio))";
					setanno = true;
					nome_file += "_anno" + anno;
				}
				else
					query += "WHERE (id IN (SELECT anagrafe FROM Socio))";
				
				where = true;
			}
			else if(what.equals("adottanti"))
			{
				nome_file = "adottanti";
				if(!anno.equals(""))
				{
					nome_file += "_anno" + anno;
					query += "WHERE (id IN (SELECT anagrafe FROM Adottanti WHERE anno = :anno))";
					setanno = true;
					
				}
				else
					query += "WHERE (id IN (SELECT anagrafe FROM Adottanti))";
				
				where = true;
			}
			
			if(!whatT.equals("nessuno"))
			{
				if(where)
					query += " AND (id NOT IN ";
				else
					query += "WHERE (id NOT IN ";
				
				if(whatT.equals("soci"))
				{
					nome_file += "_TRANNE_soci";
					if(!annoT.equals(""))
					{
						nome_file += "_anno" + annoT;
						query += "(SELECT s.anagrafe FROM Socio s, Pagamentosoci p WHERE p.anno = :anno2 AND s.tessera = p.socio))";
						setanno2 = true;
					}
					else
						query += "(SELECT anagrafe FROM Socio))";
				}
				else if(whatT.equals("adottanti"))
				{
					nome_file += "_TRANNE_adottanti";
					if(!annoT.equals(""))
					{
						nome_file += "_anno"+ annoT;
						query += "(SELECT anagrafe FROM Adottanti WHERE anno = :anno2))";
						setanno2 = true;
					}
					else
						query += "(SELECT anagrafe FROM Adottanti))";
				}
			}
			
			if(where)
				query += " AND";
			else
				query += " WHERE";
			query += " (comunicazioni = :comunicazioni)";
		
			if((page.equals("etichette"))||(page.equals("buste")))
				query += " ORDER BY posta, cognome, nome";
			else
				query += " ORDER BY cognome, nome";
				
			System.out.println(query);
			
			Query q = hsession.createQuery(query);
			if(setanno)
				q.setString("anno", anno);
			if(setanno2)
				q.setString("anno2", annoT);
			q.setBoolean("comunicazioni", true);
			
			List lista = q.list();
			
			System.out.println(lista.size());
			
			Random r = new Random();
			
			if(page.equals("etichette"))
				creaPdfEtichette(request, response, lista, nome_file += "_ETICH_" + r.nextInt(999999) + ".pdf");
			else if(page.equals("elenco"))
				creaPdfElenco(request, response, lista, nome_file += "_ELENCO_" + r.nextInt(999999) + ".pdf", nome_file);
			else if(page.equals("buste"))
				creaPdfBuste(request, response, lista, nome_file += "_BUSTE_" + r.nextInt(999999) + ".pdf");
			
			nextview = "/soci/pdf/" + nome_file;
		}
		else
		{
			//pensato nel caso si voglia aggiungere la stampa dei bambini!(per adesso no)
			String query = "FROM Bambinoannoview";
			nome_file = "bambini";
			
			if(!annob.equals(""))
			{
				query += " WHERE anno = :anno ORDER BY nome";
				nome_file += "_anno" + annob;
			}
			else
			{
				query += " ORDER BY nome";
				nome_file += "_tutti";
			}
			
			Query q = hsession.createQuery(query);
			if(!annob.equals(""))
				q.setString("anno", annob);
		}
	}

	private void accedi(HttpServletRequest request, HttpServletResponse response) {
		
		nextview = "/soci/stampa.jsp";
	}

	private void creaPdfEtichette(HttpServletRequest request, HttpServletResponse response, List ListaSoci, String nome_file) {
		
        Document document = new Document(PageSize.A4);
        boolean found = false;
        int cells = 0;
       
        System.out.println("tete " + nome_file); 
        try
        {
        	FileOutputStream fos = new FileOutputStream("/tmp/admin/soci/pdf/" + nome_file);
            PdfWriter.getInstance(document, fos);
            
            document.setMargins(0, 0, 8, 8);
            document.addAuthor("tete");
            document.addSubject("HOPE");
            document.open();

            PdfPTable table = new PdfPTable(3);
            
            table.setWidthPercentage(100);
	        
	        for(int i = 0; i < ListaSoci.size(); i++)
	        {
	        	if((i == 0)&&(!((Anagrafe)ListaSoci.get(i)).isPosta()))
	        	{
	        		String testo = "DA CONSEGNARE A MANO --->";
	     	           
	        	    PdfPCell cell = new PdfPCell(new Phrase(testo , FontFactory.getFont(FontFactory.HELVETICA, 15, Font.BOLD)));
	        	    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	        	    cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	        	    cell.setBorder(0);
	        	    cell.setFixedHeight(103);
	        	    cell.setPaddingLeft(20);
	        	    cell.setPaddingRight(10);
	        	    table.addCell(cell);
	        	    
	        	    cells++;
	        	}
	        	
        	   if((cells%24 == 0)&&(i > 0))
        	   {
        		   document.add(table);
        		   
                   table = new PdfPTable(3);
                   
                   table.setWidthPercentage(100);
	       	        
	       	       document.newPage();
        	   }
	            
        	  Anagrafe s = ((Anagrafe)ListaSoci.get(i));
        	   
        	   if((s.isPosta())&&(!found))
        	   {
        		   String testo = "DA SPEDIRE PER POSTA --->";
     	           
	        	   PdfPCell cell = new PdfPCell(new Phrase(testo , FontFactory.getFont(FontFactory.HELVETICA, 15, Font.BOLD)));
	        	   cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	        	   cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	        	   cell.setBorder(0);
	        	   cell.setFixedHeight(103);
	        	   cell.setPaddingLeft(20);
	        	   cell.setPaddingRight(10);
	        	   table.addCell(cell);
	        	   
	        	   found = true;
	        	   cells++;
        	   }
        	   
        	   if(!alreadyPrinted(s.getId()))
        	   {
		           String testo = getTesto(s, ListaSoci);
		           
		           PdfPCell cell = new PdfPCell(new Phrase(testo , FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
		           cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		           cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		           cell.setBorder(0);
		           cell.setFixedHeight(103);
		           cell.setPaddingLeft(20);
		           cell.setPaddingRight(10);
		           table.addCell(cell);

		           cells++;
        	   } 
           }
	        
	        System.out.println(cells + "resto = " + cells%3);
	        int resto = (cells)%3;
	        
	        PdfPCell cell = new PdfPCell(new Phrase("" , FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
        	cell.setHorizontalAlignment(Element.ALIGN_LEFT);
        	cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
 	        cell.setBorder(0);
 	        cell.setFixedHeight(102);
 	        cell.setPaddingLeft(20);
 	        cell.setPaddingRight(10);
 	        
 	        if(resto == 1)
 	        {
	 	       table.addCell(cell);
	 	       table.addCell(cell);
 	        }
	        if(resto == 0)
	        {
	 	        table.addCell(cell);
	 	    }
	        
	        if(resto == 2)
	        {
	        	
	        }
	        
	        if(cells%24 != 0)
	        	document.add(table);
           				
        }
        catch(DocumentException de) {
        	de.printStackTrace();
			Avviso err = new Avviso (de.getMessage());
			request.setAttribute("err", err);
			nextview = "/errore.jsp";
        }
        catch(IOException ioe) {
        	ioe.printStackTrace();
			Avviso err = new Avviso (ioe.getMessage());
			request.setAttribute("err", err);
			nextview = "/errore.jsp";
        } catch (Exception e) {
			e.printStackTrace();
		}
            
        document.close();
        
        printed = new ArrayList();
	}
	
	private void creaPdfBuste(HttpServletRequest request, HttpServletResponse response, List ListaSoci, String nome_file){
		
		Document document = new Document(PageSize.A4.rotate());
        
        try
        {
        	FileOutputStream fos = new FileOutputStream("/tmp/admin/soci/pdf/" + nome_file);
            PdfWriter.getInstance(document, fos);
            
            document.setMargins(600, 0, 140, 0);
            //document.setMargins(left, right, top, bottom);
            document.addAuthor("tete");
            document.addSubject("HOPE");
            document.open();
            
            for(int i = 0; i < ListaSoci.size(); i++)
	        {
	            Anagrafe s = ((Anagrafe)ListaSoci.get(i));
	            
	            if(!alreadyPrinted(s.getId()))
	        	{
		            PdfPTable table = new PdfPTable(1);
		            table.setWidthPercentage(100);
		            
		            String testo = getTesto(s, ListaSoci);
		        	   
		            Font f = new Font(FontFactory.getFont(FontFactory.HELVETICA, 12, Font.NORMAL));
		            f.setColor(Color.BLACK);
			        Phrase ph = new Phrase(testo , f);
			        PdfPCell cell = new PdfPCell(ph);
			        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
			        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			        cell.setBorder(0);
			        cell.setFixedHeight(103);
			        cell.setPaddingLeft(20);
			        cell.setPaddingRight(10);
			        table.addCell(cell);
			        
			        document.add(table);
			        
			        document.newPage();
	        	}
	        }
           				
        }
        catch(DocumentException de) {
			Avviso err = new Avviso (de.getMessage());
			request.setAttribute("err", err);
			nextview = "/errore.jsp";
        }
        catch(IOException ioe) {
			Avviso err = new Avviso (ioe.getMessage());
			request.setAttribute("err", err);
			nextview = "/errore.jsp";
        }
            
        document.close();
        
        printed = new ArrayList();
	}
	
	private void creaPdfElenco(HttpServletRequest request, HttpServletResponse response, List ListaSoci, String nome_file, String titolo) {

        Document document = new Document(PageSize.A4.rotate());
        
        try
        {
        	FileOutputStream fos = new FileOutputStream("/tmp/admin/soci/pdf/" + nome_file);
            PdfWriter writer = PdfWriter.getInstance(document, fos);
            writer.setPageEvent(new MyPageEvent(titolo));
            
            document.setHeader(new HeaderFooter(new Phrase(titolo, FontFactory.getFont(FontFactory.HELVETICA, 8, Font.BOLD)), false));
            document.setFooter(new HeaderFooter(new Phrase("pag. " + (writer.getPageNumber() + 1), FontFactory.getFont(FontFactory.HELVETICA, 8, Font.BOLD)), false));
            //document.setMargins(10, 10, 10, 10);
            document.addAuthor("tete");
            document.addSubject("HOPE");
            document.open();

            PdfPTable table = new PdfPTable(8);
            table.setWidthPercentage(100);
            int[] cols = {18, 18, 25, 7, 15, 14, 25, 19};
            table.setWidths(cols);
	        
	        PdfPCell cell = new PdfPCell(new Phrase("Cognome" , FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
	        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	        cell.setBorder(1);
	        cell.setBackgroundColor(new Color(150, 150, 150));
	        table.addCell(cell);
	        
	        cell = new PdfPCell(new Phrase("Nome" , FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
	        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	        cell.setBorder(1);
	        cell.setBackgroundColor(new Color(150, 150, 150));
	        table.addCell(cell);
	        
	        cell = new PdfPCell(new Phrase("Indirizzo" , FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
	        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	        cell.setBorder(1);
	        cell.setBackgroundColor(new Color(150, 150, 150));
	        table.addCell(cell);
	        
	        cell = new PdfPCell(new Phrase("CAP" , FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
	        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	        cell.setBorder(1);
	        cell.setBackgroundColor(new Color(150, 150, 150));
	        table.addCell(cell);
	        
	        cell = new PdfPCell(new Phrase("Città" , FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
	        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	        cell.setBorder(1);
	        cell.setBackgroundColor(new Color(150, 150, 150));
	        table.addCell(cell);
	          
	        cell = new PdfPCell(new Phrase("Telefono" , FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
	        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	        cell.setBorder(1);
	        cell.setBackgroundColor(new Color(150, 150, 150));
	        table.addCell(cell);
	        
	        cell = new PdfPCell(new Phrase("E-mail" , FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
	        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	        cell.setBorder(1);
	        cell.setBackgroundColor(new Color(150, 150, 150));
	        table.addCell(cell);
	        
	        cell = new PdfPCell(new Phrase("Cod. Fiscale" , FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
	        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	        cell.setBorder(1);
	        cell.setBackgroundColor(new Color(150, 150, 150));
	        table.addCell(cell);
	        
	        for(int i = 0; i < ListaSoci.size(); i++)
	        {	        	
	        	Anagrafe s = ((Anagrafe)ListaSoci.get(i));
	           
	           cell = new PdfPCell(new Phrase(s.getCognome() , FontFactory.getFont(FontFactory.HELVETICA, 8, Font.NORMAL)));
	           cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	           cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	           cell.setBorder(1);
	           table.addCell(cell);
	           
	           cell = new PdfPCell(new Phrase(s.getNome(), FontFactory.getFont(FontFactory.HELVETICA, 8, Font.NORMAL)));
	           cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	           cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	           cell.setBorder(1);
	           table.addCell(cell);
	           
	           cell = new PdfPCell(new Phrase(s.getIndirizzo() , FontFactory.getFont(FontFactory.HELVETICA, 8, Font.NORMAL)));
	           cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	           cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	           cell.setBorder(1);
	           table.addCell(cell);
	           
	           cell = new PdfPCell(new Phrase(s.getCap() , FontFactory.getFont(FontFactory.HELVETICA, 8, Font.NORMAL)));
	           cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	           cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	           cell.setBorder(1);
	           table.addCell(cell);
	           
	           cell = new PdfPCell(new Phrase(s.getCitta() , FontFactory.getFont(FontFactory.HELVETICA, 8, Font.NORMAL)));
	           cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	           cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	           cell.setBorder(1);
	           table.addCell(cell);
	           
	           cell = new PdfPCell(new Phrase(s.getTelefono() , FontFactory.getFont(FontFactory.HELVETICA, 8, Font.NORMAL)));
	           cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	           cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	           cell.setBorder(1);
	           table.addCell(cell);
	           
	           cell = new PdfPCell(new Phrase(s.getEmail() , FontFactory.getFont(FontFactory.HELVETICA, 8, Font.NORMAL)));
	           cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	           cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	           cell.setBorder(1);
	           table.addCell(cell);
	           
	           cell = new PdfPCell(new Phrase(s.getCodfiscale() , FontFactory.getFont(FontFactory.HELVETICA, 8, Font.NORMAL)));
	           cell.setHorizontalAlignment(Element.ALIGN_LEFT);
	           cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	           cell.setBorder(1);
	           table.addCell(cell);
	           	         
           }
	        
	        document.add(table);
           				
        }
        catch(DocumentException de) {
			Avviso err = new Avviso (de.getMessage());
			request.setAttribute("err", err);
			nextview = "/errore.jsp";
        }
        catch(IOException ioe) {
			Avviso err = new Avviso (ioe.getMessage());
			request.setAttribute("err", err);
			nextview = "/errore.jsp";
        }
            
        document.close();
	}
	
	private String getTesto(Anagrafe s, List ListaSoci) {
		
		String testo = s.getCognome() + " " + s.getNome();
		
		printed.add(s.getId());
		
		Query q = hsession.createQuery("FROM Anagrafe WHERE id = :id");
		q.setString("id", s.getId().toString());
		
		Anagrafe nome1 = (Anagrafe) q.list().get(0);
		
		Iterator it1 = nome1.getFamigliasForId1().iterator();
		Iterator it2 = nome1.getFamigliasForId2().iterator();
		
		while(it1.hasNext())
		{
			Famiglia f1 = (Famiglia) it1.next();
			if(inLista(f1.getAnagrafeById2().getId(), ListaSoci))
			{
				if(!alreadyPrinted(f1.getAnagrafeById2().getId()))
				{
					//System.out.println("getTesto --> scrivo " + f1.getAnagrafeById2().getCognome() + f1.getAnagrafeById2().getNome());
					testo += ",\n" + f1.getAnagrafeById2().getCognome() + " " + f1.getAnagrafeById2().getNome();
					printed.add(f1.getAnagrafeById2().getId());
					//System.out.println("getTesto --> " + f1.getAnagrafeById2().getId() + " added!\n" + testo);
				}
			}
			testo = checkTree(f1.getAnagrafeById2(), ListaSoci, testo);
		}
		while(it2.hasNext())
		{
			Famiglia f2 = (Famiglia) it2.next();
			if(inLista(f2.getAnagrafeById1().getId(), ListaSoci))
			{
				if(!alreadyPrinted(f2.getAnagrafeById1().getId()))
				{
					//System.out.println("getTesto --> scrivo " + f2.getAnagrafeById1().getCognome() + f2.getAnagrafeById1().getNome());
					testo += ",\n" + f2.getAnagrafeById1().getCognome() + " " + f2.getAnagrafeById1().getNome();
					printed.add(f2.getAnagrafeById1().getId());
					//System.out.println("getTesto --> " + f2.getAnagrafeById1().getId() + " added!\n" + testo);					
				}
			}
			testo = checkTree(f2.getAnagrafeById1(), ListaSoci, testo);
		}
		
        testo += "\n" + s.getIndirizzo();
        testo += "\n" + s.getCap() + " " + s.getCitta();
		
        if(!s.isPosta())
        	testo += " #";
        	
		return testo;
	}

	private String checkTree(Anagrafe nome, List ListaSoci, String testo) {
		
		Iterator it1 = nome.getFamigliasForId1().iterator();
		Iterator it2 = nome.getFamigliasForId2().iterator();
		
		while(it1.hasNext())
		{
			Famiglia f1 = (Famiglia) it1.next();
			if(inLista(f1.getAnagrafeById2().getId(), ListaSoci))
			{
				if(!alreadyPrinted(f1.getAnagrafeById2().getId()))
				{
					//System.out.println("checkTree --> scrivo " + f1.getAnagrafeById2().getCognome() + f1.getAnagrafeById2().getNome());
					testo += ",\n" + f1.getAnagrafeById2().getCognome() + " " + f1.getAnagrafeById2().getNome();
					printed.add(f1.getAnagrafeById2().getId());
					//System.out.println("checkTree --> " + f1.getAnagrafeById2().getId() + " added!\n" + testo);
				}
			}
			testo = checkTree1(f1.getAnagrafeById2(), ListaSoci, testo);
		}
		
		while(it2.hasNext())
		{
			Famiglia f2 = (Famiglia) it2.next();
			if(inLista(f2.getAnagrafeById1().getId(), ListaSoci))
			{
				if(!alreadyPrinted(f2.getAnagrafeById1().getId()))
				{
					//System.out.println("checkTree --> scrivo " + f2.getAnagrafeById1().getCognome() + f2.getAnagrafeById1().getNome());
					testo += ",\n" + f2.getAnagrafeById1().getCognome() + " " + f2.getAnagrafeById1().getNome();
					printed.add(f2.getAnagrafeById1().getId());
					//System.out.println("checkTree --> " + f2.getAnagrafeById1().getId() + " added!\n" + testo);
				}
			}
			testo = checkTree1(f2.getAnagrafeById1(), ListaSoci, testo);
		}
		
		return testo;
	}
	
	private String checkTree1(Anagrafe nome, List ListaSoci, String testo) {
		
		Iterator it1 = nome.getFamigliasForId1().iterator();
		Iterator it2 = nome.getFamigliasForId2().iterator();
		
		while(it1.hasNext())
		{
			Famiglia f1 = (Famiglia) it1.next();
			if(inLista(f1.getAnagrafeById2().getId(), ListaSoci))
			{
				if(!alreadyPrinted(f1.getAnagrafeById2().getId()))
				{
					//System.out.println("checkTree --> scrivo " + f1.getAnagrafeById2().getCognome() + f1.getAnagrafeById2().getNome());
					testo += ",\n" + f1.getAnagrafeById2().getCognome() + " " + f1.getAnagrafeById2().getNome();
					printed.add(f1.getAnagrafeById2().getId());
					//System.out.println("checkTree --> " + f1.getAnagrafeById2().getId() + " added!\n" + testo);
				}
			}
			testo = checkTree2(f1.getAnagrafeById2(), ListaSoci, testo);
		}
		
		while(it2.hasNext())
		{
			Famiglia f2 = (Famiglia) it2.next();
			if(inLista(f2.getAnagrafeById1().getId(), ListaSoci))
			{
				if(!alreadyPrinted(f2.getAnagrafeById1().getId()))
				{
					//System.out.println("checkTree --> scrivo " + f2.getAnagrafeById1().getCognome() + f2.getAnagrafeById1().getNome());
					testo += ",\n" + f2.getAnagrafeById1().getCognome() + " " + f2.getAnagrafeById1().getNome();
					printed.add(f2.getAnagrafeById1().getId());
					//System.out.println("checkTree --> " + f2.getAnagrafeById1().getId() + " added!\n" + testo);
				}
			}
			testo = checkTree2(f2.getAnagrafeById1(), ListaSoci, testo);
		}
		
		return testo;
	}
	
	private String checkTree2(Anagrafe nome, List ListaSoci, String testo) {
		
		Iterator it1 = nome.getFamigliasForId1().iterator();
		Iterator it2 = nome.getFamigliasForId2().iterator();
		
		while(it1.hasNext())
		{
			Famiglia f1 = (Famiglia) it1.next();
			if(inLista(f1.getAnagrafeById2().getId(), ListaSoci))
			{
				if(!alreadyPrinted(f1.getAnagrafeById2().getId()))
				{
					//System.out.println("checkTree --> scrivo " + f1.getAnagrafeById2().getCognome() + f1.getAnagrafeById2().getNome());
					testo += ",\n" + f1.getAnagrafeById2().getCognome() + " " + f1.getAnagrafeById2().getNome();
					printed.add(f1.getAnagrafeById2().getId());
					//System.out.println("checkTree --> " + f1.getAnagrafeById2().getId() + " added!\n" + testo);
				}
			}
		}
		
		while(it2.hasNext())
		{
			Famiglia f2 = (Famiglia) it2.next();
			if(inLista(f2.getAnagrafeById1().getId(), ListaSoci))
			{
				if(!alreadyPrinted(f2.getAnagrafeById1().getId()))
				{
					//System.out.println("checkTree --> scrivo " + f2.getAnagrafeById1().getCognome() + f2.getAnagrafeById1().getNome());
					testo += ",\n" + f2.getAnagrafeById1().getCognome() + " " + f2.getAnagrafeById1().getNome();
					printed.add(f2.getAnagrafeById1().getId());
					//System.out.println("checkTree --> " + f2.getAnagrafeById1().getId() + " added!\n" + testo);
				}
			}
		}
		
		return testo;
	}

	private boolean inLista(Integer id, List listaSoci) {
		
		for(int i = 0; i < listaSoci.size(); i++)
		{
			Anagrafe s = ((Anagrafe)listaSoci.get(i));
			if(s.getId().intValue() == id.intValue())
				return true;
		}
		
		return false;
	}

	private boolean alreadyPrinted(Integer id) {
		
		for(int i = 0; i < printed.size(); i++)
		{
			if(((Integer)printed.get(i)).intValue() == id.intValue())
				return true;
		}
		
		return false;
	}

	private class MyPageEvent extends PdfPageEventHelper{
		
		String titolo = "";
		
		public MyPageEvent(String tit){
			super();
			titolo = tit;
		}
		
		public void onStartPage(PdfWriter writer, Document document) {
			
			document.resetHeader();
			document.setFooter(new HeaderFooter(new Phrase("pag. " + (writer.getPageNumber() + 1), FontFactory.getFont(FontFactory.HELVETICA, 8, Font.BOLD)), false));
		}
	}

}
