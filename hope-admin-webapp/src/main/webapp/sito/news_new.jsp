<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*" %>

<%
	Users user = (Users) session.getAttribute("user");
	
	Avviso err = (Avviso) request.getAttribute("err");
	
	java.util.Date data = new java.util.Date();
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("dd/MM/yyyy");
    String oggi = formatter.format(data);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<STYLE type="text/css">
	@import url("style.css");
</STYLE>
<TITLE>HOPE - Gestione Sito Web</TITLE>
	
	<link rel="stylesheet" type="text/css" href="../script/jquery.cleditor.css" />
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script type="text/javascript" src="../script/jquery.cleditor.min.js"></script>
    <script type="text/javascript">
      $(document).ready(function() {
        $("#input").cleditor();
      });
    </script>
    
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
				<li><a href="accedisito">Home</a></li>
				<li><a id="current">News</a></li>
				<li><a href="news?action=showeventi">Eventi</a></li>
				<li><a href="accedisito?what=progetti">Progetti</a></li>
				<li><a href="accedisito?what=imgs">Immagini</a></li>
				<li><a href="accedisito?what=newsletter">Newsletter</a></li>
				<li><a href="../accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div id="content">
<%
		if(err != null)
		{
%>
		<TABLE class="terrore" align="center" cellspacing="0">
			<TR>
				<TD class="errore" align="left"><IMG SRC="./../img/errore.gif"></TD>			
				<TD class="errore"><p align="center"><%= err.getTesto() %></p></TD>				
				<TD class="errore" align="right"><IMG SRC="./../img/errore.gif" align="right"></TD>			
			</TR>
		</TABLE>
<%
		}
%>
		<FORM name="news" action="news" method="post" onSubmit="">
			<TABLE class="tcontent" align="center">
				<TR>
					<TD width="35%"><B>Data (gg/mm/aaaa) : </B></TD>
					<TD><input type="text" name="data" maxlength="10" value="<%= oggi %>"></TD>
				</TR>
				<TR>
					<TD><B>Titolo : </B></TD>
					<TD>
						<input type="text" name="titolo" style="width: 300px">
					</TD>
				</TR>
				<TR>
					<TD><B>Sottotitolo : </B></TD>
					<TD>
						<input type="text" name="sottotitolo"  style="width:600px">
					</TD>
				</TR>
				<TR>
					<TD><B>Testo : </B></TD>
					<TD>
					<!--<textarea name="testo" cols="70" rows="10" style="font:Arial, Helvetica, sans-serif; "></textarea>-->
					<textarea id="input" name="testo"></textarea>
					</TD>
				</TR>
				<TR><TD></TD></TR>
				<TR>
					<TD colspan="2" align="center">
						<INPUT type="submit" value="Inserisci">
					</TD>
				</TR>
			</TABLE>
			<INPUT type="hidden" name="action" value="insert">
			<INPUT type="hidden" name="page" value="insert">
		</FORM>
	  	</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2006</P>
		</DIV>
	</div>
</BODY>
</HTML>
