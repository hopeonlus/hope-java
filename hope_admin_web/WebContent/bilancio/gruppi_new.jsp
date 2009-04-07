<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	Avviso err = (Avviso) request.getAttribute("err");
	
	String nome = request.getParameter("nome");
	String tipo = request.getParameter("tipo");
	
	if(nome == null)
		nome = "";
	if(tipo == null)
		tipo = "";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<script language="javascript">
<!--
function isOk(){
	
	if(document.gruppo.nome.value == '')
	{
		alert('Il campo NOME è vuoto!');
		return false;
	}
	
	var index = document.gruppo.tipo.selectedIndex;
	if(document.gruppo.tipo.options[index].value == -1)
	{
		alert('Seleziona un TIPO!');
		return false;
	}
	
	return true;
}

//-->
</script>

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
				<li><a href="accedibilancio">Home</a></li>
				<li><a href="scritture">Scritture</a></li>
				<li><a id="current">Conti</a></li>
				<li><a href="bilancio">Bilancio</a></li>
				<li><a href="../accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div align="center" style="padding-top:3px ">
			<ul style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:90%; ">
				<li><a href="conti?action=view&what=conti">Gestione Conti</a></li>
				<li><a id="current1">Gestione Gruppi</a></li>
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
		<FORM name="gruppo" action="conti" method="post" onSubmit="return isOk()">
			<TABLE class="tcontent" align="center">
				<TR>
					<TD><B>Nome Gruppo : </B></TD>
					<TD><input type="text" name="nome" style="width:300px; " value="<%= nome %>"></TD>
				</TR>
				<TR>
					<TD><B>Tipo : </B></TD>
					<TD>
						<select name="tipo" style="width:100px ">
								<option value="-1"></option>
								<option value="1" <% if(tipo.equals("1")) out.println("selected");%> >Costi</option>
								<option value="2" <% if(tipo.equals("2")) out.println("selected");%> >Ricavi</option>
								<option value="3" <% if(tipo.equals("3")) out.println("selected");%> >Attività</option>
								<option value="4" <% if(tipo.equals("4")) out.println("selected");%> >Passività</option>
						</select>
					</TD>
				</TR>
				<TR><TD><BR></TD></TR>
				<TR>
					<TD align="left">
						<input type="button" value="Indietro" onClick="window.location.href='conti?action=view&what=gruppi'">
					</TD>
					<TD align="right">
						<input type="submit" value="Inserisci">
					</TD>
				</TR>
			</TABLE>
			<INPUT type="hidden" name="action" value="insert">
			<INPUT type="hidden" name="what" value="gruppi">
		</FORM>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2005</P>
		</DIV>
	</div>
</BODY>
</HTML>
