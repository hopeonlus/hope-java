<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	List ListaConti = (List) request.getAttribute("listaconti");
	Movimenti m = (Movimenti) request.getAttribute("movimento");
	Avviso err = (Avviso) request.getAttribute("err");
	
	String nome = m.getNome();
	String descrizione = m.getDescrizione();
	int dare = m.getDare().getId().intValue();
	int avere = m.getAvere().getId().intValue();
	
	if(descrizione == null)
		descrizione = "";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<script language="javascript">
<!--

function isOk()
{
	if(checkconti())
		if(document.movimento.nome.value != '')
			return true;
		else
			alert("Campo NOME vuoto");
			
	return false;
}

function checkconti(){
	var indexDare = document.movimento.dare.selectedIndex;
	var indexAvere = document.movimento.avere.selectedIndex;
	
	var Dare_sel = document.movimento.dare.options[indexDare].value;
	var Avere_sel = document.movimento.avere.options[indexAvere].value;
	
	if((Avere_sel == '-1')|(Dare_sel == '-1'))
	{
		alert('Seleziona sia DARE che AVERE!');
		return false;
	}
	else
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
				<li><a id="current">Scritture</a></li>
				<li><a href="conti">Conti</a></li>
				<li><a href="bilancio">Bilancio</a></li>
				<li><a href="../accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div align="center" style="padding-top:3px ">
			<ul style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:90%; ">
				<li><a href="scritture?action=page">Visualizza</a></li>
				<li><a href="scritture?action=new">Nuova</a></li>
				<li><a id="current1">Movimenti</a></li>
				<li><a href="#">Cerca</a></li>
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
		<FORM name="movimento" action="scritture" method="post" onSubmit="return isOk()">
			<TABLE class="tcontent" align="center">
				<TR>
					<TD width="35%"><B>Nome movimento : </B></TD>
					<TD><input type="text" name="nome" style="width:180px " value="<%= nome %>"></TD>
				</TR>
				<TR>
					<TD><B>Descrizione : </B></TD>
					<TD><textarea name="descrizione" cols="40" rows="2" style="font:Arial, Helvetica, sans-serif; "><%= descrizione %></textarea></TD>
				</TR>
				<TR>
					<TD><B>Dare : </B></TD>
					<TD>
						<select name="dare" style="width:300px; ">
								<option value="-1"></option>
<%
						int previous = -1;
						for(int i = 0; i < ListaConti.size(); i++) {
							ContogruppoId current = ((Contogruppo) ListaConti.get(i)).getId();
							int id = current.getId().intValue();
							if(previous == current.getGruppo().intValue())
							{
%>
								<option value="<%= id %>" <% if(id == dare) out.print(" selected "); %>><%= current.getNomeconto() %></option>
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
							<optgroup label="<%= current.getNomegruppo() %>">
								<option value="<%= id %>" <% if(id == dare) out.print(" selected "); %>><%= current.getNomeconto() %></option>
<%
							
							}
							previous = current.getGruppo().intValue();
						}
%>
							</optgroup>
						</select>
					</TD>
				</TR>
				<TR>
					<TD><B>Avere : </B></TD>
					<TD>
						<select name="avere" style="width:300px; ">
								<option value="-1"></option>
<%
						previous = -1;
						for(int i = 0; i < ListaConti.size(); i++) {
							ContogruppoId current = ((Contogruppo) ListaConti.get(i)).getId();
							int id = current.getId().intValue();
							if(previous == current.getGruppo().intValue())
							{
%>
								<option value="<%= id %>" <% if(id == avere) out.print(" selected "); %>><%= current.getNomeconto() %></option>
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
							<optgroup label="<%= current.getNomegruppo() %>">
								<option value="<%= id %>" <% if(id == avere) out.print(" selected "); %>><%= current.getNomeconto() %></option>
<%
							
							}
							previous = current.getGruppo().intValue();
						}
%>
							</optgroup>
						</select>
					</TD>
				</TR>
				<TR><TD></TD></TR>
				<TR>
					<TD align="left">
						<input type="button" value="Indietro" onClick="window.location.href='scritture?action=page&what=movimenti'">
					</TD>
					<TD align="right">
						<INPUT type="submit" value="Inserisci">
					</TD>
				</TR>
			</TABLE>
			<INPUT type="hidden" name="action" value="edit">
			<INPUT type="hidden" name="what" value="movimenti">
			<input type="hidden" name="id" value="<%= m.getId() %>"
		</FORM>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2005</P>
		</DIV>
	</div>
</BODY>
</HTML>
