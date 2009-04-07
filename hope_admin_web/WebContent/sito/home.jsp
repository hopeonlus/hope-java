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
<script language="javascript">
function printInd(w)
{
	var e = w;
	e = e+"@";
	e = e+"hopeonlus.it";
	
	document.write('<a href="mailto:' + e + '">' + e + '</a>');
}
</script>
<TITLE>HOPE - Gestione soci</TITLE>
</HEAD>
<BODY id="body">
	<div id="container">
		<TABLE border=0 align=center width=100%>
			<TR>
				<TD align=left><img src="./../img/logo.gif" height=80px></TD>
				<TD align=center>
					<font class="bilancio">Gestione Sito Web</font>
					<BR><FONT color=#0000CC style="font-size: 12px;" face="Verdana, Arial, Helvetica, sans-serif"><B>(<%= user.getUsername() %>)</B></font>
				</TD>
				<TD align=right><img src="./../img/logo.gif" height=80px></TD>
			</TR>
		</TABLE>
		<div id="menu" align="center">
			<ul>
				<li><a id="current">Home</a></li>
				<li><a href="news">News</a></li>
				<li><a href="news?action=showeventi">Eventi</a></li>
				<li><a href="accedisito?what=progetti">Progetti</a></li>
				<li><a href="accedisito?what=imgs">Immagini</a></li>
				<li><a href="accedisito?what=newsletter">Newsletter</a></li>
				<li><a href="../accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div id="content" align="center">
		<BR>
			<div align="center" class="terrore">
				Questa sezione è molto "rudimentale". Per ora è possibile solo aggiungere nuove news ma senza poter formattare il testo, aggiungere link e soprattutto IMMAGINI.<BR>Per queste cose mandatemi una mail con le cose da aggiungere a <script language="javascript">printInd('webmaster');</script> che provvederò a farlo io.<BR><BR>Tete
			</div>
		<BR><BR><BR><br><br>
			<div align="center"><a href="../accedi">> Torna alla Home < </a></div>
	  	</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2006</P>
		</DIV>
	</div>
</BODY>
</HTML>
