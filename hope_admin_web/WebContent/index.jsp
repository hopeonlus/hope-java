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
				<TD align=center><p class="bilancio">H.O.P.E. - Help Other People Everywhere</p></TD>
				<TD align=right><img src="./img/logo.gif" height=80px></TD>
			</TR>
		</TABLE>
		<div id="menu" align="center">
			<ul>
				<li><a id="current">Login</a></li>
			</ul>
		</div>
		<div id="content">
<%
		if(err != null)
		{
%>
		<TABLE class="terrore" align="center" cellspacing="0" style="width:30% ">
			<TR>
				<TD class="errore" align="left"><IMG SRC="./img/errore.gif"></TD>
				<TD class="errore"><p align="center"><%= err.getTesto() %></p></TD>
				<TD class="errore" align="right"><IMG SRC="./img/errore.gif" align="right"></TD>
			</TR>
		</TABLE>
<%
		}
%>
		<form action="accedi" method="post">
			<TABLE class="tcontentmini" align="center" style="width:30% ">
				<TR>
					<TD align="left" width="50%">
						<B>Username : </B>
					</TD>
					<TD width="50%">
						<input type="text" name="username" maxlength="20">
					</TD>
				</TR>
				<TR>
					<TD align="left">
						<B>Password : </B></TD>
					<TD>
						<input type="password" name="password" maxlength="15">
					</TD>
				</TR>
				<TR>
					<TD colspan="2" align="center">
						<BR><input type="submit" value="Login" style="width:80px ">
					</TD>
				</TR>
			</TABLE>
			<input type="hidden" name="action" value="login">
		</form>
<br><br><div align="center">
<a href="https://prague.clusterspan.net:8443/"><img border="0" src="./img/plesk.gif"></a>
</div>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2006</P>
		</DIV>
	</div>
</BODY>
</HTML>
