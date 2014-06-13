<%@ page language="java" import="java.util.*,mapping.*,org.hibernate.*,system.*" %>

<%
Users user = (Users) session.getAttribute("user");

//HIBERNATE
	Session hsession = HibernateUtil.currentSession();
	Transaction tx = hsession.beginTransaction();
	
	Query q = hsession.createQuery("FROM Progetti");
	List p_list = q.list();
	
	q = hsession.createQuery("FROM News");
	List n_list = q.list();
	
	String action = request.getParameter("act");
	String id = request.getParameter("id");
	
	if(action != null){
	
		//ELIMINAZIONE IMMAGINI
		if(action.equals("delete")){
			q = hsession.createQuery("FROM Immagini where id = :id");
			q.setString("id", id);
			Immagini n = (Immagini) q.list().get(0);
			
			hsession.delete(n);
			tx.commit();
		}
		
		//AGGIUNTA IMMAGINI
		if(action.equals("add")) {
			String path, pref, pref_mini, ext, full_path, full_path_mini, project, news;
			int from = 0;
			int to = 0;
			boolean all_right = true;
			boolean digits, debug;
			List url_list = new ArrayList();
			
			Immagini img;
			
			path = request.getParameter("path");
			pref = request.getParameter("pref");
			pref_mini = request.getParameter("pref_mini");
			ext = request.getParameter("ext");
			project = request.getParameter("project");
			news = request.getParameter("news");
			digits = request.getParameter("digits") != null ? true : false;
			debug = request.getParameter("debug") != null ? true : false;
			
			try{
				from = Integer.parseInt(request.getParameter("from"));
				to = Integer.parseInt(request.getParameter("to"));
			} catch (Exception e) {
				all_right = false;
			}
			
			full_path = path.lastIndexOf("/") == (path.length()-1) ? path + pref : path + "/" + pref;
			full_path_mini = path.lastIndexOf("/") == (path.length()-1) ? path + pref_mini : path + "/" + pref_mini;
			
			for(int i=from; i <= to; i++) {
				String digit = "";
				if(digits && (i < 10))
					digit = "0";
			
				img = new Immagini();
				img.setNome(pref + digit + i);
				img.setImg(full_path_mini + digit + i + "." + ext);
				img.setImggrande(full_path + digit + i + "." + ext);
				img.setTipo(new Integer(1));
				
				if(debug)
					out.println("IMMAGINE: " + img.getNome() + "<br>" + img.getImg() + "<br>" + img.getImggrande() + "<br><br>");
				
				if(!debug){
					hsession.save(img);
				}
				
				if(!project.equals("")) {
					q = hsession.createQuery("FROM Progetti where id = :id");
					q.setString("id", project);
					Progetti p = (Progetti) q.list().get(0);
					
					q = hsession.createQuery("FROM Immagini where nome = :nome");
					q.setString("nome", img.getNome());
					
					img = (Immagini) q.list().get(0);
					
					ProgettiimgId p_i_id = new ProgettiimgId();
					p_i_id.setIdprogetto(p.getId());
					p_i_id.setIdimg(img.getId());
					
					Progettiimg p_i = new Progettiimg();
					p_i.setId(p_i_id);
					p_i.setImmagini(img);
					p_i.setProgetti(p);
					
					if(debug)
						out.println("IMMAGINE-PROGETTO: " + img.getId() + " - " + p.getTitolo() + "<br><br>");
				
					if(!debug){
						hsession.save(p_i);
					}
				}
				
				if(!news.equals("")) {
					q = hsession.createQuery("FROM News where id = :id");
					q.setString("id", news);
					News n = (News) q.list().get(0);
					
					q = hsession.createQuery("FROM Immagini where nome = :nome");
					q.setString("nome", img.getNome());
					
					img = (Immagini) q.list().get(0);
					
					NewsimgId n_i_id = new NewsimgId();
					n_i_id.setIdnews(n.getId());
					n_i_id.setIdimg(img.getId());
					
					Newsimg n_i = new Newsimg();
					n_i.setId(n_i_id);
					n_i.setImmagini(img);
					n_i.setNews(n);
					
					if(debug)
						out.println("IMMAGINE-NEWS: " + img.getId() + " - " + n.getTitolo() + "<br><br>");
				
					if(!debug){
						hsession.save(n_i);
					}
				}
				
			}
			
			if(!debug){
				tx.commit();
			}
		}
	}
	
	q = hsession.createQuery("FROM Immagini");
	List imgs = q.list();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">

<STYLE type="text/css">
	@import url("style.css");
