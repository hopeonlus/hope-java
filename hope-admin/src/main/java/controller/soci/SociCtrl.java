package controller.soci;

import java.awt.Color;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mapping.Anagrafe;
import mapping.Famiglia;
import mapping.Pagamenti;
import mapping.PagamentiId;
import mapping.Pagamentosoci;
import mapping.Socio;
import mapping.Users;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import system.Avviso;
import system.HibernateUtil;
import util.cms.CMSUtil;
import util.word.WordDocumentProcessor;

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
import eccezioni.PagamentoException;

public class SociCtrl extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Session hsession = null;
	private HttpSession sessione = null;
	private String nextview = "";
	private List printed = new ArrayList();

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		controller(request, response);

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		controller(request, response);

	}

	public void controller(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		Transaction tx = null;
		try {

			hsession = HibernateUtil.currentSession();
			sessione = request.getSession();
			tx = hsession.beginTransaction();

			String action = request.getParameter("action");
			String page = request.getParameter("page");

			if (action == null)
				action = "page";

			Users u = (Users) sessione.getAttribute("user");

			if (u == null) {
				throw new LoginException();
			} else if (u.getTipo().intValue() < 1) {
				throw new LoginException();
			}

			if (action.equals("page"))
				pageSoci(request, response);
			else if (action.equals("select")) {
				selectSoci(request, response);
			} else if (action.equals("view")) {
				viewSocio(request, response);
			} else if (action.equals("delpagamento")) {
				delPagamento(request, response);
			} else if (action.equals("delsocio")) {
				delSocio(request, response);
			} else if (action.equals("insert")) {
				if (page.equals("first")) {
					pageInsert(request, response);
				} else if (page.equals("scheda")) {
					viewSocio(request, response);
				} else if (page.equals("pagamento")) {
					insertPagamento(request, response);
				} else if (page.equals("new")) {
					newSocio(request, response);
				} else if (page.equals("anagrafe")) {
					insertSocio(request, response);
				}
			} else if (action.equals("stampa")) {

				stampaSoci(request, response);
			} else if (action.equals("printletter")) {
				printThankYouLetter(request, response);
			}

			tx.commit();

		} catch (LoginException e) {

			Avviso err = new Avviso(e.getMessage());
			request.setAttribute("err", err);
			nextview = "/./error.jsp";
			tx.rollback();

		} catch (Exception e) {

			Avviso err = new Avviso("Errore indefinito. Ricorda di non usare il tasto REFRESH di Explorer!");
			request.setAttribute("err", err);
			e.printStackTrace();
			nextview = "/./error.jsp";
			tx.rollback();

		} finally {

			HibernateUtil.closeSession();
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextview);
			if (dispatcher != null) {
				if(nextview.endsWith(".pdf")) {
					String url = response.encodeRedirectURL("/admin" + nextview);
    				response.sendRedirect( url );
				} else {
					response.encodeURL(nextview);
					dispatcher.forward(request, response);
				}
			}

		}

	}

	private void newSocio(HttpServletRequest request, HttpServletResponse response) {

		String id = request.getParameter("id");

		if (id != null) {
			Query q = hsession.createQuery("FROM Anagrafe WHERE id = :id");
			q.setString("id", id);

			request.setAttribute("nominativo", q.list().get(0));
		}

		setSuggerisci(request);

		nextview = "/soci/soci_insert_new.jsp";
	}

	private void setSuggerisci(HttpServletRequest request) {

		Query q = hsession.createQuery("FROM Socio ORDER BY tessera");
		List soci = q.list();
		int i = 0;
		for (i = 0; i < soci.size(); i++) {
			Socio s = (Socio) soci.get(i);
			int tessera = s.getTessera().intValue();

			if (tessera != (i + 1)) {
				break;
			}
		}

		request.setAttribute("suggerisci", new Integer(i + 1).toString());
	}

	private void insertSocio(HttpServletRequest request, HttpServletResponse response) {

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

		Anagrafe n = new Anagrafe();

		try {
			String tessera = request.getParameter("tessera");

			if (!id.equals("")) {
				Query q = hsession.createQuery("FROM Anagrafe WHERE id = :id");
				q.setString("id", id);

				n = (Anagrafe) q.list().get(0);
			}

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

			Query q = hsession.createQuery("FROM Socio WHERE tessera = :t");
			q.setString("t", tessera);

			if (q.list().size() > 0) {
				setSuggerisci(request);
				throw new PagamentoException("Numero di tessera '" + tessera + "' gia' presente!");
			}

			hsession.saveOrUpdate(n);

			Socio s = new Socio();

			s.setAnagrafe(n);
			s.setTessera(new Integer(tessera));
			s.setNote("");

			hsession.saveOrUpdate(s);

			viewSocio(request, response);
		} catch (Exception ex) {

			Avviso err = new Avviso(ex.getMessage());
			request.setAttribute("err", err);

			request.setAttribute("nominativo", n);

			nextview = "/soci/soci_insert_new.jsp";
		}

	}

	private void insertPagamento(HttpServletRequest request, HttpServletResponse response) {

		String anno = request.getParameter("annop");
		String importo = request.getParameter("importo");
		String tessera = request.getParameter("tessera");

		try {
			Query q = hsession.createQuery("FROM Pagamentosoci WHERE anno = :a AND tessera = :t");
			q.setString("a", anno);
			q.setString("t", tessera);

			if (q.list().size() > 0) {
				throw new PagamentoException();
			}

			q = hsession.createQuery("FROM Socio WHERE tessera = :t");
			q.setString("t", tessera);

			Socio s = (Socio) q.list().get(0);

			Pagamentosoci ps = new Pagamentosoci();
			ps.setSocio(s);
			ps.setAnno(new Integer(anno));
			ps.setImporto(new Integer(importo));

			hsession.saveOrUpdate(ps);

		} catch (Exception ex) {

			Avviso err = new Avviso(ex.getMessage());
			request.setAttribute("err", err);
		}

		viewSocio(request, response);
	}

	private void pageInsert(HttpServletRequest request, HttpServletResponse response) {

		String what = request.getParameter("what");
		if (what == null)
			what = "null";
		String orderby = request.getParameter("orderby");
		if (orderby == null)
			orderby = "tessera";

		if (what.equals("null")) {
			Query q = hsession.createQuery("FROM Soci ORDER BY " + orderby);

			request.setAttribute("listasoci", q.list());

			q = hsession.createQuery("FROM Nonsoci ORDER BY cognome, nome");

			request.setAttribute("listanonsoci", q.list());
		} else if (what.equals("tessera")) {
			String tessera = request.getParameter("tessera");

			Query q = hsession.createQuery("FROM Soci WHERE tessera = :t ORDER BY " + orderby);
			q.setString("t", tessera);

			request.setAttribute("listasoci", q.list());
		} else if (what.equals("cognome")) {
			String cognome = request.getParameter("cognome");

			Query q = hsession.createQuery("FROM Soci WHERE cognome LIKE '%" + cognome + "%' ORDER BY " + orderby);

			request.setAttribute("listasoci", q.list());

			q = hsession.createQuery("FROM Nonsoci WHERE cognome LIKE '%" + cognome + "%' ORDER BY cognome, nome");

			request.setAttribute("listanonsoci", q.list());
		}

		nextview = "/soci/soci_insert_main.jsp";
	}

	private void delSocio(HttpServletRequest request, HttpServletResponse response) {

		String tessera = request.getParameter("tessera");
		String what = request.getParameter("what");

		Query q = hsession.createQuery("FROM Socio WHERE tessera = :tessera");
		q.setString("tessera", tessera);

		Socio s = (Socio) q.list().get(0);

		hsession.delete(s);

		if (what.equals("null"))
			pageInsert(request, response);
		else
			selectSoci(request, response);
	}

	private void delPagamento(HttpServletRequest request, HttpServletResponse response) {

		String idp = request.getParameter("idp");

		Query q = hsession.createQuery("FROM Pagamentosoci WHERE id = :idp");
		q.setString("idp", idp);

		Pagamentosoci ps = (Pagamentosoci) q.list().get(0);

		hsession.delete(ps);

		viewSocio(request, response);
	}

	private void viewSocio(HttpServletRequest request, HttpServletResponse response) {

		String tessera = request.getParameter("tessera");
		String page = request.getParameter("page");

		Query q = hsession.createQuery("FROM Pagamentosoci WHERE tessera = :id");
		q.setString("id", tessera);
		List pagamenti = q.list();

		request.setAttribute("pagamentosoci", pagamenti);

		q = hsession.createQuery("FROM Socio WHERE tessera = :t");
		q.setString("t", tessera);
		Object socio = q.list().get(0);

		request.setAttribute("socio", socio);

		if (page == null)
			nextview = "/soci/soci_edit.jsp";
		else if (page.equals("scheda"))
			nextview = "/soci/soci_edit_insert.jsp";
		else
			nextview = "/soci/soci_edit.jsp";
	}

	private void pageSoci(HttpServletRequest request, HttpServletResponse response) {

		nextview = "/soci/soci_select.jsp";
	}

	private void selectSoci(HttpServletRequest request, HttpServletResponse response) {

		String what = request.getParameter("what");
		String orderby = request.getParameter("orderby");
		if (orderby == null)
			orderby = "tessera";

		if (what.equals("tutti")) {
			Query q = hsession.createQuery("FROM Pagamenti ORDER BY " + orderby);

			request.setAttribute("listasoci", distinct(q.list()));
		} else if (what.equals("anno")) {
			String anno = request.getParameter("anno");

			Query q = hsession.createQuery("FROM Pagamenti WHERE anno = :anno ORDER BY " + orderby);
			q.setString("anno", anno);

			request.setAttribute("listasoci", q.list());
		} else if (what.equals("anni")) {
			String dal = request.getParameter("dal");
			String al = request.getParameter("al");

			Query q = hsession.createQuery("FROM Pagamenti WHERE anno >= :dal AND anno <= :al ORDER BY " + orderby);
			q.setString("dal", dal);
			q.setString("al", al);

			request.setAttribute("listasoci", distinct(q.list()));
		}

		nextview = "/soci/soci_main.jsp";
	}

	private void stampaSoci(HttpServletRequest request, HttpServletResponse response) {

		List ListaSoci = new ArrayList();

		String what = request.getParameter("what");
		String page = request.getParameter("page");

		String nome_file = "";
		String titolo = "";

		if (what.equals("tutti")) {
			Query q = null;

			if ((page.equals("etichette")) || (page.equals("buste")))
				q = hsession.createQuery("FROM Pagamenti ORDER BY posta, cognome, nome");
			else
				q = hsession.createQuery("FROM Pagamenti ORDER BY cognome, nome");

			ListaSoci = distinct(q.list());

			nome_file = page + "_soci_completo";
			titolo = "H.O.P.E.  -  Elenco Soci COMPLETO";
		} else if (what.equals("anno")) {
			String anno = request.getParameter("anno");
			Query q = null;

			if ((page.equals("etichette")) || (page.equals("buste")))
				q = hsession.createQuery("FROM Pagamenti WHERE anno = :anno ORDER BY posta, cognome, nome");
			else
				q = hsession.createQuery("FROM Pagamenti WHERE anno = :anno ORDER BY cognome, nome");

			q.setString("anno", anno);

			ListaSoci = q.list();

			nome_file = page + "_soci_" + anno;
			titolo = "H.O.P.E.  -  Elenco Soci ANNO " + anno;
		} else if (what.equals("anni")) {
			String dal = request.getParameter("dal");
			String al = request.getParameter("al");

			Query q = null;

			if ((page.equals("etichette")) || (page.equals("buste")))
				q = hsession.createQuery("FROM Pagamenti WHERE anno >= :dal AND anno <= :al ORDER BY posta, cognome, nome");
			else
				q = hsession.createQuery("FROM Pagamenti WHERE anno >= :dal AND anno <= :al ORDER BY cognome, nome");

			q.setString("dal", dal);
			q.setString("al", al);

			ListaSoci = distinct(q.list());

			nome_file = page + "_soci_" + dal + "_" + al;
			titolo = "H.O.P.E.  -  Elenco Soci ANNI dal " + dal + " al " + al;
		}

		Random r = new Random();

		nome_file += "_" + r.nextInt(999999) + ".pdf";

		if (page.equals("etichette"))
			creaPdfEtichette(request, response, ListaSoci, nome_file);
		else if (page.equals("elenco"))
			creaPdfElenco(request, response, ListaSoci, nome_file, titolo);
		else if (page.equals("buste"))
			creaPdfBuste(request, response, ListaSoci, nome_file);
		else if (page.equals("csv")) {
			nome_file = nome_file.replace("pdf", "csv");
			creaCsv(request, response, ListaSoci, nome_file);
		}

		nextview = "/soci/pdf/" + nome_file;

	}

	private void creaCsv(HttpServletRequest request, HttpServletResponse response, List listaSoci, String nomeFile) {

		FileOutputStream fos = null;

		try {
			List fileContent = new ArrayList();
			fileContent.add(new String[] { "Cognome", "Nome", "Indirizzo", "Cap", "Citta" });
			for (int i = 0; i < listaSoci.size(); i++) {
				PagamentiId record = ((Pagamenti) listaSoci.get(i)).getId();
				String[] x = new String[4];

				x[0] = record.getCognome() + " " + record.getNome();

				String tmp = (record.getIndirizzo() == null) ? "" : record.getIndirizzo();
				if (tmp.indexOf(",") != -1) {
					x[1] = record.getIndirizzo();
				} else {
					x[1] = record.getIndirizzo() + ",";
				}

				x[2] = record.getCap();
				x[3] = record.getCitta();

				fileContent.add(x);
			}

			fos = new FileOutputStream(StampaCtrl.TMP_FOLDER + nomeFile);

			for (int i = 0; i < fileContent.size(); i++) {
				String[] x = (String[]) fileContent.get(i);
				for (int j = 0; j < x.length; j++) {
					fos.write(x[j].getBytes());
					if ((j + 1) == x.length)
						fos.write("\n".getBytes());
					else
						fos.write(",".getBytes());
				}
			}

		} catch (Exception e) {
			System.out.println("ERROR in CSV EXPORT!!");
			e.printStackTrace();
		} finally {
			if (fos != null)
				try {
					fos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
		}

	}

	private void creaPdfEtichette(HttpServletRequest request, HttpServletResponse response, List ListaSoci, String nome_file) {

		Document document = new Document(PageSize.A4);
		boolean found = false;
		int cells = 0;

		try {
			FileOutputStream fos = new FileOutputStream(StampaCtrl.TMP_FOLDER + nome_file);
			PdfWriter.getInstance(document, fos);

			document.setMargins(0, 0, 8, 8);
			document.addAuthor("tete");
			document.addSubject("HOPE");
			document.open();

			PdfPTable table = new PdfPTable(3);

			table.setWidthPercentage(100);

			for (int i = 0; i < ListaSoci.size(); i++) {
				if ((i == 0) && (!((Pagamenti) ListaSoci.get(i)).getId().isPosta())) {
					String testo = "DA CONSEGNARE A MANO --->";

					PdfPCell cell = new PdfPCell(new Phrase(testo, FontFactory.getFont(FontFactory.HELVETICA, 15, Font.BOLD)));
					cell.setHorizontalAlignment(Element.ALIGN_LEFT);
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setBorder(0);
					cell.setFixedHeight(103);
					cell.setPaddingLeft(20);
					cell.setPaddingRight(10);
					table.addCell(cell);

					cells++;
				}

				if ((cells % 24 == 0) && (i > 0)) {
					document.add(table);

					table = new PdfPTable(3);

					table.setWidthPercentage(100);

					document.newPage();
				}

				PagamentiId s = ((Pagamenti) ListaSoci.get(i)).getId();

				if ((s.isPosta()) && (!found)) {
					String testo = "DA SPEDIRE PER POSTA --->";

					PdfPCell cell = new PdfPCell(new Phrase(testo, FontFactory.getFont(FontFactory.HELVETICA, 15, Font.BOLD)));
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

				if (!alreadyPrinted(s.getId())) {
					String testo = getTesto(s, ListaSoci);

					PdfPCell cell = new PdfPCell(new Phrase(testo, FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
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

			System.out.println(cells + "resto = " + cells % 3);
			int resto = (cells) % 3;

			PdfPCell cell = new PdfPCell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 10, Font.NORMAL)));
			cell.setHorizontalAlignment(Element.ALIGN_LEFT);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setBorder(0);
			cell.setFixedHeight(102);
			cell.setPaddingLeft(20);
			cell.setPaddingRight(10);

			if (resto == 1) {
				table.addCell(cell);
				table.addCell(cell);
			}
			if (resto == 0) {
				table.addCell(cell);
			}

			if ((resto != 2) || (cells % 24 != 0))
				document.add(table);

		} catch (DocumentException de) {
			Avviso err = new Avviso(de.getMessage());
			request.setAttribute("err", err);
			nextview = "/errore.jsp";
		} catch (IOException ioe) {
			Avviso err = new Avviso(ioe.getMessage());
			request.setAttribute("err", err);
			nextview = "/errore.jsp";
		}

		document.close();

		printed = new ArrayList();
	}

	private void creaPdfBuste(HttpServletRequest request, HttpServletResponse response, List ListaSoci, String nome_file) {

		Document document = new Document(PageSize.A4.rotate());

		try {
			FileOutputStream fos = new FileOutputStream(StampaCtrl.TMP_FOLDER + nome_file);
			PdfWriter.getInstance(document, fos);

			document.setMargins(600, 0, 140, 0);
			// document.setMargins(left, right, top, bottom);
			document.addAuthor("tete");
			document.addSubject("HOPE");
			document.open();

			for (int i = 0; i < ListaSoci.size(); i++) {
				PagamentiId s = ((Pagamenti) ListaSoci.get(i)).getId();

				if (!alreadyPrinted(s.getId())) {
					PdfPTable table = new PdfPTable(1);
					table.setWidthPercentage(100);

					String testo = getTesto(s, ListaSoci);

					Font f = new Font(FontFactory.getFont(FontFactory.HELVETICA, 12, Font.NORMAL));
					f.setColor(Color.BLACK);
					Phrase ph = new Phrase(testo, f);
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

		} catch (DocumentException de) {
			Avviso err = new Avviso(de.getMessage());
			request.setAttribute("err", err);
			nextview = "/errore.jsp";
		} catch (IOException ioe) {
			Avviso err = new Avviso(ioe.getMessage());
			request.setAttribute("err", err);
			nextview = "/errore.jsp";
		}

		document.close();

		printed = new ArrayList();
	}

	private void creaPdfElenco(HttpServletRequest request, HttpServletResponse response, List ListaSoci, String nome_file, String titolo) {

		Document document = new Document(PageSize.A4.rotate());

		try {
			FileOutputStream fos = new FileOutputStream(StampaCtrl.TMP_FOLDER + nome_file);
			PdfWriter writer = PdfWriter.getInstance(document, fos);
			writer.setPageEvent(new MyPageEvent(titolo));

			document.setHeader(new HeaderFooter(new Phrase(titolo, FontFactory.getFont(FontFactory.HELVETICA, 8, Font.BOLD)), false));
			document.setFooter(new HeaderFooter(new Phrase("pag. " + (writer.getPageNumber() + 1), FontFactory.getFont(
					FontFactory.HELVETICA, 8, Font.BOLD)), false));
			// document.setMargins(10, 10, 10, 10);
			document.addAuthor("tete");
			document.addSubject("HOPE");
			document.open();

			PdfPTable table = new PdfPTable(9);
			table.setWidthPercentage(100);
			int[] cols = { 6, 18, 18, 25, 7, 15, 14, 25, 19 };
			table.setWidths(cols);

			PdfPCell cell = new PdfPCell(new Phrase("Tess", FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
			cell.setHorizontalAlignment(Element.ALIGN_LEFT);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setBorder(1);
			cell.setBackgroundColor(new Color(150, 150, 150));
			table.addCell(cell);

			cell = new PdfPCell(new Phrase("Cognome", FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
			cell.setHorizontalAlignment(Element.ALIGN_LEFT);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setBorder(1);
			cell.setBackgroundColor(new Color(150, 150, 150));
			table.addCell(cell);

			cell = new PdfPCell(new Phrase("Nome", FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
			cell.setHorizontalAlignment(Element.ALIGN_LEFT);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setBorder(1);
			cell.setBackgroundColor(new Color(150, 150, 150));
			table.addCell(cell);

			cell = new PdfPCell(new Phrase("Indirizzo", FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
			cell.setHorizontalAlignment(Element.ALIGN_LEFT);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setBorder(1);
			cell.setBackgroundColor(new Color(150, 150, 150));
			table.addCell(cell);

			cell = new PdfPCell(new Phrase("CAP", FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
			cell.setHorizontalAlignment(Element.ALIGN_LEFT);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setBorder(1);
			cell.setBackgroundColor(new Color(150, 150, 150));
			table.addCell(cell);

			cell = new PdfPCell(new Phrase("Citta", FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
			cell.setHorizontalAlignment(Element.ALIGN_LEFT);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setBorder(1);
			cell.setBackgroundColor(new Color(150, 150, 150));
			table.addCell(cell);

			cell = new PdfPCell(new Phrase("Telefono", FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
			cell.setHorizontalAlignment(Element.ALIGN_LEFT);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setBorder(1);
			cell.setBackgroundColor(new Color(150, 150, 150));
			table.addCell(cell);

			cell = new PdfPCell(new Phrase("E-mail", FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
			cell.setHorizontalAlignment(Element.ALIGN_LEFT);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setBorder(1);
			cell.setBackgroundColor(new Color(150, 150, 150));
			table.addCell(cell);

			cell = new PdfPCell(new Phrase("Cod. Fiscale", FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
			cell.setHorizontalAlignment(Element.ALIGN_LEFT);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setBorder(1);
			cell.setBackgroundColor(new Color(150, 150, 150));
			table.addCell(cell);

			for (int i = 0; i < ListaSoci.size(); i++) {
				PagamentiId s = ((Pagamenti) ListaSoci.get(i)).getId();

				cell = new PdfPCell(new Phrase(s.getTessera().toString(), FontFactory.getFont(FontFactory.HELVETICA, 8, Font.NORMAL)));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setBorder(1);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(s.getCognome().toString(), FontFactory.getFont(FontFactory.HELVETICA, 8, Font.NORMAL)));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setBorder(1);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(s.getNome().toString(), FontFactory.getFont(FontFactory.HELVETICA, 8, Font.NORMAL)));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setBorder(1);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(s.getIndirizzo().toString(), FontFactory.getFont(FontFactory.HELVETICA, 8, Font.NORMAL)));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setBorder(1);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(s.getCap().toString(), FontFactory.getFont(FontFactory.HELVETICA, 8, Font.NORMAL)));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setBorder(1);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(s.getCitta().toString(), FontFactory.getFont(FontFactory.HELVETICA, 8, Font.NORMAL)));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setBorder(1);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(s.getTelefono().toString(), FontFactory.getFont(FontFactory.HELVETICA, 8, Font.NORMAL)));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setBorder(1);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(s.getEmail().toString(), FontFactory.getFont(FontFactory.HELVETICA, 8, Font.NORMAL)));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setBorder(1);
				table.addCell(cell);

				cell = new PdfPCell(new Phrase(s.getCodfiscale().toString(), FontFactory.getFont(FontFactory.HELVETICA, 8, Font.NORMAL)));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setBorder(1);
				table.addCell(cell);

			}

			document.add(table);

		} catch (DocumentException de) {
			Avviso err = new Avviso(de.getMessage());
			request.setAttribute("err", err);
			nextview = "/errore.jsp";
		} catch (IOException ioe) {
			Avviso err = new Avviso(ioe.getMessage());
			request.setAttribute("err", err);
			nextview = "/errore.jsp";
		}

		document.close();
	}

	private void creaPdfEtichetteNOvincoli(HttpServletRequest request, HttpServletResponse response, List ListaSoci, String nome_file) {

		Document document = new Document(PageSize.A4);

		try {
			FileOutputStream fos = new FileOutputStream(StampaCtrl.TMP_FOLDER + nome_file);
			PdfWriter.getInstance(document, fos);

			document.setMargins(0, 0, 8, 8);
			document.addAuthor("tete");
			document.addSubject("HOPE");
			document.open();

			PdfPTable table = new PdfPTable(3);
			/*
			 * table.setBorderWidth(0); table.setBorderColor(new Color(0, 0,
			 * 0)); table.setWidth(100); table.setPadding(17);
			 * table.setSpacing(0);
			 */
			table.setWidthPercentage(100);

			for (int i = 0; i < ListaSoci.size(); i++) {
				if ((i % 24 == 0) && (i > 0)) {
					document.add(table);

					table = new PdfPTable(3);
					/*
					 * table.setBorderWidth(0); table.setBorderColor(new
					 * Color(0, 0, 0)); table.setWidth(100);
					 * table.setPadding(17); table.setSpacing(0);
					 */
					table.setWidthPercentage(100);

					document.newPage();
				}

				PagamentiId s = ((Pagamenti) ListaSoci.get(i)).getId();

				String testo = s.getCognome() + " " + s.getNome();
				testo += "\n" + s.getIndirizzo();
				testo += "\n" + s.getCap() + " " + s.getCitta();

				PdfPCell cell = new PdfPCell(new Phrase(testo, FontFactory.getFont(FontFactory.HELVETICA, 12, Font.NORMAL)));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setBorder(0);
				cell.setFixedHeight(103);
				cell.setPaddingLeft(20);
				cell.setPaddingRight(10);
				table.addCell(cell);

			}
			int resto = ListaSoci.size() % 3;

			if (resto != 0) {
				PdfPCell cell = new PdfPCell(new Phrase("", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.NORMAL)));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				cell.setBorder(0);
				cell.setFixedHeight(102);
				cell.setPaddingLeft(20);
				cell.setPaddingRight(10);
				table.addCell(cell);

				if (resto == 1)
					table.addCell(cell);
			}

			if (ListaSoci.size() % 30 != 0)
				document.add(table);

		} catch (DocumentException de) {
			Avviso err = new Avviso(de.getMessage());
			request.setAttribute("err", err);
			nextview = "/errore.jsp";
		} catch (IOException ioe) {
			Avviso err = new Avviso(ioe.getMessage());
			request.setAttribute("err", err);
			nextview = "/errore.jsp";
		}

		document.close();
	}

	private String getTesto(PagamentiId s, List ListaSoci) {

		String testo = s.getCognome() + " " + s.getNome();
		System.out.println(s.getId());
		printed.add(s.getId());

		Query q = hsession.createQuery("FROM Anagrafe WHERE id = :id");
		q.setString("id", s.getId().toString());

		Anagrafe nome1 = (Anagrafe) q.list().get(0);

		Iterator it1 = nome1.getFamigliasForId1().iterator();
		Iterator it2 = nome1.getFamigliasForId2().iterator();

		while (it1.hasNext()) {
			Famiglia f1 = (Famiglia) it1.next();
			if (inLista(f1.getAnagrafeById2().getId(), ListaSoci)) {
				if (!alreadyPrinted(f1.getAnagrafeById2().getId())) {
					// System.out.println("getTesto --> scrivo " +
					// f1.getAnagrafeById2().getCognome() +
					// f1.getAnagrafeById2().getNome());
					testo += ",\n" + f1.getAnagrafeById2().getCognome() + " " + f1.getAnagrafeById2().getNome();
					printed.add(f1.getAnagrafeById2().getId());
					// System.out.println("getTesto --> " +
					// f1.getAnagrafeById2().getId() + " added!\n" + testo);
				}
			}
			testo = checkTree(f1.getAnagrafeById2(), ListaSoci, testo);
		}
		while (it2.hasNext()) {
			Famiglia f2 = (Famiglia) it2.next();
			if (inLista(f2.getAnagrafeById1().getId(), ListaSoci)) {
				if (!alreadyPrinted(f2.getAnagrafeById1().getId())) {
					// System.out.println("getTesto --> scrivo " +
					// f2.getAnagrafeById1().getCognome() +
					// f2.getAnagrafeById1().getNome());
					testo += ",\n" + f2.getAnagrafeById1().getCognome() + " " + f2.getAnagrafeById1().getNome();
					printed.add(f2.getAnagrafeById1().getId());
					// System.out.println("getTesto --> " +
					// f2.getAnagrafeById1().getId() + " added!\n" + testo);
				}
			}
			testo = checkTree(f2.getAnagrafeById1(), ListaSoci, testo);
		}

		testo += "\n" + s.getIndirizzo();
		testo += "\n" + s.getCap() + " " + s.getCitta();

		return testo;
	}

	private String checkTree(Anagrafe nome, List ListaSoci, String testo) {

		Iterator it1 = nome.getFamigliasForId1().iterator();
		Iterator it2 = nome.getFamigliasForId2().iterator();

		while (it1.hasNext()) {
			Famiglia f1 = (Famiglia) it1.next();
			if (inLista(f1.getAnagrafeById2().getId(), ListaSoci)) {
				if (!alreadyPrinted(f1.getAnagrafeById2().getId())) {
					// System.out.println("checkTree --> scrivo " +
					// f1.getAnagrafeById2().getCognome() +
					// f1.getAnagrafeById2().getNome());
					testo += ",\n" + f1.getAnagrafeById2().getCognome() + " " + f1.getAnagrafeById2().getNome();
					printed.add(f1.getAnagrafeById2().getId());
					// System.out.println("checkTree --> " +
					// f1.getAnagrafeById2().getId() + " added!\n" + testo);
				}
			}
			testo = checkTree1(f1.getAnagrafeById2(), ListaSoci, testo);
		}

		while (it2.hasNext()) {
			Famiglia f2 = (Famiglia) it2.next();
			if (inLista(f2.getAnagrafeById1().getId(), ListaSoci)) {
				if (!alreadyPrinted(f2.getAnagrafeById1().getId())) {
					// System.out.println("checkTree --> scrivo " +
					// f2.getAnagrafeById1().getCognome() +
					// f2.getAnagrafeById1().getNome());
					testo += ",\n" + f2.getAnagrafeById1().getCognome() + " " + f2.getAnagrafeById1().getNome();
					printed.add(f2.getAnagrafeById1().getId());
					// System.out.println("checkTree --> " +
					// f2.getAnagrafeById1().getId() + " added!\n" + testo);
				}
			}
			testo = checkTree1(f2.getAnagrafeById1(), ListaSoci, testo);
		}

		return testo;
	}

	private String checkTree1(Anagrafe nome, List ListaSoci, String testo) {

		Iterator it1 = nome.getFamigliasForId1().iterator();
		Iterator it2 = nome.getFamigliasForId2().iterator();

		while (it1.hasNext()) {
			Famiglia f1 = (Famiglia) it1.next();
			if (inLista(f1.getAnagrafeById2().getId(), ListaSoci)) {
				if (!alreadyPrinted(f1.getAnagrafeById2().getId())) {
					// System.out.println("checkTree --> scrivo " +
					// f1.getAnagrafeById2().getCognome() +
					// f1.getAnagrafeById2().getNome());
					testo += ",\n" + f1.getAnagrafeById2().getCognome() + " " + f1.getAnagrafeById2().getNome();
					printed.add(f1.getAnagrafeById2().getId());
					// System.out.println("checkTree --> " +
					// f1.getAnagrafeById2().getId() + " added!\n" + testo);
				}
			}
			testo = checkTree2(f1.getAnagrafeById2(), ListaSoci, testo);
		}

		while (it2.hasNext()) {
			Famiglia f2 = (Famiglia) it2.next();
			if (inLista(f2.getAnagrafeById1().getId(), ListaSoci)) {
				if (!alreadyPrinted(f2.getAnagrafeById1().getId())) {
					// System.out.println("checkTree --> scrivo " +
					// f2.getAnagrafeById1().getCognome() +
					// f2.getAnagrafeById1().getNome());
					testo += ",\n" + f2.getAnagrafeById1().getCognome() + " " + f2.getAnagrafeById1().getNome();
					printed.add(f2.getAnagrafeById1().getId());
					// System.out.println("checkTree --> " +
					// f2.getAnagrafeById1().getId() + " added!\n" + testo);
				}
			}
			testo = checkTree2(f2.getAnagrafeById1(), ListaSoci, testo);
		}

		return testo;
	}

	private String checkTree2(Anagrafe nome, List ListaSoci, String testo) {

		Iterator it1 = nome.getFamigliasForId1().iterator();
		Iterator it2 = nome.getFamigliasForId2().iterator();

		while (it1.hasNext()) {
			Famiglia f1 = (Famiglia) it1.next();
			if (inLista(f1.getAnagrafeById2().getId(), ListaSoci)) {
				if (!alreadyPrinted(f1.getAnagrafeById2().getId())) {
					// System.out.println("checkTree --> scrivo " +
					// f1.getAnagrafeById2().getCognome() +
					// f1.getAnagrafeById2().getNome());
					testo += ",\n" + f1.getAnagrafeById2().getCognome() + " " + f1.getAnagrafeById2().getNome();
					printed.add(f1.getAnagrafeById2().getId());
					// System.out.println("checkTree --> " +
					// f1.getAnagrafeById2().getId() + " added!\n" + testo);
				}
			}
		}

		while (it2.hasNext()) {
			Famiglia f2 = (Famiglia) it2.next();
			if (inLista(f2.getAnagrafeById1().getId(), ListaSoci)) {
				if (!alreadyPrinted(f2.getAnagrafeById1().getId())) {
					// System.out.println("checkTree --> scrivo " +
					// f2.getAnagrafeById1().getCognome() +
					// f2.getAnagrafeById1().getNome());
					testo += ",\n" + f2.getAnagrafeById1().getCognome() + " " + f2.getAnagrafeById1().getNome();
					printed.add(f2.getAnagrafeById1().getId());
					// System.out.println("checkTree --> " +
					// f2.getAnagrafeById1().getId() + " added!\n" + testo);
				}
			}
		}

		return testo;
	}

	private boolean inLista(Integer id, List listaSoci) {

		for (int i = 0; i < listaSoci.size(); i++) {
			PagamentiId s = ((Pagamenti) listaSoci.get(i)).getId();
			if (s.getId().intValue() == id.intValue())
				return true;
		}

		return false;
	}

	private boolean alreadyPrinted(Integer id) {

		for (int i = 0; i < printed.size(); i++) {
			if (((Integer) printed.get(i)).intValue() == id.intValue())
				return true;
		}

		return false;
	}

	private List distinct(List list) {

		List soci = new ArrayList();

		for (int i = 0; i < list.size(); i++) {
			Pagamenti p = (Pagamenti) list.get(i);
			PagamentiId pid = p.getId();
			int tessera = pid.getTessera().intValue();

			boolean found = false;
			for (int j = 0; j < soci.size(); j++) {
				PagamentiId pid1 = ((Pagamenti) soci.get(j)).getId();
				int tessera1 = pid1.getTessera().intValue();

				if (tessera1 == tessera) {
					found = true;
					break;
				}
			}

			if (!found) {
				soci.add(p);
			}
		}

		return soci;
	}

	private void printThankYouLetter(HttpServletRequest request, HttpServletResponse response) throws NullPointerException,
			IllegalArgumentException, IOException {
		InputStream doc_inputstream = null;
		try {
			String pagamento_id = request.getParameter("idp");
			System.out.println("pagamento_id: " + pagamento_id);

			Query q = this.hsession.createQuery("FROM Pagamenti WHERE idp = :id");
			q.setString("id", pagamento_id);

			Pagamenti p = (Pagamenti) q.list().get(0);
			PagamentiId person = p.getId();

			HashMap<String, String> params = new HashMap<String, String>();
			params.put("$LAST_NAME$", person.getCognome());
			params.put("$FIRST_NAME$", person.getNome());
			params.put("$ADDRESS_LINE_1$", person.getIndirizzo());
			params.put("$ADDRESS_LINE_2$", person.getCap() + " " + person.getCitta());
			params.put("$ADDRESS_LINE_3$", person.getNazione() != null ? person.getNazione() : "");
			params.put("$DATE$", new SimpleDateFormat("dd MMMMM yyyy", Locale.ITALIAN).format(new Date()));

			doc_inputstream = CMSUtil.getInstance().getWelcomeLetterTemplate(person.getAnno().intValue());
			System.out.println("doc_inputstream: " + doc_inputstream);

			String filename = "lettera_" + person.getCognome() + "_" + person.getNome() + "_" + person.getAnno() + ".doc";
			response.setContentType("application/msword");
			response.setHeader("Content-disposition", "attachment; filename=" + filename);
			new WordDocumentProcessor(doc_inputstream, response.getOutputStream(), params).processFile();
		} finally {
			if (doc_inputstream != null)
				doc_inputstream.close();
		}
	}

	private class MyPageEvent extends PdfPageEventHelper {

		String titolo = "";

		public MyPageEvent(String tit) {
			super();
			titolo = tit;
		}

		public void onStartPage(PdfWriter writer, Document document) {

			document.resetHeader();
			document.setFooter(new HeaderFooter(new Phrase("pag. " + (writer.getPageNumber() + 1), FontFactory.getFont(
					FontFactory.HELVETICA, 8, Font.BOLD)), false));
		}
	}
}
