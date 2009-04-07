<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	Avviso err = (Avviso) request.getAttribute("err");
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
					<font class="bilancio" size="+2">H.O.P.E. - Help Other People Everywhere</font>
				</TD>
				<TD align=right><img src="./img/logo.gif" height=80px></TD>
			</TR>
		</TABLE>
		<div id="menu" align="center">
			<ul>
			</ul>
		</div>
		<div id="content">
<%
		if(err != null)
		{
%>
		<table class="tcontent" align="center" style="border:0 ">
			<TR>
				<TD align="center">Si è verificato il seguente errore : </TD>
			</TR>
		</table>
		<table><TR><TD></TD></TR></table>
		<TABLE class="terrore" align="center" cellspacing="0">
			<TR>
				<TD class="errore" align="left"><IMG SRC="./img/errore.gif"></TD>			
				<TD class="errore"><p align="center"><%= err.getTesto() %></p></TD>				
				<TD class="errore" align="right"><IMG SRC="./img/errore.gif" align="right"></TD>			
			</TR>
		</TABLE>
		<table><tr><td></td></tr></table>
<%
		}
%>
			<BR><BR>
			<TABLE align="center" class="tcontentmini" style="border:0 ">
				<TR>
					<TD align="center">
						<input type="button" value="Indietro" onClick="javascript:history.back()" <% if(err.getTesto().equals("Autenticazione fallita!")) out.print("disabled");%>>
						<br><br><BR>
					</TD>
				</TR>
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
