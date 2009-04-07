<%@ page language="java" import="java.util.*" %>
<%@ page import="mapping.*"%>

<%
	Users user = (Users) session.getAttribute("user");
	
	List LA = (List) request.getAttribute("listaadottanti");		
	String annoA = (String) request.getAttribute("anno");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<script language="javascript">
<!--

function checkanno()
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

function checkP(w)
{
	if(isNaN(w.p1.value)|isNaN(w.p2.value)|isNaN(w.p3.value))	
	{
		alert('Importo non valido!');
		return false;
	}
	
	return true;
}

function changecolor(h)
{
	h.id = 'formbianca';
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
					<BR><FONT color=#0000CC style="font-size: 12px;" face="Verdana, Arial, Helvetica, sans-serif"><B></B></font>
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
		<form name="selezione" action="adozioni" method="post" onSubmit="javascript:return checkanno()">
			<table class="tcontentmaxi" align="center">
				<TR>
					<TD align="center"><font color="#CC0000"><B>SITUAZIONE ADOTTANTI ANNO &nbsp;<input name="anno" type="text" style="width:60px " value="<%= annoA %>"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Aggiorna"></b></font></TD>
				</TR>
			</table>
		</form>
			<TABLE class="tcontentmaxi" align="center">
				<TR class="intestazione">
					<TD rowspan="2" align="center"><B>Cognome</B></TD>
					<TD rowspan="2" align="center"><B>Nome</B></TD>
					<TD rowspan="2" align="center"><B>Nome Bambino</B></TD>
					<TD rowspan="2" align="center"><B>Anno</B></TD>
					<TD rowspan="2" align="center"><B>Costo</B></TD>
					<TD colspan="3" align="center"><B>Pagamenti</B></TD>
					<TD rowspan="2" align="center" width="2%"></TD>
					<TD rowspan="2" align="center" width="2%"></TD>
				</TR>
				<TR class="intestazione">
					<TD align="center"><B>1°</B></TD>
					<TD align="center"><B>2°</B></TD>
					<TD align="center"><B>3°</B></TD>
				</TR>
<%
			for(int i = 0; i < LA.size(); i++)
			{
				AdottantiviewId adw = ((Adottantiview) LA.get(i)).getId();
				String cognome = adw.getCognome();
				String nome = adw.getNome();
				String nomeB = adw.getNomebambino();
				String anno = adw.getAnno().toString();
				int p1 = adw.getP1().intValue();
				int p2 = adw.getP2().intValue();
				int p3 = adw.getP3().intValue();
%>
			<form action="adozioni" method="post" onSubmit="return checkP(this)">
				<TR id="row<%= i%2 %>">
					<TD><%= cognome %></TD>
					<TD><%= nome %></TD>
					<TD><%= nomeB %></TD>
					<TD><%= anno %></TD>
					<TD><%= adw.getCosto().toString() %></TD>
					<TD align="center" width="7%"><input id="formrossa" type="text" name="p1" value="<%= p1 %>" onClick="changecolor(this)"></TD>
					<TD align="center" width="7%"><input id="formrossa" type="text" name="p2" value="<%= p2 %>" onClick="changecolor(this)"></TD>
					<TD align="center" width="7%"><input id="formrossa" type="text" name="p3" value="<%= p3 %>" onClick="changecolor(this)"></TD>
					<TD align="center"><input type="submit" style="background-image:url(img/save.jpg); background-repeat:no-repeat; width:16px; border:0 solid black; cursor:pointer; " value=""></TD>
					<TD align="center"><a href="adozioni?action=del&page=adottante&id=<%= adw.getId() %>&anno=<%= annoA %>" onclick="return(confirm('Verranno eliminati SOLO i dati relativi alla adozione!\nE\' possibile eliminare i dati dell\'adottante da ANAGRAFE, e quelli del bambino da BAMBINI!\nSicuro?'))"><img src="img/del.gif" border="0"></a></TD>
				</TR>
				<input type="hidden" name="action" value="save">
				<input type="hidden" name="id" value="<%= adw.getId() %>">
				<input type="hidden" name="anno" value="<%= annoA %>">
			</form>
<%	
			}
%>
			</TABLE>
			<BR>
			<table class="tcontentmaxi">
				<tr>
					<TD align="center">
						<input type="button" value="Nuova adozione" onClick="window.location.href='adozioni?action=insert&page=first'">
					</TD>
				</tr>
			</table>
	  	</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2006</P>
		</DIV>
	</div>
</BODY>
</HTML>
