<%@ page language="java" import="java.util.*" %>
<%@ page import="mapping.*"%>

<%
	Users user = (Users) session.getAttribute("user");
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
	var ok = true;
	for(i = 0; i < document.stampa.length; i++)
	{
		if(document.stampa.elements[i].name == 'what')
		{
			if(document.stampa.elements[i].checked)
			{
				if(document.stampa.elements[i].value == 'soci')
				{
					if(isNaN(document.stampa.anno.value))
					{
						alert("L'ANNO deve essere un numero!");
						ok = false;
					}
					else if(parseInt(document.stampa.anno.value) < 1900)
					{
						alert("Inserire un anno successivo al 1900!");
						ok = false;
					}
				}
				else if(document.stampa.elements[i].value == 'bambini')
				{
					if(isNaN(document.stampa.annob.value))
					{
						alert("L'ANNO deve essere un numero!");
						ok = false;
					}
					else if(parseInt(document.stampa.annob.value) < 1900)
					{
						alert("Inserire un anno successivo al 1900!");
						ok = false;
					}
				}
				else if(document.stampa.elements[i].value == 'adottanti')
				{
					if(isNaN(document.stampa.annoa.value))
					{
						alert("L'ANNO deve essere un numero!");
						ok = false;
					}
					else if(parseInt(document.stampa.annoa.value) < 1900)
					{
						alert("Inserire un anno successivo al 1900!");
						ok = false;
					}
				}
			}
		}
		if(document.stampa.elements[i].name == 'whatT')
		{
			if(document.stampa.elements[i].checked)
			{
				if(document.stampa.elements[i].value == 'soci')
				{
					if(isNaN(document.stampa.annoT.value))
					{
						alert("L'ANNO deve essere un numero!");
						ok = false;
					}
					else if(parseInt(document.stampa.annoT.value) < 1900)
					{
						alert("Inserire un anno successivo al 1900!");
						ok = false;
					}
				}
				if(document.stampa.elements[i].value == 'adottanti')
				{
					if(isNaN(document.stampa.annoaT.value))
					{
						alert("L'ANNO deve essere un numero!");
						ok = false;
					}
					else if(parseInt(document.stampa.annoaT.value) < 1900)
					{
						alert("Inserire un anno successivo al 1900!");
						ok = false;
					}
				}
			}
		}
	}
	return ok;
}


function dis()
{
	for(i = 0; i < document.stampa.length; i++)
	{
		if(document.stampa.elements[i].name == 'what')
		{
			if(document.stampa.elements[i].checked)
			{
				if(document.stampa.elements[i].value == 'anagrafe')
				{
					document.stampa.anno.disabled = true;
					document.stampa.annob.disabled = true;
					document.stampa.annoa.disabled = true;
				}
				else if(document.stampa.elements[i].value == 'soci')
				{
					document.stampa.anno.disabled = false;
					document.stampa.annob.disabled = true;
					document.stampa.annoa.disabled = true;
				}
				else if(document.stampa.elements[i].value == 'bambini')
				{
					document.stampa.anno.disabled = true;
					document.stampa.annob.disabled = false;
					document.stampa.annoa.disabled = true;
				}
				else if(document.stampa.elements[i].value == 'adottanti')
				{
					document.stampa.anno.disabled = true;
					document.stampa.annob.disabled = true;
					document.stampa.annoa.disabled = false;
				}
			}
		}
		if(document.stampa.elements[i].name == 'whatT')
		{
			if(document.stampa.elements[i].checked)
			{
				if((document.stampa.elements[i].value == 'anagrafe')||(document.stampa.elements[i].value == 'nessuno'))
				{
					document.stampa.annoT.disabled = true;
					document.stampa.annoaT.disabled = true;
					break;
				}
				else if(document.stampa.elements[i].value == 'soci')
				{
					document.stampa.annoT.disabled = false;
					document.stampa.annoaT.disabled = true;
					break;
				}
				else if(document.stampa.elements[i].value == 'adottanti')
				{
					document.stampa.annoT.disabled = true;
					document.stampa.annoaT.disabled = false;
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
<TITLE>HOPE - Gestione soci</TITLE>
</HEAD>
<BODY id="body">
	<div id="container">
		<TABLE border=0 align=center width=100%>
			<TR>
				<TD align=left><img src="./img/logo.gif" height=80px></TD>
				<TD align=center>
					<font class="bilancio">Gestione Soci</font>
					<BR><FONT color=#0000CC style="font-size: 12px;" face="Verdana, Arial, Helvetica, sans-serif"><B>( <%= user.getUsername() %>)</B></font>
				</TD>
				<TD align=right><img src="./img/logo.gif" height=80px></TD>
			</TR>
		</TABLE>
		<div id="menu" align="center">
			<ul>
				<li><a href="accedisoci">Home</a></li>
				<li><a href="anagrafe">Anagrafe</a></li>
				<li><a href="soci">Soci</a></li>
				<!--<li><a href="#">Azionisti</a></li>-->
				<li><a href="adozioni">Adozioni</a></li>
				<li><a id="current">Stampa</a></li>
				<li><a href="../accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div id="content">
			<form name="stampa" action="stampa" method="get" onSubmit="return isOk()" target="_new">
				<table class="tcontent" align="center" style="width:40% ">
					<tr>
						<td rowspan="5" align="center">STAMPA :</td>
					</tr>
					<tr>
						<td><input type="radio" name="what" value="anagrafe" onClick="javascript:dis();" checked> Anagrafe</td>
					</tr>
					<tr>
						<td><input type="radio" name="what" value="soci" onClick="javascript:dis();"> Soci anno <input type="text" maxlength="4" name="anno" style="width:45px " disabled> *</td>
					</tr>
					<tr>
						<td><input type="radio" name="what" value="adottanti" onClick="javascript:dis();"> Adottanti anno <input type="text" maxlength="4" name="annoa" style="width:45px " disabled> *</td>
					</tr>
					<tr style="visibility:collapse ">
						<td><input type="radio" name="what" value="bambini" onClick="javascript:dis();"> Bambini anno<input type="text" maxlength="4" name="annob" style="width:45px " disabled> *</td>
					</tr>
					<tr><td></td></tr>
					<tr>
						<td rowspan="5" align="center">
							TRANNE :
						</td>
					<tr>
						<td><input type="radio" name="whatT" value="nessuno" onClick="javascript:dis();" checked> Nessuno</td>
					</tr>
					<tr>
						<td><input type="radio" name="whatT" value="soci" onClick="javascript:dis();"> Soci anno <input type="text" maxlength="4" name="annoT" style="width:45px " disabled> *</td>
					</tr>
					<tr>
						<td><input type="radio" name="whatT" value="adottanti" onClick="javascript:dis();"> Adottanti <input type="text" maxlength="4" name="annoaT" style="width:45px " disabled> *</td>
					</tr>
					<tr><td></td></tr>
					<tr>
						<td rowspan="4" align="center">
							FORMATO :
						</td>
					<tr>
						<td><input type="radio" name="page" value="elenco" checked> ELENCO</td>
					</tr>
					<tr>
						<td><input type="radio" name="page" value="etichette"> ETICHETTE</td>
					</tr>
					<tr>
						<td><input type="radio" name="page" value="buste"> BUSTE</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<BR>
							<input type="submit" value="STAMPA">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							* campo vuoto = TUTTI
						</td>
					</tr>
				</table>
				<input type="hidden" name="action" value="stampa">
			</form>
	  	</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2006</P>
		</DIV>
	</div>
</BODY>
</HTML>
