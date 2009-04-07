<%@ page language="java" import="java.util.*" %>
<%@ page import="mapping.*"%>

<%
	Users user = (Users) session.getAttribute("user");
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
					<BR><FONT color=#0000CC style="font-size: 12px;" face="Verdana, Arial, Helvetica, sans-serif"><B>(<%= user.getUsername() %>)</B></font>
				</TD>
				<TD align=right><img src="./img/logo.gif" height=80px></TD>
			</TR>
		</TABLE>
		<div id="menu" align="center">
			<ul>
				<li><a id="current">Home</a></li>
				<li><a href="anagrafe">Anagrafe</a></li>
				<li><a href="soci">Soci</a></li>
				<!--<li><a href="#">Azionisti</a></li>-->
				<li><a href="adozioni">Adozioni</a></li>
				<li><a href="stampa">Stampa</a></li>
				<li><a href="../accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div id="content">
		<BR>
		<b>INFO:</b>
		<ul class="errore">
			<li>
				<div align="center" class="errore">Elenco COMPLETO (SOCI/AZIONISTI/ADOTTANTI) formato EXCEL - <a href="elenco_completo.xls">download</a></div>
			</li>
			<li>
					<div>Soci 2005 aggiornati con i dati del database Access della sede (file excel qui sopra)</div>
			</li>
			<li>
				<div>Soci 2006 aggiornati ma da controllare con quelli inseriti nel bilancio</div>
	</li>
	</ul>
	<br>
	<br>
	<b>DA FARE:</b>
	<ul class="errore">
	<li>
			<div>Aggiornare Soci da 1999 a 2004</div>
	</li>
	<li>
		<div>Adozioni</div>
</li>
		</ul>
		<BR><BR><BR><br><br>
			<div align="center"><a href="../accedi">> Torna alla Home < </a></div>
	  	</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2006</P>
		</DIV>
	</div>
</BODY>
</HTML>
