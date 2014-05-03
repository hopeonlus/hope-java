<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	List ListaScritture = (List) request.getAttribute("listascritture");
	String what = request.getParameter("what");
	String dal = request.getParameter("dal");
	String al = request.getParameter("al");
	String anno = request.getParameter("anno");

	Avviso err = (Avviso) request.getAttribute("err");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<script language="javascript">
<!--

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
				<li><a id="current1" href="scritture">Visualizza</a></li>
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
		<FORM name="scrittura" action="scritture" method="post" onSubmit="return isOk()">
			<table class="tcontentmaxi" align="center">
				<TR>
<%
				if(what.equals("tutte"))
				{
%>
					<TD>Scritture LISTA COMPLETA</TD>
<%
				}
				else if(what.equals("anno"))
				{
%>
					<TD>Scritture dal <B>01/01/<%= anno %></B> al <B>31/12/<%= anno %></B></TD>
<%
				}
				else if(what.equals("periodo"))
				{
%>
					<TD>Scritture dal <B><%= dal %></B> al <B><%= al %></B></TD>
<%
				}
%>
				</TR>
			</table>
			<table><TR><TD></TD></TR></table>
			<TABLE class="tcontentmaxi" align="center">
				<TR class="intestazione">
					<TD width="12%"><B>Data</B></TD>
					<TD width="40%"><B>Descrizione</B></TD>
					<TD width="11%"><B>Importo (€)</B></TD>
					<TD width="15%"><B>Dare</B></TD>
					<TD width="15%"><B>Avere</B></TD>
					<TD></TD>
					<TD></TD>
				</TR>
<%
				for(int i = 0; i < ListaScritture.size(); i++)
				{
				Scrittura s = (Scrittura) ListaScritture.get(i);
				Date d = s.getData();
				java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("dd-MM-yyyy");
				String data = formatter.format(d);
%>
				<TR id="row<%= s.getAnno().isChiuso() %>">
					<TD><%= data %></TD>
					<TD><%= s.getDescrizione() %></TD>
					<TD align="right" style="padding-right:5px "><font color="red"><%= s.getImporto() %></font></TD>
					<TD><%= s.getDare().getNome() %></TD>
					<TD><%= s.getAvere().getNome() %></TD>
<%
					if(s.getAnno().isChiuso()||s.isAutomatico())
					{
%>
					 	<TD align="center"><a href="#" onClick="javascript:alert('Impossibile modificare la scrittura, Bilancio già chiuso.'); return false;"><img src="img/editno.gif" border="0"></a></TD>
						<TD align="center"><a href="#" onClick="javascript:alert('Impossibile eliminare la scrittura, Bilancio già chiuso.'); return false;"><img src="img/delno.gif" border="0"></a></TD>
<%
					}
					else
					{
%>
						<TD align="center"><a href="scritture?action=view&id=<%= s.getId() %>&what=<%= what %>&anno=<%= anno %>&dal=<%= dal%>&al=<%= al%>"><img src="img/edit.gif" border="0"></a></TD>
						<TD align="center"><a href="scritture?action=del&id=<%= s.getId() %>&what=<%= what %>&anno=<%= anno %>&dal=<%= dal%>&al=<%= al%>" onclick="return(confirm('Sicuro?'))"><img src="img/del.gif" border="0"></a></TD>
<%
					}
%>
				</TR>
<%				
				}
				if(ListaScritture.size() == 0)
				{
%>
					<TR id="row1">
						<TD align="center" colspan="7">Nessuna Scrittura disponibile</TD>
					</TR>
<%
				}
%>
				<TR><TD colspan="7"></TD></TR>
				<TR>
					<TD colspan="7">
						<input type="button" value="Indietro" onClick="javascript:history.back();">
					</TD>
				</TR>
			</TABLE>
		</FORM>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2005</P>
		</DIV>
	</div>
</BODY>
</HTML>
