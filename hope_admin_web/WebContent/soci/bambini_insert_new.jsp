<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	Avviso err = (Avviso) request.getAttribute("err");
	
	java.util.Date data = new java.util.Date();
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("dd/MM/yyyy");
    String oggi = formatter.format(data);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<script language="javascript">
<!--
function isOk(w)
{
	if((w.nome.value == '')|(w.datanascita.value == '')|(w.anno.value == '')|(w.scuola.value == '')|(w.citta.value == '')|(w.nazione.value == ''))
	{
		alert('Completare i campi obbligatori! (*)');
		return false;
	}
	if(isNaN(w.anno.value))
	{
		alert('ANNO non valido');
		return false;
	}
	else if(parseInt(w.anno.value) < 1950)
	{
		alert("Inserire un anno successivo al 1950!");
		return false;
	}
	if(!isOkData(w))
	{
		alert("Data di nascita non corretta!");
		return false;
	}
	if(isNaN(w.costo.value))
	{
		alert('COSTO non valido (solo interi!)');
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
						<input type="text" name="nome" style="width:150px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Sesso : </B></TD>
					<TD>
						<select name="sesso">
							<option>M</option>
							<option>F</option>
						</select>
					</TD>
				</TR>
				<TR>
					<TD><B>Indirizzo : </B></TD>
					<TD>
						<input type="text" name="indirizzo" style="width:300px ">
					</TD>
				</TR>
				<TR>
					<TD><B>Città : </B></TD>
					<TD>
						<input type="text" name="citta" style="width:200px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Nazione : </B></TD>
					<TD>
						<input type="text" name="nazione" style="width:150px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Data di Nascita (gg/mm/aaaa) : </B></TD>
					<TD>
						<input type="text" name="datanascita" style="width:150px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Scuola : </B></TD>
					<TD>
						<input type="text" name="scuola" style="width:150px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Descrizione : </B></TD>
					<TD><textarea name="descrizione" cols="40" rows="2" style="font:Arial, Helvetica, sans-serif; "></textarea></TD>
				</TR>
				<TR>
					<TD><B>Disponibile per l'ANNO : </B></TD>
					<TD>
						<input type="text" name="anno" style="width:80px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Costo annuo : </B></TD>
					<TD>
						<input type="text" name="costo" style="width:80px ">&nbsp&nbsp;€&nbsp&nbsp;* (no decimali)
					</TD>
				</TR>
				<TR><TD colspan="2"><BR></TD></TR>
				<TR>
					<TD align="left">
						<INPUT type="button" value="Indietro" onClick="javascript:history.back()">
					</TD>
					<TD align="right">
						<input type="submit" value="Inserisci">
					</TD>
				</TR>
			</TABLE>
			<input type="hidden" name="action" value="insertbambino">
			<input type="hidden" name="page" value="insert">
			<INPUT type="hidden" name="oggi" value="<%= oggi %>">
		</FORM>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2005</P>
		</DIV>
	</div>
</BODY>
</HTML>
