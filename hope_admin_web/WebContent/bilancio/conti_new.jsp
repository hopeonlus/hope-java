<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	List ListaGruppi = (List) request.getAttribute("listagruppi");
	Avviso err = (Avviso) request.getAttribute("err");
	
	String nome = request.getParameter("nome");
	String gruppo = request.getParameter("gruppo");
	
	if(nome == null)
		nome = "";
	if(gruppo == null)
		gruppo = "";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<script language="javascript">
<!--
function isOk(){
	
	if(document.conto.nome.value == '')
	{
		alert('Il campo NOME è vuoto!');
		return false;
	}
	
	var index = document.conto.gruppo.selectedIndex;
	if(document.conto.gruppo.options[index].value == -1)
	{
		alert('Seleziona un GRUPPO');
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
				<li><a id="current1">Gestione Conti</a></li>
				<li><a href="conti?action=view&what=gruppi">Gestione Gruppi</a></li>
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
		<FORM name="conto" action="conti" method="post" onSubmit="return isOk()">
			<TABLE class="tcontent" align="center">
				<TR>
					<TD><B>Nome Conto : </B></TD>
					<TD><input type="text" name="nome" style="width:300px; " value="<%= nome %>"></TD>
				</TR>
				<TR>
					<TD><B>Gruppo : </B></TD>
					<TD>
						<select name="gruppo" style="width:300px; ">
								<option value="-1"></option>
<%
						int previous = -1;
						for(int i = 0; i < ListaGruppi.size(); i++)
						{
							Gruppo g = (Gruppo) ListaGruppi.get(i);
							String id = g.getId().toString();
							int tipo = g.getTipo().intValue();
							String tipoStr = "";
							if(tipo == 1)
								tipoStr = "Costi";
							else if(tipo == 2)
								tipoStr = "Ricavi";
							else if(tipo == 3)
								tipoStr = "Attività";
							else if(tipo == 4)
								tipoStr = "Passività";
							if(tipo == previous)
							{
%>
								<option value="<%= id %>" <% if(gruppo.equals(id)) out.print("selected"); %> ><%= g.getNome() %></option>
<%							
							}
							else
							{
								if(previous != -1)
								{
%>
							</optgroup>
<%
								}
%>
							<optgroup label="<%= tipoStr %>">
								<option value="<%= id %>" <% if(gruppo.equals(id)) out.print("selected"); %> ><%= g.getNome() %></option>
<%
							}
							
							previous = tipo;
						}
%>
							</optgroup>
						</select>
					</TD>
				</TR>
				<TR><TD><BR></TD></TR>
				<TR>
					<TD align="left">
						<input type="button" value="Indietro" onClick="window.location.href='conti?action=view&what=conti'">
					</TD>
					<TD align="right">
						<input type="submit" value="Inserisci">
					</TD>
				</TR>
			</TABLE>
			<INPUT type="hidden" name="action" value="insert">
			<INPUT type="hidden" name="what" value="conti">
		</FORM>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2005</P>
		</DIV>
	</div>
</BODY>
</HTML>
