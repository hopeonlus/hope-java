<%@ page language="java" import="java.util.*" %>
<%@ page import="mapping.*"%>

<%
	Users user = (Users) session.getAttribute("user");
	
	List LB = (List) request.getAttribute("listabambini");		
	String annoA = (String) request.getAttribute("anno");
	if(annoA == null)
		annoA = "tutti";
	else if(annoA.equals(""))
		annoA = "tutti";
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
	return true;
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
				<li><a href="adozioni">Adottanti</a></li>
				<li><a id="current1">Bambini</a></li>
			</ul>
		</div>
		<div id="content">
		<form name="selezione" action="adozioni" method="post" onSubmit="javascript:return checkanno()">
			<table class="tcontentmaxi" align="center">
				<TR>
					<TD align="center"><font color="#CC0000"><B>BAMBINI ANNO &nbsp;<input name="anno" type="text" style="width:60px " value="<%= annoA %>"> <font size="3px">*</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Aggiorna"></b></font></TD>
				</TR>
			</table>
			<input type="hidden" name="action" value="page">
			<input type="hidden" name="page" value="bambini">
		</form>
			<TABLE class="tcontentmaxi" align="center">
				<TR class="intestazione">
					<TD align="center"><B>Nome</B></TD>
					<TD align="center"><B>Sesso</B></TD>
					<TD align="center"><B>Indirizzo</B></TD>
					<TD align="center"><B>Città</B></TD>
					<TD align="center"><B>Nazione</B></TD>
					<TD align="center"><B>Data di nascita</B></TD>
					<TD align="center"><B>Scuola</B></TD>
					<TD align="center" width="2%"></TD>
					<TD align="center" width="2%"></TD>
				</TR>
<%
			int previd = -1;
			
			for(int i = 0; i < LB.size(); i++)
			{
				BambinoannoviewId b = ((Bambinoannoview) LB.get(i)).getId();
				
				if(b.getId().intValue() != previd)
				{
					Date d = b.getDatanascita();
					java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("dd-MM-yyyy");
					String data = formatter.format(d);
	%>
					<TR id="row<%= i%2 %>">
						<TD><%= b.getNome() %></TD>
						<TD><%= b.getSesso() %></TD>
						<TD><%= b.getIndirizzo() %></TD>
						<TD><%= b.getCitta() %></TD>
						<TD><%= b.getNazione() %></TD>
						<TD><%= data %></TD>
						<TD><%= b.getScuola() %></TD>
						<TD align="center"><a href="adozioni?action=view&page=bambino&id=<%= b.getId() %>&anno=<%= annoA %>"><img src="img/edit.gif" border="0"></a></TD>
						<TD align="center"><a href="adozioni?action=del&page=bambino&id=<%= b.getId() %>&anno=<%= annoA %>" onclick="return(confirm('Verranno eliminati TUTTI i dati relativi al bambino ed alle adozioni relative!\nSicuro?'))"><img src="img/del.gif" border="0"></a></TD>
					</TR>
<%	
				}
				previd = b.getId().intValue();
			}
%>
			</TABLE>
			<BR>
			<table class="tcontentmaxi">
				<tr>
					<TD align="center">
						<input type="button" value="Nuovo bambino" onClick="window.location.href='adozioni?action=insertbambino&page=first'">
					</TD>
				</tr>
			</table>
			<BR>
			<font size="1">* campo vuoto = TUTTI</font>
	  	</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2006</P>
		</DIV>
	</div>
</BODY>
</HTML>
