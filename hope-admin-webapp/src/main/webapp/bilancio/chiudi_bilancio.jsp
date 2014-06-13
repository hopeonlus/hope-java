<%@ page language="java" import="java.util.*" %>
<%@ page import="mapping.*"%>

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
				<TD align=center><p class="bilancio">Gestione Bilancio</p></TD>
				<TD align=right><img src="./img/logo.gif" height=80px></TD>
			</TR>
		</TABLE>
		<div id="menu" align="center">
			<ul>
				<li><a id="current">Home</a></li>
				<li><a href="#">Scritture</a></li>
				<li><a href="#">Conti</a></li>
				<li><a href="#">Bilancio</a></li>
				<li><a href="../accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div id="content">
		<form name="chiusura" action="accedi" method="get">
			<table class="terroremaxi" align="center" cellspacing="0">
				<TR>
					<TD class="errore" align="left"><IMG SRC="./img/errore.gif"></TD>			
					<TD class="errore"><p align="center">ATTENZIONE! Una volta chiuso il bilancio non è più possibile riaprirlo!<BR>Confermi?</p></TD>				
					<TD class="errore" align="right"><IMG SRC="./img/errore.gif" align="right"></TD>			
				</TR>
				<TR><TD colspan="3" class="errore"><BR></TD></TR>
				<TR>
					<TD align="center" class="errore" colspan="3">
						<p align="center">
							<input type="button" value="Annulla" onClick="window.location.href='accedi'">
							&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp;
							<input type="submit" value="Conferma">
						</p>
					</TD>
				</TR>
			</table>
			<input type="hidden" name="action" value="chiudi">
			<input type="hidden" name="page" value="2">
			<input type="hidden" name="anno" value="<%= request.getParameter("anno") %>">
		</form>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2006</P>
		</DIV>
	</div>
</BODY>
</HTML>
