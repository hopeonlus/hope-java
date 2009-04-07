<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	Conto c = (Conto) request.getAttribute("conto");
	List ListaScritture = (List) request.getAttribute("listascritture");
	String totale = (String) request.getAttribute("totale");
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
				<li><a href="scritture">Scritture</a></li>
				<li><a href="conti">Conti</a></li>
				<li><a id="current">Bilancio</a></li>
				<li><a href="../accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div align="center" style="padding-top:3px ">
			<ul style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:90%; ">
				<li><a href="bilancio?action=page&what=bilancio">Visualizza Bilancio</a></li>
				<li><a href="bilancio?action=page&what=export">Esporta Bilancio</a></li>
				<li><a id="current1">Schede Conti</a></li>
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
		<TABLE class="tcontent" align="center">
			<TR class="intestazione">
				<TD align="center" colspan="3">
					<font style="text-transform:uppercase; "><%= c.getNome() %></font><BR>
<%
							if(what.equals("tutte"))
								out.print("(Tutte le scritture)");
							else if(what.equals("anno"))
								out.print("(dal 01/01/ " + anno + " al 31/12/" + anno + ")");
							else if(what.equals("periodo"))
								out.print("(dal " + dal + " al " + al +")");
%>
				</TD>			
			</TR>
<%
			for(int i = 0; i < ListaScritture.size(); i++)
			{
			String[] riga = (String[]) ListaScritture.get(i);
%>
			<TR id="row<%= i%2 %>">
				<TD width="15%"><%= riga[0] %></TD>
				<TD><%= riga[1] %></TD>
				<TD width="15%" align="right"><font color="red"><%= riga[2] %></font></TD>
			</TR>
<%
			}
%>
			<TR>
				<TD colspan="2" align="right"><B>TOTALE (€) &nbsp&nbsp&nbsp;</B></TD>
				<TD align="right"><font color="red"><B><%= totale %></B></FONT></TD>
			</TR>
			<TR><TD></TD></TR>
			<TR>
				<TD align="left" colspan="3">
					<input type="button" value="Indietro" onClick="javascript:history.back();">
				</TD>
			</TR>
		</TABLE>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2005</P>
		</DIV>
	</div>
</BODY>
</HTML>