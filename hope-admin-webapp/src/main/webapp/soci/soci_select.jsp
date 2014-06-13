<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%	
	Avviso err = (Avviso) request.getAttribute("err");
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
				if(document.selezione.elements[i].value == 'tutti')
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
				else if(document.selezione.elements[i].value == 'anni')
				{
					return true;
				}
			}
		}
	}
}


function dis()
{
	for(i = 0; i < document.selezione.length; i++)
	{
		if(document.selezione.elements[i].name == 'what')
		{
			if(document.selezione.elements[i].checked)
			{
				if(document.selezione.elements[i].value == 'tutti')
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
				else if(document.selezione.elements[i].value == 'anni')
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
				<li><a id="current1">Visualizza</a></li>
				<li><a href="soci?action=insert&page=first">Inserisci</a></li>
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
		<FORM name="selezione" action="soci" method="get" onSubmit="return isOk()">
			<TABLE class="tcontent" align="center" style="width:25% ">
				<TR>
					<TD>
						<input type="radio" name="what" value="tutti" onClick="javascript:dis();" checked>
					</TD>
					<TD colspan="3">
						Tutti
					</TD>
				</TR>
				<TR>
					<TD>
						<input type="radio" name="what" value="anno" onClick="javascript:dis();">
					</TD>
					<TD>Anno</TD>
					<TD colspan="2">
						<input type="text" name="anno" style="width:50px; height:18px; font-size:9px; vertical-align:bottom" maxlength="4" value="" disabled>
					</TD>
				</TR>
				<TR>
					<TD>
						<input type="radio" name="what" value="anni" onClick="javascript:dis();">
					</TD>
					<TD>Anni</TD>
					<TD align="right">dal</TD>
					<TD>
						<input type="text" name="dal" style="width:80px; height:18px; font-size:9px; vertical-align:bottom" maxlength="4" value="" disabled>
					</TD>
				</TR>
				<TR>
					<TD></TD>
					<TD></TD>
					<TD align="right">al</TD>
					<TD>
						<input type="text" name="al" style="width:80px; height:18px; font-size:9px; vertical-align:bottom;" maxlength="4" value="" disabled>
					</TD>
				</TR>
				<TR>
					<TD colspan="4" align="center">
						<BR><input type="submit" value="Visualizza">
					</TD>
				</TR>
			</TABLE>
			<INPUT type="hidden" name="action" value="select">
		</FORM>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2008</P>
		</DIV>
	</div>
</BODY>
</HTML>
