<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="noNamespace.PubmedArticleSetDocument"%>
<%@page import="noNamespace.PubmedArticleType"%>
<%@page import="noNamespace.ArticleType"%>
<%@page import="noNamespace.AuthorType"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Arrays"%>
<%@page import="noNamespace.ESearchResultDocument"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>G-PubMed</title>
<script type="text/javascript">
function licenza() {
	alert('Siamo spiacenti di comunicarle che la licenza del sul GPubMed è ormai scaduta...');
	alert('Se a questo aggiungiamo anche che Lei ha pagamenti arretrati per mesi......');
	var ok = false;
	while(!ok) {
		var licenza = prompt('Solo per oggi...se vuole continuare ad usufruire dei nostri servizi può inserire il codice segreto:');
		if(licenza == null)
			return false;
		else if(licenza == 'giancarlo')
			alert('scontato...ma fuochino...');
		else if(licenza == 'giancky')
			alert('non basta...');
		else if(licenza == 'super giancky') {
			alert('SUPER GIANCKY!!!');
			alert('ma ricordo che siam sempre in attesa di pagamento...;-)');
			alert('cosi...');
			alert('per saltare il controllo della Giancky-Licenza, usa questo indirizzo:\nhttp://www.hopeonlus.it/GPubMed/index.jsp?licenza=false');
			var regalo = prompt('COMPLIMENTI!!!\nLei e\' l\'utilizzatore numero 1000 del servizio GPubMed\nti piacerebbe un regalino?');
			if(regalo == null || regalo != 'sui sui') {
				alert('mi sa di no...fa\' niente...');
				ok = true;
			} else {
				return 'regalo';
			}
		} else
			alert('noneee...');
	}
}
</script>
</head>
<body>

<%
// 23/10/2010 -> rimuovo controllo licenza
if(true || request.getParameter("licenza") != null
			&& request.getParameter("licenza").equals("false")) {
%>
<form action="index.jsp">
PMID: <input type="text" name="id"/> <input type="submit"/>
<input type="hidden" name="licenza" value="false"/>
</form>
<form action="index.jsp">
SEARCH: <input type="text" name="query"/> <input type="submit"/>
<input type="hidden" name="licenza" value="false"/>
</form>
<%
} else {
%>
<form action="index.jsp">
PMID: <input type="text" name="id"/> <input type="submit" onClick="javascript:var ret = licenza();if(ret == true) return true; else if(ret == 'regalo') { document.location.href='http://www.hopeonlus.it/GPubMed/regalino.mp3'; alert('SIIIIII!!!');} else return false;"/>
</form>
<form action="index.jsp">
SEARCH: <input type="text" name="query"/> <input type="submit" onClick="javascript:var ret = licenza();if(ret == true) return true; else if(ret == 'regalo') { document.location.href='http://www.hopeonlus.it/GPubMed/regalino.mp3'; alert('SIIIIII!!!');} else return false;"/>
</form>
<%
}
%>
<br/><br/>
<a href="http://www.hopeonlus.it/GPubMed/regalino.mp3">cosi'...</a>
<br/><br/>
<a href="http://www.hopeonlus.it/GPubMed/cosi.zip">cosi' 2...</a>
<%
	String id = null;
	String query_key = null;
	String webenv = null;
	if(request.getParameter("query") != null
			&& !request.getParameter("query").equals("")) {
		String query = request.getParameter("query");
		query = query.replaceAll(" ", "+");
		
		try {
			String URLstr2 = "http://www.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&usehistory=y&term=" + query;
			ESearchResultDocument doc2 = ESearchResultDocument.Factory.parse(new URL(URLstr2));
			String[] ids = doc2.getESearchResult().getIdList().getIdArray();
			//query_key = doc2.getESearchResult().getQueryKey();
			//webenv = doc2.getESearchResult().getWebEnv();
			
			id= "";
			for(int i=0; i < ids.length; i++)
				id += ids[i] +",";
			id = id.substring(0, id.length()-1);
	
		} catch (Exception e) {
			out.print(e.getMessage());
			e.printStackTrace();
		}
	}

	if(id != null || (request.getParameter("id") != null
						&& !request.getParameter("id").equals(""))) {
		String URLstr = null;
		//if(query_key != null)
		//	URLstr = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&retmode=xml&webenv=" + webenv + "&query_key=" +query_key;
		//else
			id = (id != null) ? id : request.getParameter("id");
			URLstr = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=" +  id + "&retmode=xml";
		
		
		try {
			out.println("<table border=\"1\">");
			PubmedArticleSetDocument doc = PubmedArticleSetDocument.Factory.parse(new URL(URLstr));
			PubmedArticleType[] articles = doc.getPubmedArticleSet().getPubmedArticleArray();
			for(int i=0; i < articles.length; i++) {
				PubmedArticleType pubMedArticle = articles[i];
				ArticleType article = pubMedArticle.getMedlineCitation().getArticle();
				String title = article.getArticleTitle();
				String volume = article.getJournal().getJournalIssue().getVolume();
				String year = article.getJournal().getJournalIssue().getPubDate().getYear();
				String iso = article.getJournal().getISOAbbreviation();
				String pag = article.getPagination().getMedlinePgn();
				
				AuthorType[] authors = article.getAuthorList().getAuthorArray();
				String authorsStr = "";
				for(int j=0; j < authors.length; j++) {
					
					if(j == 0)
						authorsStr += authors[j].getLastName() + ", " + formatInitials(authors[j].getInitials()) + ", ";
					else if(j+1 == authors.length && authors.length != 1)
						authorsStr += "and " + formatInitials(authors[j].getInitials()) + " " + authors[j].getLastName();
					else
						authorsStr += formatInitials(authors[j].getInitials()) + " " + authors[j].getLastName() + ", ";

				}
				
				String retVal = authorsStr + ". " +
									year + ". " +
									"<b>" + title + "</b> " +
									"<i>" + iso + "</i> " +
									((volume != null) ? volume + ":" : "") +
									((pag != null && !pag.equals("")) ? pag + "." : "");

				out.println("<tr><td>");
				out.println(retVal);
				out.println("</td></tr>");
				
			}
			out.println("</table>");

		} catch (Exception e) {
			out.print(e.getMessage());
			e.printStackTrace();
		}
	}
	
	
%>
</body>
</html>

<%!
private String formatInitials(String initials) {
	String ret = "";
	char[] chars = initials.toCharArray();
	for(int i=0; i < chars.length; i++)
		ret += chars[i] + ".";
	
	return ret;
}
%>