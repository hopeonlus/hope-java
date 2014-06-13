<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	List B = (List) request.getAttribute("bambino");
	BambinoannoviewId baw = ((Bambinoannoview) B.get(0)).getId();
	
	Avviso err = (Avviso) request.getAttribute("err");
	
	java.util.Date data = new java.util.Date();
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("dd/MM/yyyy");
    String oggi = formatter.format(data);
	
	String datanascita = formatter.format(baw.getDatanascita());
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<script language="javascript">
<!--

var anni = 1;

function isOk(w)
{
	if((w.nome.value == '')|(w.datanascita.value == '')|(w.scuola.value == '')|(w.citta.value == '')|(w.nazione.value == ''))
	{
		alert('Completare i campi obbligatori! (*)');
		return false;
	}
	if(!isOkData(w))
	{
		alert("Data di nascita non corretta!");
		return false;
	}
	
	return true;
}

function isOkData(w){
	
	var dd, mm, yyyy, Tmm, Tdd, Tyyyy
	var tot = w.datanascita.value
	var tot_array = tot.split("/")
	var today = w.oggi.value
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
			
			<!--
			if(OK(d, m, y, tot_int, today_int))
			{
				return true;
			}
			//-->
			<!-- da eliminare //-->
			if(tot_int <= today_int)
			{
			if(y > 1900)
			{
				return true;
			}
			}
		}
	
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
		return false
	}
	
	return false
}

function mostraAnno()
{
	el1=document.getElementById('a');
	
	el1.style.display="block";
	document.bambino.annob.disabled = false;
	document.bambino.costob.disabled = false;
	document.bambino.nuovoanno.disabled = true;
	document.bambino.annulla.disabled = false;
}

function hideAnno()
{
	el1=document.getElementById('a');
	
	el1.style.display="none";
	document.bambino.annob.disabled = true;
	document.bambino.costob.disabled = true;
	document.bambino.nuovoanno.disabled = false;
	document.bambino.annulla.disabled = true;
}

function checkAnno()
{
	if(document.bambino.annob.value == '')
	{
		alert('ANNO non valido');
		return false;
	}
	if(isNaN(document.bambino.annob.value))
	{
		alert('ANNO non valido');
		return false;
	}
	else if(parseInt(document.bambino.annob.value) < 1950)
	{
		alert("Inserire un anno successivo al 1950!");
		return false;
	}
	
	return true;
}

function inoltra()
{
	window.location.href = 'adozioni?action=insertbambino&page=anno&anno=<%= request.getParameter("anno") %>&id=<%= baw.getId() %>&annob=' + document.bambino.annob.value + '&costob=' + document.bambino.costob.value;
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
				<li><a href="adozioni">Adottanti</a></li>
				<li><a id="current1">Bambini</a></li>
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
		<FORM name="bambino" action="adozioni" method="post" onSubmit="return isOk(this)">
			<TABLE class="tcontent" align="center">
				<TR>
					<TD><B>Nome : </B></TD>
					<TD>
						<input type="text" name="nome" value="<%= baw.getNome() %>" style="width:150px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Sesso : </B></TD>
					<TD>
						<select name="sesso">
							<option <% if(baw.getSesso().equals("M")) out.print(" selected "); %>>M</option>
							<option <% if(baw.getSesso().equals("F")) out.print(" selected "); %>>F</option>
						</select>
					</TD>
				</TR>
				<TR>
					<TD><B>Indirizzo : </B></TD>
					<TD>
						<input type="text" name="indirizzo" value="<%= baw.getIndirizzo() %>" style="width:300px ">
					</TD>
				</TR>
				<TR>
					<TD><B>Città : </B></TD>
					<TD>
						<input type="text" name="citta" value="<%= baw.getCitta() %>" style="width:200px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Nazione : </B></TD>
					<TD>
						<input type="text" name="nazione" value="<%= baw.getNazione() %>" style="width:150px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Data di Nascita (gg/mm/aaaa) : </B></TD>
					<TD>
						<input type="text" name="datanascita" value="<%= datanascita %>" style="width:150px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Scuola : </B></TD>
					<TD>
						<input type="text" name="scuola" value="<%= baw.getScuola() %>" style="width:150px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Descrizione : </B></TD>
					<TD><textarea name="descrizione" cols="40" rows="2" style="font:Arial, Helvetica, sans-serif; "><%= baw.getDescrizione() %></textarea></TD>
				</TR>
				<TR>
					<TD valign="top"><B>ANNI : </B></TD>
					<TD valign="top">
						<TABLE class="tcontent" cellpadding="0" cellspacing="0" style="width:30% ">
<%
					for(int i = 0; i < B.size(); i++)
					{
						BambinoannoviewId b = ((Bambinoannoview) B.get(i)).getId();
%>
							<TR>
								<TD>
									<%= b.getAnno() %> 
								</TD>
								<TD>
									<%= b.getCosto() %> €
								</TD>
								<TD>
<%
								if(B.size() == 1)
								{
									out.print("<img src=\"img/delno.gif\" border=\"0\">");
								}
								else
								{
%>
									<a href="adozioni?action=del&page=anno&anno=<%= request.getParameter("anno") %>&annob=<%= b.getAnno() %>&id=<%= b.getId() %>" onclick="return(confirm('Verrà elimitata anche la adozione relativa all'anno <%= b.getAnno() %>? Sicuro? '))"><img src="img/del.gif" border="0"></a>
<%
								}
%>
								</TD>
							</TR>
<%
					}
%>
							<TR id="a" style="display:none ">
								<TD>
									<input type="text" name="annob" style="width:40px " maxlength="4" disabled>
								</TD>
								<TD>
									<input type="text" name="costob" style="width:40px " disabled>&nbsp;&nbsp;€
								</TD>
								<TD>
									<a onClick="javascript:if(checkAnno()) inoltra()"><img src="img/save.jpg" border="0" style="cursor:pointer "></a>
								</TD>
							</TR>
						</TABLE>
						<TABLE class="tcontent" cellpadding="0" cellspacing="0" style="width:30% ">
							<TR>
								<TD align="left"><input name="annulla" type="button" value="Annulla" onClick="javascript:hideAnno()" disabled></TD>
								<TD align="right"><input name="nuovoanno" type="button" value="Aggiungi" onClick="javascript:mostraAnno()"></TD>
							</TR>
						</TABLE>
									
					</TD>
				</TR>
				<TR><TD colspan="2"><BR></TD></TR>
				<TR>
					<TD colspan="2">
						<TABLE width="100%">
							<TR>
								<TD align="left" width="33%">
									<INPUT type="button" value="Indietro" onClick="javascript:window.location.href='adozioni?action=page&page=bambini&anno=<%= request.getParameter("anno") %>'">
								</TD>
								<TD align="center" width="33%">
									<input type="button" value="Elimina" onClick="javascipt:if(confirm('Verranno eliminati TUTTI i dati relativi al bambino ed alle adozioni relative!\nSicuro?')) window.location.href='adozioni?action=del&page=bambino&id=<%= baw.getId() %>&anno=<%= request.getParameter("anno") %>'">
								</TD>
								<TD align="right">
									<input type="submit" value="Salva">
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
			<input type="hidden" name="action" value="insertbambino">
			<input type="hidden" name="page" value="save">
			<input type="hidden" name="id" value="<%= baw.getId() %>">
			<INPUT type="hidden" name="oggi" value="<%= oggi %>">
			<input type="hidden" name="anno" value="<%= request.getParameter("anno") %>">
		</FORM>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2005</P>
		</DIV>
	</div>
</BODY>
</HTML>
