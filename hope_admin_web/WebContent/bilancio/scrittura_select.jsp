<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	Avviso err = (Avviso) request.getAttribute("err");
	
	java.util.Date data = new java.util.Date();
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("dd/MM/yyyy");
    String oggi = formatter.format(data);
	
	Calendar cal = new GregorianCalendar();
	cal.setTime(data);
	int anno = cal.get(Calendar.YEAR);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<script language="javascript">
<!--
var msg = 'Campo DAL o AL non valido!';

function isOk()
{
	for(i = 0; i < document.selezione.length; i++)
	{
		if(document.selezione.elements[i].name == 'what')
		{
			if(document.selezione.elements[i].checked)
			{
				if(document.selezione.elements[i].value == 'tutte')
				{
					return true;
				}
				else if(document.selezione.elements[i].value == 'anno')
				{
					if(isNaN(document.selezione.anno.value))
					{
						alert("L'ANNO deve essere un numero!");
						return false;
					}
					else if(parseInt(document.selezione.anno.value) < 1900)
					{
						alert("Inserire un anno successivo al 1900!");
						return false;
					}
					else if(document.selezione.anno.value == '')
					{
						alert("Campo ANNO vuoto!");
							return false;
					}
					return true;
				}
				else if(document.selezione.elements[i].value == 'periodo')
				{
					if(data(document.selezione.dal.value))
						if(data(document.selezione.al.value))
						{
							if(successiva())
								return true;
							else
							{
								alert('La data DAL è successiva alla data AL');
								return false;
							}
						}
					
					return false;
				}
			}
		}
	}
}

function data(tot){

	var dd, mm, yyyy, Tmm, Tdd, Tyyyy
	var tot_array = tot.split("/")
	var today = document.selezione.oggi.value
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
				return true;
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
		msg = 'Campo DAL o AL è successivo ad oggi'
		return false
	}
	
	msg = 'Campo DAL o AL non inserito correttamente'
	return false
}

function successiva()
{
	var dd, mm, yyyy, Tmm, Tdd, Tyyyy
	var dal = document.selezione.dal.value
	var dal_array = dal.split("/")
	var al = document.selezione.al.value
	var al_array = al.split("/")
	
	dd = dal_array[0]
	mm = dal_array[1]
	yyyy = dal_array[2]
			
	Tdd = al_array[0]
	Tmm = al_array[1]
	Tyyyy = al_array[2]
			
	var dal_int = parseInt(yyyy+mm+dd)
	var al_int = parseInt(Tyyyy+Tmm+Tdd)
	
	if(dal_int <= al_int)
		return true;
	else
		return false;
}

function dis()
{
	for(i = 0; i < document.selezione.length; i++)
	{
		if(document.selezione.elements[i].name == 'what')
		{
			if(document.selezione.elements[i].checked)
			{
				if(document.selezione.elements[i].value == 'tutte')
				{
					document.selezione.anno.disabled = true;
					document.selezione.dal.disabled = true;
					document.selezione.al.disabled = true;
					break;
				}
				else if(document.selezione.elements[i].value == 'anno')
				{
					document.selezione.anno.disabled = false;
					document.selezione.dal.disabled = true;
					document.selezione.al.disabled = true;
					break;
				}
				else if(document.selezione.elements[i].value == 'periodo')
				{
					document.selezione.anno.disabled = true;
					document.selezione.dal.disabled = false;
					document.selezione.al.disabled = false;
					break;
				}
			}
		}
	}
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
		<TABLE class="terroremaxi" align="center" cellspacing="0">
			<TR>
				<TD class="errore" align="left"><IMG SRC="./img/errore.gif"></TD>			
				<TD class="errore"><p align="center"><%= err.getTesto() %></p></TD>				
				<TD class="errore" align="right"><IMG SRC="./img/errore.gif" align="right"></TD>			
			</TR>
		</TABLE>
<%
		}
%>
		<FORM name="selezione" action="scritture" method="get" onSubmit="return isOk()">
			<TABLE class="tcontent" align="center" style="width:25% ">
				<TR>
					<TD>
						<input type="radio" name="what" value="tutte" onClick="javascript:dis();" checked>
					</TD>
					<TD colspan="3">
						Tutte
					</TD>
				</TR>
				<TR>
					<TD>
						<input type="radio" name="what" value="anno" onClick="javascript:dis();">
					</TD>
					<TD>Anno</TD>
					<TD colspan="2">
						<input type="text" name="anno" style="width:50px; height:18px; font-size:9px; vertical-align:bottom" maxlength="4" value="<%= anno %>" disabled>
					</TD>
				</TR>
				<TR>
					<TD>
						<input type="radio" name="what" value="periodo" onClick="javascript:dis();">
					</TD>
					<TD>Periodo</TD>
					<TD align="right">dal</TD>
					<TD>
						<input type="text" name="dal" style="width:80px; height:18px; font-size:9px; vertical-align:bottom" maxlength="10" value="<%= oggi %>" disabled>
					</TD>
				</TR>
				<TR>
					<TD></TD>
					<TD></TD>
					<TD align="right">al</TD>
					<TD>
						<input type="text" name="al" style="width:80px; height:18px; font-size:9px; vertical-align:bottom;" maxlength="10" value="<%= oggi %>" disabled>
					</TD>
				</TR>
				<TR>
					<TD colspan="4" align="center">
						<BR><input type="submit" value="Visualizza">
					</TD>
				</TR>
			</TABLE>
			<input type="hidden" name="action" value="select">
			<input type="hidden" name="oggi" value="<%= oggi %>">
		</FORM>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2005</P>
		</DIV>
	</div>
</BODY>
</HTML>
