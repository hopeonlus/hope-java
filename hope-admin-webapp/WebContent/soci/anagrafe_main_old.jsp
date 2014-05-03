<%@ page language="java" import="java.util.*" %>
<%@ page import="mapping.*"%>

<%
	Users user = (Users) session.getAttribute("user");
	
	List ListaNomi = (List) request.getAttribute("listaNomi");
	
	String orderby = request.getParameter("orderby");
	if(orderby == null)
		orderby = "id";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<STYLE type="text/css">
	@import url("style.css");
</STYLE>
<TITLE>HOPE - Gestione soci</TITLE>
</HEAD>
<BODY id="body">
	<div id="container">
		<TABLE border=0 align=center width=100%>
			<TR>
				<TD align=left><img src="./img/logo.gif" height=80px></TD>
				<TD align=center>
					<font class="bilancio">Gestione Soci</font>
					<BR><FONT color=#0000CC style="font-size: 12px;" face="Verdana, Arial, Helvetica, sans-serif"><B>( <%= user.getUsername() %> )</B></font>
				</TD>
				<TD align=right><img src="./img/logo.gif" height=80px></TD>
			</TR>
		</TABLE>
		<div id="menu" align="center">
			<ul>
				<li><a href="accedisoci">Home</a></li>
				<li><a id="current">Anagrafe</a></li>
				<li><a href="soci">Soci</a></li>
				<!--<li><a href="#">Azionisti</a></li>-->
				<li><a href="adozioni">Adozioni</a></li>
				<li><a href="stampa">Stampa</a></li>
				<li><a href="../accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div id="content">
			<table class="tcontentmaxi" align="center">
				<TR>
					<TD align="left">Trovati &nbsp;<B><%= ListaNomi.size() %></B>&nbsp; nominativi :</TD>
				</TR>
			</table>
			<TABLE class="tcontentmaxi" align="center">
				<TR class="intestazione">
					<TD><B>Id <a href="anagrafe?action=page&orderby=id"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD><B>Cognome <a href="anagrafe?action=page&orderby=cognome"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD><B>Nome <a href="anagrafe?action=page&orderby=nome"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD><B>Indirizzo <a href="anagrafe?action=page&orderby=indirizzo"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD><B>CAP <a href="anagrafe?action=page&orderby=cap"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD><B>Città <a href="anagrafe?action=page&orderby=citta"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD><B>Nazione <a href="anagrafe?action=page&orderby=nazione"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD><B>Cod. Fiscale <a href="anagrafe?action=page&orderby=codfiscale"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD></TD>
					<TD></TD>
				</TR>
<%
			for(int i = 0; i < ListaNomi.size(); i++)
			{
				Anagrafe a = (Anagrafe) ListaNomi.get(i);
%>
				<TR id="row<%= i%2 %>">
					<TD width="4%"><a href="anagrafe?action=view&id=<%= a.getId() %>"><%= a.getId() %></a></TD>
					<TD width="16%"><%= a.getCognome() %></TD>
					<TD width="16%"><%= a.getNome() %></TD>
					<TD width="21%"><%= a.getIndirizzo() %></TD>
					<TD><%= a.getCap() %></TD>
					<TD width="15%"><%= a.getCitta() %></TD>
					<TD width="7%"><%= a.getNazione() %></TD>
					<TD><%= a.getCodfiscale() %></TD>
					<TD align="center"><a href="anagrafe?action=view&id=<%= a.getId() %>"><img src="img/edit.gif" border="0"></a></TD>
					<TD align="center"><a href="anagrafe?action=del&id=<%= a.getId() %>&orderby=<%= orderby %>" onclick="return(confirm('Verranno eliminati TUTTI i dati relativi alla persona!\nSicuro?'))"><img src="img/del.gif" border="0"></a></TD>
				</TR>
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
