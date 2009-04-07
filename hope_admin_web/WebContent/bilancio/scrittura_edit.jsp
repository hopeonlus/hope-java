<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	List ListaConti = (List) request.getAttribute("listaconti");
	Scrittura scr = (Scrittura) request.getAttribute("scrittura");
	
	Avviso err = (Avviso) request.getAttribute("err");
	
	Date d = scr.getData();
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("dd/MM/yyyy");
	String current_data = formatter.format(d);
	String descrizione = scr.getDescrizione();
	float importo = scr.getImporto();
	String dareStr = scr.getDare().getId().toString();
	String avereStr = scr.getAvere().getId().toString();

	int dare = -1;
	int avere = -1;
	
	if(dareStr != null)
		dare = Integer.parseInt(dareStr);
	if(avereStr != null)
		avere = Integer.parseInt(avereStr);
	if(descrizione == null)
		descrizione = "";

	if(current_data == null)
		current_data = "";
		
	java.util.Date data = new java.util.Date();
    String oggi = formatter.format(data);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<script language="javascript">
<!--

var msg = 'DATA non inserita correttamente'

function isOk(){
	
	var dd, mm, yyyy, Tmm, Tdd, Tyyyy
	var tot = document.scrittura.data.value
	var tot_array = tot.split("/")
	var today = document.scrittura.oggi.value
	var today_array = today.split("/")
		if(tot_array.length == 3){
			dd = tot_array[0]
			mm = tot_array[1]
			yyyy = tot_array[2]
			
			Tdd = today_array[0]
			Tmm = today_array[1]
			Tyyyy = today_array[2]
			
			var tot_int = parseInt(yyyy+mm+dd)
			var today_int = parseInt(Tyyyy+Tmm+Tdd)
			
			var d = parseInt(dd)
			var m = parseInt(mm)
			var y = parseInt(yyyy)
			
			if(OK(d, m, y, tot_int, today_int))
			{
				if(importo())
				{
					if(checkconti())
						return true;
					else
					{
						alert("Selezionare sia DARE che AVERE!")
						return false;
					}
				}
				else
				{
					alert("IMPORTO non inserito correttamente")
					return false;
				}
			}
		}
		
	alert(msg)
	
	return false
}

function OK(d, m, y, tot_int, today_int){
	
	if(tot_int <= today_int)
	{
		if(y > 1900)
		{
			if((d < 32)&&(m < 13)&&(m > 0)&&(d > 0))
			{
				if((m == 02)&(d > 29))
					return false
				if((d == 31)&((m == 11)|(m == 4)|(m == 6)|(m == 9)))
					return false
				return true
			}
		}
	}
	else
	{
		msg = 'La DATA inserita è successiva ad oggi'
		return false
	}
	
	msg = 'DATA non inserita correttamente'
	return false
}

function importo()
{
	var tot_array = (document.scrittura.importo.value).split(".")
	if(tot_array.length == 2)
	{
		if(!((isNaN(tot_array[0]))|(isNaN(tot_array[1]))))
			return true;
		else
			return false;
	}
	else if(tot_array.length == 1)
	{
		if((isNaN(tot_array[0]))|(tot_array[0] == ''))
			return false;
		else
			return true;
	}
	
	return false;
}

function checkconti(){
	var indexDare = document.scrittura.dare.selectedIndex;
	var indexAvere = document.scrittura.avere.selectedIndex;
	
	var Dare_sel = document.scrittura.dare.options[indexDare].value;
	var Avere_sel = document.scrittura.avere.options[indexAvere].value;
	
	if((Avere_sel == '-1')|(Dare_sel == '-1'))
		return false;
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
				<li><a id="current1">Visualizza</a></li>
				<li><a href="scritture?action=new">Nuova</a></li>
				<li><a href="scritture?action=page&what=movimenti">Movimenti</a></li>
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
		<FORM name="scrittura" action="scritture" method="get" onSubmit="return isOk()">
			<TABLE class="tcontent" align="center">
				<TR>
					<TD><B>Data (gg/mm/aaaa) : </B></TD>
					<TD><input type="text" name="data" maxlength="10" value="<%= current_data %>"></TD>
				</TR>
				<TR>
					<TD><B>Descrizione : </B></TD>
					<TD><textarea name="descrizione" cols="40" rows="3" style="font:Arial, Helvetica, sans-serif; "><%= descrizione %></textarea></TD>
				</TR>
				<TR>
					<TD><B>Importo : </B></TD>
					<TD><input type="text" name="importo" style="text-align:right " value="<%= importo %>"> <B>&nbsp;&nbsp;Euro</B></TD>
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
				<TR><TD><BR></TD></TR>
				<TR>
					<TD align="left">
						<INPUT type="button" value="Indietro" onClick="javascript:history.back()">
					</TD>
					<TD align="right">
						<INPUT type="submit" value="Salva">
					</TD>
				</TR>
			</TABLE>
			<INPUT TYPE="hidden" name="id" value="<%= scr.getId() %>">
			<INPUT type="hidden" name="action" value="edit">
			<INPUT type="hidden" name="oggi" value="<%= oggi %>">
			<INPUT type="hidden" name="what" value="<%= request.getParameter("what") %>">
			<INPUT type="hidden" name="anno" value="<%= request.getParameter("anno") %>">
			<INPUT type="hidden" name="dal" value="<%= request.getParameter("dal") %>">
			<INPUT type="hidden" name="al" value="<%= request.getParameter("al") %>">
		</FORM>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2005</P>
		</DIV>
	</div>
</BODY>
</HTML>
