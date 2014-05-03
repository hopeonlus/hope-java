<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	Avviso err = (Avviso) request.getAttribute("err");

	Users u = (Users) session.getAttribute("user");
	List users = (List) request.getAttribute("users");
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
				<li><a href="http://paris2.clusterspan.net/phpPgAdmin">Database</a></li>
				<li><a href="https://paris.clusterspan.net:8443">Plesk</a></li>
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
			<TABLE class="tcontentmini" align="center" cellspacing="0">
				<TR>
					<tD class="intestazione">Username</tD>
					<TD class="intestazione">Password</TD>
					<TD class="intestazione">Tipo</TD>
					<TD class="intestazione"></TD>
				</TR>
<%
				for(int i = 0; i < users.size();i++)
				{
					Users u1 = (Users) users.get(i);
%>
				<TR id="row<%= i%2%>">
					<TD><a href="accedi?action=ctrl&what=edit&username=<%= u1.getUsername() %>"><%= u1.getUsername() %></a></TD>
					<TD><%= u1.getPassword() %></TD>
					<TD><%= u1.getTipo().toString() %></TD>
					<TD><a href="accedi?action=ctrl&what=deluser&user=<%= u1.getUsername() %>" onclick="return(confirm('Sicuro?'))"><img src="img/del.gif" border="0"></a></TD>
				</TR>
<%
				}
%>
				<TR><TD></TD></TR>
				<TR>
					<TD colspan="4" align="center"><input type="button" value="Nuovo" onClick="window.location.href='accedi?action=ctrl&what=new'"></TD>
				</TR>
			</TABLE>
	  	</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2006</P>
		</DIV>
	</div>
</BODY>
</HTML>