</STYLE>
<TITLE>HOPE - Gestione Sito Web</TITLE>
</HEAD>
<BODY id="body">
	<div id="container">
		<TABLE border=0 align=center width=100%>
			<TR>
				<TD align=left><img src="./../img/logo.gif" height=80px></TD>
				<TD align=center>
					<font class="bilancio">Gestione Sito Web</font>
					<BR><FONT color=#0000CC style="font-size: 12px;" face="Verdana, Arial, Helvetica, sans-serif"><B>(<%= user.getUsername() %>)</B></font>
				</TD>
				<TD align=right><img src="./../img/logo.gif" height=80px></TD>
			</TR>
		</TABLE>
		<div id="menu" align="center">
			<ul>
				<li><a href="accedisito">Home</a></li>
				<li><a href="news">News</a></li>
				<li><a href="news?action=showeventi">Eventi</a></li>
				<li><a href="accedisito?what=progetti">Progetti</a></li>
				<li><a id="current">Immagini</a></li>
				<li><a href="accedisito?what=newsletter">Newsletter</a></li>
				<li><a href="../accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div id="content">
		
		<form action="accedisito" method="get">
		<table class="tcontentmini" align="center">
		<tr>
					<td class="intestazione" colspan="2">Inserisci</td>
		</tr>
		<tr id="row0">
		<td style="width:40%"><b>Path</b> (ex. '/img/news/'):</td>
		<td><input type="text" name="path" /></td>
		</tr>
		<tr id="row1">
		<td style="width:40%"><b>Prefisso grande</b> (ex. 'news_'): </td>
		<td><input type="text" name="pref" /></td>
		</tr>
		<tr id="row0">
		<td style="width:40%"><b>Prefisso mini</b> (ex. 'news_mini_'): </td>
		<td><input type="text" name="pref_mini" /></td>
		</tr>
		<tr id="row1">
		<td style="width:40%"><b>Da:</b></td>
		<td><input type="text" name="from" /></td>
		</tr>
		<tr id="row0">
		<td style="width:40%"><b>A:</b></td>
		<td><input type="text" name="to" /></td>
		</tr>
		<tr id="row1">
		<td style="width:40%"><b>2 cifre?</b> (ex. 01)</td>
		<td><input type="checkbox" name="digits"></td>
		</tr>
		<tr id="row0">
		<td style="width:40%"><b>Estensione:</b></td>
		<td>
			<select name="ext">
				<option value="jpg" selected="selected">jpg</option>
				<option value="gif">gif</option>
				<option value="bmp">bmp</option>
			</select>
		</td>
		</tr>
		<tr id="row1">
		<td style="width:40%">
		<b>News:</b>
		</td>
		<td>
			<select name="news">
				<option></option>
				<%
				for(int i=0; i< n_list.size(); i++){
					News n = (News) n_list.get(i);
					out.println("<option value=\"" + n.getId() + "\">" + n.getId() + " - " + n.getTitolo() + "</option>");
				}
				%>
			</select>
		</td>
		</tr>
		<tr id="row0">
		<td style="width:40%">
		<b>Progetto:</b>
		</td>
		<td>
			<select name="project">
				<option></option>
				<%
				for(int i=0; i< p_list.size(); i++){
					Progetti p = (Progetti) p_list.get(i);
					out.println("<option value=\"" + p.getId() + "\">" + p.getId() + " - " + p.getTitolo() + "</option>");
				}
				%>
			</select>
		</td>
		</tr>
		<tr id="row1">
		<td style="width:40%">
		<b>DEBUG:</b>
		</td>
		<td>
		<input type="checkbox" name="debug"/>
		</td>
		</tr>
		<tr id="row0">
		<td colspan="2" align="center"><input type="submit" value="Inserisci"/></td>
		</tr>
		</table>
		<input type="hidden" name="act" value="add" />
		<input type="hidden" name="what" value="imgs" />
		</form>	
		
		<TABLE class="tcontent" align="center">
				<tr>
					<td class="intestazione" style="width:5%">Id</td>
					<td class="intestazione">Nome</td>
					<td class="intestazione">Img grande</td>
					<td class="intestazione">Img mini</td>
					<td class="intestazione" width="5%"></td>
				</tr>
				<%
				for(int i=0; i<imgs.size(); i++){
					Immagini img = (Immagini)imgs.get(i);
				%>
					<tr id="row<%= i%2%>">
						<td><%= img.getId() %></td>
						<td><%= img.getNome() %></td>
						<td><%= img.getImggrande() %></td>
						<td><%= img.getImg() %></td>
						<TD align="center">
							<a href="accedisito?what=imgs&act=delete&id=<%= img.getId() %>" onClick="return(confirm('Sicuro?'))">
								<img src="../img/del.gif" border="0">
							</a>
						</TD>
					</tr>
				<%
				}
				%>
			</TABLE>		
	  	</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2006</P>
		</DIV>
	</div>
</BODY>
</HTML>