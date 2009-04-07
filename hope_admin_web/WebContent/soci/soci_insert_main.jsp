<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%	
	List ListaSoci = (List) request.getAttribute("listasoci");
	List ListaNonSoci = (List) request.getAttribute("listanonsoci");
	
	String what = request.getParameter("what");
	String tessera = request.getParameter("tessera");
	if(tessera == null) tessera = "";
	String cognome = request.getParameter("cognome");
	if(cognome == null) cognome = "";

	Avviso err = (Avviso) request.getAttribute("err");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<script language="javascript">
<!--

function isOk1(){

	if(document.cerca1.tessera.value != '')
		return true;
	else
		alert('Campo TESSERA vuoto!');
		
	return false;
}

function isOk2(){

	if(document.cerca2.cognome.value != '')
		return true;
	else
		alert('Campo COGNOME vuoto!');
		
	return false;
}

function svuota()
{
	document.cerca1.tessera.value = '';
	document.cerca2.cognome.value = '';
}
//-->
</script>

<STYLE type="text/css">
	@import url("style.css");
</STYLE>
<TITLE>H.O.P.E. - Help Other People Everywhere</TITLE>
</HEAD>
<BODY id="body">
	<div id="container">
		<TABLE border=0 align=center width=100%>
			<TR>
				<TD align=left><img src="./img/logo.gif" height=80px></TD>
				<TD align=center><p class="bilancio">H.O.P.E. - Gestione Soci</p></TD>
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
				<li><a href="stampa">Stampa</a></li>
				<li><a href="../accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div align="center" style="padding-top:3px ">
			<ul style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:90%; ">
				<li><a href="soci">Visualizza</a></li>
				<li><a id="current1">Inserisci</a></li>
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
			<TABLE class="tcontent" align="center">
				<TR class="intestazione">
					<TD colspan="2">
						Cerca il socio da inserire se già presente. Altrimenti seleziona "NUOVO SOCIO".
					</TD>
				</TR>
				<TR><TD></TD></TR>
			<form name="cerca1" action="soci" method="post" onSubmit="return isOk1()">
				<TR>
					<TD align="right">
						<B>N° tessera : </B><input type="text" name="tessera" value="<%= tessera %>" onClick="javascript:svuota()">
					</TD>
					<TD align="left" style="padding-left:30px ">
						<input type="submit" value="Trova">
					</TD>
				</TR>
				<input type="hidden" name="what" value="tessera">
				<input type="hidden" name="action" value="insert">
				<input type="hidden" name="page" value="first">
			</form>
			<form name="cerca2" action="soci" method="post" onSubmit="return isOk2()">
				<TR>
					<TD align="right">
						<B>Cognome : </B><input type="text" name="cognome" value="<%= cognome %>" onClick="javascript:svuota()">
					</TD>
					<TD align="left" style="padding-left:30px ">
						<input type="submit" value="Trova">
					</TD>
				</TR>
				<input type="hidden" name="what" value="cognome">
				<input type="hidden" name="action" value="insert">
				<input type="hidden" name="page" value="first">
			</form>
			</TABLE>
			<BR>
			<TAble class="tcontent" align="center">
				<TR>
					<TD align="center">
						<input type="button" value="Nuovo Socio" onClick="window.location.href='soci?action=insert&page=new'">
					</TD>
				</TR>
			</TAble>
			<BR>
			<table class="tcontent" align="center">
				<TR class="intestazione">
					<td width="18%">N° tessera <a href="soci?action=insert&page=first&orderby=tessera"><img src="img/giu.gif" border="0"></a></td>
					<TD width="30%">Cognome <a href="soci?action=insert&page=first&orderby=cognome"><img src="img/giu.gif" border="0"></TD>
					<td width="30%">Nome <a href="soci?action=insert&page=first&orderby=nome"><img src="img/giu.gif" border="0"></td>
					<td width="25%">Città <a href="soci?action=insert&page=first&orderby=citta"><img src="img/giu.gif" border="0"></td>
				</TR>
<%
				for(int i = 0; i <ListaSoci.size(); i++)
				{
					SociId s = ((Soci) ListaSoci.get(i)).getId();
%>
					<TR id="row<%= i%2 %>">
						<TD><a href="soci?action=view&tessera=<%= s.getTessera() %>"><%= s.getTessera() %></a></TD>
						<TD><a href="soci?action=view&tessera=<%= s.getTessera() %>"><%= s.getCognome() %></a></TD>
						<TD><%= s.getNome() %></TD>
						<TD><%= s.getCitta() %></TD>
					</TR>
<%	
				}
%>
			</table>
			<BR><BR>
<%
			if(tessera.equals(""))
			{
%>
			<table class="tcontent" align="center">
				<tr>
					<TD><B>Nominativi non soci ma presenti nell'anagrafe : </B></TD>
				</tr>
			</table>
			<table class="tcontent" align="center">
				<TR class="intestazione">
					<TD width="18%"></TD>
					<TD width="30%">Cognome</TD>
					<td width="30%">Nome</td>
					<td width="25%">Città</td>
				</TR>
<%
				for(int y = 0; y < ListaNonSoci.size(); y++)
				{
					NonsociId a = ((Nonsoci) ListaNonSoci.get(y)).getId();
%>
					<TR id="row<%= y%2 %>">
						<TD></TD>
						<TD><a href="soci?action=insert&page=new&id=<%= a.getId() %>"><%= a.getCognome() %></a></TD>
						<TD><a href="soci?action=insert&page=new&id=<%= a.getId() %>"><%= a.getNome() %></a></TD>
						<TD><%= a.getCitta() %></TD>
					</TR>
<%	
				}
%>
			</TABLE>
<%
			}
%>
			<table class="tcontent" align="center">
				<TR>
					<TD align="center">
						<input type="button" value="Visualizza tutti" onClick="window.location.href='soci?action=insert&page=first'">
					</TD>
				</TR>
			</table>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2005</P>
		</DIV>
	</div>
</BODY>
</HTML>
