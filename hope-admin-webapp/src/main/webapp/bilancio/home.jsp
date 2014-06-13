<%@ page language="java" import="java.util.*" %>
<%@ page import="mapping.*"%>

<%
	List ListaAnni = (List) request.getAttribute("listaanni");
	Users user = (Users) session.getAttribute("user");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<STYLE type="text/css">
	@import url("style.css");
</STYLE>
<TITLE>HOPE - Bilancio</TITLE>
</HEAD>
<BODY id="body">
	<div id="container">
		<TABLE border=0 align=center width=100%>
			<TR>
				<TD align=left><img src="./img/logo.gif" height=80px></TD>
				<TD align=center>
					<font class="bilancio">Gestione Bilancio</font>
					<BR><FONT color=#0000CC style="font-size: 12px;" face="Verdana, Arial, Helvetica, sans-serif"><B>(<%= user.getUsername() %>)</B></font>
				</TD>
				<TD align=right><img src="./img/logo.gif" height=80px></TD>
			</TR>
		</TABLE>
		<div id="menu" align="center">
			<ul>
				<li><a id="current">Home</a></li>
				<li><a href="scritture">Scritture</a></li>
				<li><a href="conti">Conti</a></li>
				<li><a href="bilancio">Bilancio</a></li>
				<li><a href="../accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div id="content">
			<TABLE class="tcontentmini" align="center">
				<TR class="intestazione">
					<TD align="center"><B>Anno</B></TD>
					<TD align="center"><B>Stato</B></TD>
					<TD></TD>
				</TR>
<%
				for(int i = 0; i < ListaAnni.size(); i++)
				{
				Anno a = (Anno)ListaAnni.get(i);
				String stato = "Aperto";
				if(a.isChiuso())
					stato = "Chiuso";
%>
				<TR id="row<%= i%2 %>">
					<TD align="left"><%= a.getAnno() %></TD>
					<TD align="left"><%= stato %></TD>
					<TD align="center">
<%
					if(!a.isChiuso())
					{
%>
						<a href="accedi?action=chiudi&page=1&anno=<%= a.getAnno() %>"><img src="img/unlock.gif" border="0"></a>
<%
					}
					else
					{
%>
						<img src="img/lock.gif">
<%		
					}
%>
					</TD>
				</TR>
<%
				}
%>
			</TABLE>
			<BR>
			<TABLE align="center" class="tcontentmini">
				<TR>
					<TD align="center"><a href="../accedi">> Torna alla Home <</a></TD>
				</TR>
			</TABLE>
	  </div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2006</P>
		</DIV>
	</div>
</BODY>
</HTML>
