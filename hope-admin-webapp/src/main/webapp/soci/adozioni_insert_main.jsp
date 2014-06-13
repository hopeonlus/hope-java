<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%	
	List Anagrafe = (List) request.getAttribute("anagrafe");	
	
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
function isOk2(){

	if(document.cerca2.cognome.value != '')
		return true;
	else
		alert('Campo COGNOME vuoto!');
		
	return false;
}

function svuota()
{
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
				<li><a href="soci">Soci</a></li>
				<!--<li><a href="#">Azionisti</a></li>-->
				<li><a id="current">Adozioni</a></li>
				<li><a href="stampa">Stampa</a></li>
				<li><a href="../accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div align="center" style="padding-top:3px ">
			<ul style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:90%; ">
				<li><a id="current1" href="adozioni">Adottanti</a></li>
				<li><a href="adozioni?action=page&page=bambini">Bambini</a></li>
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

	<form name="cerca2" action="adozioni" method="post" onSubmit="return isOk2()">
			<TABLE class="tcontent" align="center">
				<TR class="intestazione">
					<TD colspan="2">
						Cerca se il nominativo del nuovo adottante è se già presente. Altrimenti seleziona "NUOVO NOMINATIVO".
					</TD>
				</TR>
				<TR><TD></TD></TR>
			<TR>
					<TD align="right">
						<B>Cognome : </B><input type="text" name="cognome" value="<%= cognome %>" onClick="javascript:svuota()">
					</TD>
					<TD align="left" style="padding-left:30px ">
						<input type="submit" value="Trova">
					</TD>
				</TR>
				<input type="hidden" name="what" value="cognome"/>
				<input type="hidden" name="action" value="insert"/>
				<input type="hidden" name="page" value="first"/>
			</TABLE>
		</form>
			<BR>
			<TAble class="tcontent" align="center">
				<TR>
					<TD align="center">
						<input type="button" value="Nuovo Nominativo" onClick="window.location.href='adozioni_insert_new.jsp'">
					</TD>
				</TR>
			</TAble>
			<BR>
			<table class="tcontent" align="center">
				<TR class="intestazione">
					<TD width="36%">Cognome</TD>
					<td width="36%">Nome</td>
					<td width="28%">Città</td>
				</TR>
<%
				for(int i = 0; i < Anagrafe.size(); i++)
				{
					Anagrafe a = (Anagrafe) Anagrafe.get(i);
%>
					<TR id="row<%= i%2 %>">
						<TD><a href="adozioni?action=insert&page=new&id=<%= a.getId() %>"><%= a.getCognome() %></a></TD>
						<TD><a href="adozioni?action=insert&page=new&id=<%= a.getId() %>"><%= a.getNome() %></a></TD>
						<TD><%= a.getCitta() %></TD>
					</TR>
<%	
				}
%>
			</table>
			<BR>
			<table class="tcontent" align="center">
				<TR>
					<TD align="left" width="33%">
						<input type="button" value="Indietro" onClick="javascript:history.back()">
					</TD>
					<TD align="center" width="33%">
						<input type="button" value="Visualizza tutti" onClick="window.location.href='adozioni?action=insert&page=first'">
					</TD>
					<TD>
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
