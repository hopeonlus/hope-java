<%@ page language="java" import="java.util.*,mapping.*,org.hibernate.*,system.*" %>

<%
	Users user = (Users) session.getAttribute("user");
	Avviso err = (Avviso) request.getAttribute("err");
	
	//HIBERNATE
	Session hsession = HibernateUtil.currentSession();
	Transaction tx = hsession.beginTransaction();
	
	Query q = null;
	
	String action = request.getParameter("act");
	String id = request.getParameter("id");
	
	if(action != null){
		if(action.equals("delete")){
			q = hsession.createQuery("FROM Newsletter where id = :id");
			q.setString("id", id);
			Newsletter n = (Newsletter) q.list().get(0);
			
			hsession.delete(n);
			tx.commit();
		}
	}
	
	q = hsession.createQuery("FROM Newsletter");
	List mail_list = q.list();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
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
				<li><a id="current">Newsletter</a></li>
				<li><a href="../accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div id="content">
<%
		if(err != null)
		{
%>
		<TABLE class="terrore" align="center" cellspacing="0">
			<TR>
				<TD class="errore" align="left"><IMG SRC="./../img/errore.gif"></TD>			
				<TD class="errore"><p align="center"><%= err.getTesto() %></p></TD>				
				<TD class="errore" align="right"><IMG SRC="./../img/errore.gif" align="right"></TD>			
			</TR>
		</TABLE>
<%
		}
%>
			<TABLE class="tcontentmini" align="center">
				<tr>
					<td class="intestazione" style="width:80%">e-mail</td>
					<td class="intestazione"></td>
				</tr>
				<%
				for(int i=0; i<mail_list.size(); i++){
					Newsletter nl = (Newsletter)mail_list.get(i);
				%>
					<tr id="row<%= i%2%>">
						<td><%= nl.getEmail() %></td>
						<TD align="center">
							<a href="accedisito?what=newsletter&act=delete&id=<%= nl.getId() %>" onClick="return(confirm('Sicuro?'))">
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