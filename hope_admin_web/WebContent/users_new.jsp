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
<script language="javascript">
<!--
//-->
</script>
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
				<li><a href="soci/accedisoci">Gestione Soci</a></li>
				<li><a href="bilancio/accedibilancio">Gestione Bilancio</a></li>
				<li><a id="current">Pannello controllo</a></li>
				<li><a href="accedi?action=password&what=page">Modifica Password</a></li>
				<li><a href="accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div align="center" style="padding-top:3px ">
			<ul style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:90%; ">
				<li><a id="current1">Users</a></li>
			</ul>
		</div>
		<div id="content">
<%
		if(err != null)
		{
%>
		<TABLE class="terrore" align="center" cellspacing="0" style="width:40% ">
			<TR>
				<TD class="errore" align="left"><IMG SRC="./img/errore.gif"></TD>			
				<TD class="errore"><p align="center"><%= err.getTesto() %></p></TD>				
				<TD class="errore" align="right"><IMG SRC="./img/errore.gif" align="right"></TD>			
			</TR>
		</TABLE>
<%
		}
%>
		<form name="user" method="post" action="accedi">
			<TABLE class="tcontent" align="center" cellspacing="0" style="width:40% ">
				<TR>
					<TD><B>Username : </B></TD>
					<TD>
						<input type="text" name="username">
					</TD>
				</TR>
				<TR>
					<TD><B>Password : </B></TD>
					<TD>
						<input type="text" name="password">
					</TD>
				</TR>
				<TR>
					<TD><B>Tipo : </B></TD>
					<TD>
						<select name="tipo">
							<option value="1">1 - Gestione Soci</option>
							<option value="2">2 - Gestione Bilancio + Soci</option>
							<option value="3">3 - GESTORE</option>
						</select>
					</TD>
				</TR>
				<TR><TD colspan="2"><BR></TD></TR>
				<TR>
					<TD align="left">
						<input type="button" value="Annulla" onClick="window.location.href='accedi?action=ctrl'">
					</TD>
					<TD align="right">
						<input type="submit" name="salva" value="Inserisci">
					</TD>
				</TR>
			</TABLE>
			<input type="hidden" name="what" value="insert">
			<input type="hidden" name="action" value="ctrl">
		</form>
	  	</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2006</P>
		</DIV>
	</div>
</BODY>
</HTML>