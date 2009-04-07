<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	Anagrafe a = (Anagrafe) request.getAttribute("nominativo");
	String id, cognome, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale;
	if(a == null)
	{
		id = cognome = nome = indirizzo = cap= citta = nazione = telefono = cellulare = email = codfiscale = "";
	}
	else
	{
		if(a.getId() != null)
			id = a.getId().toString();
		else
			id = "";
			
		cognome= a.getCognome();
		nome = a.getNome();
		indirizzo = a.getIndirizzo();
		cap = a.getCap();
		citta = a.getCitta();
		nazione = a.getNazione();
		telefono = a.getTelefono();
		cellulare = a.getCellulare();
		email = a.getEmail();
		codfiscale = a.getCodfiscale();
	}
	
	Avviso err = (Avviso) request.getAttribute("err");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<script language="javascript">
<!--
function isOk(w)
{
	if((w.nome.value == '')|(w.cognome.value == '')|(w.indirizzo.value == '')|(w.cap.value == '')|(w.citta.value == '')|(w.nazione.value == ''))
	{
		alert('Completare i campi obbligatori! (*)');
		return false;
	}
	
	return true;
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
				<li><a id="current1">Adottanti</a></li>
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
		<FORM name="adottante" action="adozioni_insert_new_anno.jsp" method="post" onSubmit="return isOk(this)">
			<TABLE class="tcontent" align="center">
				<TR>
					<TD width="40%"><B>Cognome : </B></TD>
					<TD>
						<input type="text" name="cognome" value="<%= cognome %>" style="width:150px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Nome : </B></TD>
					<TD>
						<input type="text" name="nome" value="<%= nome %>" style="width:150px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Indirizzo : </B></TD>
					<TD>
						<input type="text" name="indirizzo" value="<%= indirizzo %>" style="width:300px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>CAP : </B></TD>
					<TD>
						<input type="text" name="cap" value="<%= cap %>" style="width:80px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Città (prov) : </B></TD>
					<TD>
						<input type="text" name="citta" value="<%= citta %>" style="width:200px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Nazione : </B></TD>
					<TD>
						<input type="text" name="nazione" value="<%= nazione %>" style="width:150px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Telefono : </B></TD>
					<TD>
						<input type="text" name="telefono" value="<%= telefono %>" style="width:150px ">
					</TD>
				</TR>
				<TR>
					<TD><B>Cellulare : </B></TD>
					<TD>
						<input type="text" name="cellulare" value="<%= cellulare %>" style="width:150px ">
					</TD>
				</TR>
				<TR>
					<TD><B>E-mail : </B></TD>
					<TD>
						<input type="text" name="email" value="<%= email %>" style="width:200px ">
					</TD>
				</TR>
				<TR>
					<TD><B>Codice Fiscale : </B></TD>
					<TD>
						<input type="text" name="codfiscale" value="<%= codfiscale %>" style="width:150px ">
					</TD>
				</TR>
				<TR>
					<TD><B>Inviare comunicazioni via POSTA? </B></TD>
					<TD>
						<input type="radio" name="posta" value="true" checked> Si &nbsp&nbsp&nbsp&nbsp&nbsp; <input type="radio" name="posta" value="false"> No
					</TD>
				</TR>
				<TR><TD colspan="2"><BR></TD></TR>
				<TR>
					<TD align="left">
						<INPUT type="button" value="Indietro" onClick="javascript:history.back()">
					</TD>
					<TD align="right">
						<input type="submit" value="Avanti > ">
					</TD>
				</TR>
			</TABLE>
			<input type="hidden" name="id" value="<%= id %>">
		</FORM>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2005</P>
		</DIV>
	</div>
</BODY>
</HTML>
