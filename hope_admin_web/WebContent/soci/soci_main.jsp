<%@ page language="java" import="java.util.*" %>
<%@ page import="mapping.*"%>

<%
	Users user = (Users) session.getAttribute("user");
	
	List ListaSoci = (List) request.getAttribute("listasoci");
	String what = request.getParameter("what");
	String anno = request.getParameter("anno");
	String dal = request.getParameter("dal");
	String al = request.getParameter("al");
	
	String elenco = "";
	if(what.equals("tutti"))
		elenco = "COMPLETO";
	else if(what.equals("anno"))
		elenco = anno;
	else if(what.equals("anni"))
		elenco = "dal " + dal + " al " + al;
		
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
					<BR><FONT color=#0000CC style="font-size: 12px;" face="Verdana, Arial, Helvetica, sans-serif"><B>( <%= user.getUsername() %> )</B></font>
				</TD>
				<TD align=right><img src="./img/logo.gif" height=80px></TD>
			</TR>
		</TABLE>
		<div id="menu" align="center">
			<ul>
				<li><a href="accedisoci">Home</a></li>
				<li><a href="anagrafe">Anagrafe</a></li>
				<li><a id="current">Soci</a></li>
				<!--<li><a href="#">Azionisti</a></li>-->
				<li><a href="adozioni">Adozioni</a></li>
				<li><a href="stampa">Stampa</a></li>
				<li><a href="../accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div align="center" style="padding-top:3px ">
			<ul style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:90%; ">
				<li><a id="current1">Visualizza</a></li>
				<li><a href="soci?action=insert&page=first">Inserisci</a></li>
			</ul>
		</div>
		<div id="content">
			<table class="tcontentmaxi" align="center">
				<TR>
					<TD align="center"><font color="#CC0000"><B>ELENCO SOCI <%= elenco %></b></font></TD>
				</TR>
			</table>
			<table class="tcontentmaxi" align="center">
				<TR>
					<TD align="left">Trovati &nbsp;<B><%= ListaSoci.size() %></B>&nbsp; nominativi :</TD>
				</TR>
			</table>
			<table><tr><td><input type="button" value="Indietro" onClick="window.location.href='soci'"></td></tr></table>
			<TABLE class="tcontentmaxi" align="center">
				<TR class="intestazione">
					<TD><B>Tessera <a href="soci?action=select&what=<%= what %>&anno=<%= anno %>&dal=<%= dal %>&al=<%= al %>&orderby=tessera"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD><B>Cognome <a href="soci?action=select&what=<%= what %>&anno=<%= anno %>&dal=<%= dal %>&al=<%= al %>&orderby=cognome"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD><B>Nome <a href="soci?action=select&what=<%= what %>&anno=<%= anno %>&dal=<%= dal %>&al=<%= al %>&orderby=nome"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD><B>Indirizzo <a href="soci?action=select&what=<%= what %>&anno=<%= anno %>&dal=<%= dal %>&al=<%= al %>&orderby=indirizzo"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD><B>CAP <a href="soci?action=select&what=<%= what %>&anno=<%= anno %>&dal=<%= dal %>&al=<%= al %>&orderby=cap"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD><B>Città <a href="soci?action=select&what=<%= what %>&anno=<%= anno %>&dal=<%= dal %>&al=<%= al %>&orderby=citta"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD><B>Nazione <a href="soci?action=select&what=<%= what %>&anno=<%= anno %>&dal=<%= dal %>&al=<%= al %>&orderby=nazione"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD></TD>
				</TR>
<%
			for(int i = 0; i < ListaSoci.size(); i++)
			{
				Pagamenti id = ((Pagamenti) ListaSoci.get(i));
				PagamentiId a = id.getId();
%>
				<TR id="row<%= i%2 %>">
					<TD width="8%"><a href="soci?action=view&tessera=<%= a.getTessera() %>&what=<%= what %>&anno=<%= anno %>&dal=<%= dal %>&al=<%= al %>"><%= a.getTessera() %></a></TD>
					<TD width="16%"><%= a.getCognome() %></TD>
					<TD width="16%"><%= a.getNome() %></TD>
					<TD width="21%"><%= a.getIndirizzo() %></TD>
					<TD><%= a.getCap() %></TD>
					<TD width="15%"><%= a.getCitta() %></TD>
					<TD width="7%"><%= a.getNazione() %></TD>
					<TD align="center"><a href="soci?action=view&tessera=<%= a.getTessera() %>&what=<%= what %>&anno=<%= anno %>&dal=<%= dal %>&al=<%= al %>"><img src="img/edit.gif" border="0"></a></TD>
				</TR>
<%			
			}
%>
				<TR>
					<TD colspan="8" align="left">
						<input type="button" value="Indietro" onClick="window.location.href='soci'">
					</TD>
				</TR>
				<TR>
					<TD colspan="8" align="center">
						<BR>
						<font size="+1"><A href="soci?action=stampa&page=elenco&what=<%= what %>&anno=<%= anno %>&dal=<%= dal %>&al=<%= al %>" target="_new">STAMPA</a></font>
						&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp;
						<font size="+1"><A href="soci?action=stampa&page=etichette&what=<%= what %>&anno=<%= anno %>&dal=<%= dal %>&al=<%= al %>" target="_new">STAMPA ETICHETTE</a></font>
						&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp;
						<font size="+1"><A href="soci?action=stampa&page=buste&what=<%= what %>&anno=<%= anno %>&dal=<%= dal %>&al=<%= al %>" target="_new">STAMPA BUSTE</a></font>
					</TD>
				</TR>
			</TABLE>
	  	</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2006</P>
		</DIV>
	</div>
</BODY>
</HTML>
