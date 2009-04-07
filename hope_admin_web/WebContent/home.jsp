<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	Avviso err = (Avviso) request.getAttribute("err");

	Users u = (Users) session.getAttribute("user");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<STYLE type="text/css">
	@import url("style.css");
</STYLE>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<TITLE>H.O.P.E. - Help Other People Everywhere</TITLE>
</HEAD>
<BODY id="body">
	<div id="container">
		<TABLE border=0 align=center width=100%>
			<TR>
				<TD align=left><img src="./img/logo.gif" height=80px></TD>
				<TD align=center>
					<font class="bilancio" size="+2">H.O.P.E. - Help Other People Everywhere</font>
					<BR><FONT color=#0000CC style="font-size: 12px;" face="Verdana, Arial, Helvetica, sans-serif">( <%= u.getUsername() %> )</font>
				</TD>
				<TD align=right><img src="./img/logo.gif" height=80px></TD>
			</TR>
		</TABLE>
		<div id="menu" align="center">
			<ul>
				<li><a href="sito/accedisito">Gestione Sito Web</a></li>
<%
			if(u.getTipo().intValue() > 0)
				out.println("<li><a href=\"soci/accedisoci\">Gestione Soci</a></li>");

			if(u.getTipo().intValue() > 1)
				out.println("<li><a href=\"bilancio/accedibilancio\">Gestione Bilancio</a></li>");

			if(u.getTipo().intValue() == 3)
				out.println("<li><a href=\"accedi?action=ctrl\">Pannello controllo</a></li>");

%>
				<li><a href="accedi?action=password&what=page">Modifica Password</a></li>
				<li><a href="accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div id="content">
	  	</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2006</P>
		</DIV>
	</div>
</BODY>
</HTML>
