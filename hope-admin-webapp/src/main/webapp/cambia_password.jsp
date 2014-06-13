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
function uguale()
{
	if(document.pwd.newpwd.value != document.pwd.repeatpwd.value)
		document.pwd.salva.disabled = true;
	else
		document.pwd.salva.disabled = false;
}
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
<%
			if(u.getTipo().intValue() > 1)
				out.println("<li><a href=\"bilancio/accedibilancio\">Gestione Bilancio</a></li>");
				
			if(u.getTipo().intValue() == 3)
				out.println("<li><a href=\"pannello\">Pannello controllo</a></li>");
%>
				<li><a id="current">Modifica Password</a></li>
				<li><a href="accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div id="content">
<%
		if(err != null)
		{
%>
		<TABLE class="terrore" align="center" cellspacing="0">
			<TR>
				<TD class="errore" align="left"><IMG SRC="./img/errore.gif"></TD>			
				<TD class="errore"><p align="center"><%= err.getTesto() %></p></TD>				
				<TD class="errore" align="right"><IMG SRC="./img/errore.gif" align="right"></TD>			
			</TR>
		</TABLE>
<%
		}
%>
		<form name="pwd" method="post" action="accedi">
			<TABLE class="tcontent" align="center" cellspacing="0" style="width:40% ">
				<TR>
					<TD><B>Password attuale : </B></TD>
					<TD>
						<input type="password" name="oldpwd">
					</TD>
				</TR>
				<TR>
					<TD><B>Nuova password : </B></TD>
					<TD>
						<input type="password" name="newpwd">
					</TD>
				</TR>
				<TR>
					<TD><B>Ripeti Password: </B></TD>
					<TD>
						<input type="password" name="repeatpwd" onKeyUp="javascript:uguale()">
					</TD>
				</TR>
				<TR><TD colspan="2"><BR></TD></TR>
				<TR>
					<TD align="left">
						<input type="button" value="Annulla" onClick="javascript:history.back()">
					</TD>
					<TD align="right">
						<input type="submit" name="salva" value="Salva" disabled>
					</TD>
				</TR>
			</TABLE>
			<input type="hidden" name="what" value="insert">
			<input type="hidden" name="action" value="password">
		</form>
	  	</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2006</P>
		</DIV>
	</div>
</BODY>
</HTML>