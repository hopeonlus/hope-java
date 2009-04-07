<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	String what = request.getParameter("what");
	String anno = request.getParameter("anno");
	String dalStr = request.getParameter("dal");
	String alStr = request.getParameter("al");
	
	List costi = (List) request.getAttribute("costi");
	List ricavi = (List) request.getAttribute("ricavi");
	List attivita = (List) request.getAttribute("attivita");
	List passivita = (List) request.getAttribute("passivita");
	
	Float totalecosti = (Float) request.getAttribute("totalecosti");
	Float totalericavi = (Float) request.getAttribute("totalericavi");
	Float totaleattivita = (Float) request.getAttribute("totaleattivita");
	Float totalepassivita = (Float) request.getAttribute("totalepassivita");
	
	String bilancio = (String) request.getAttribute("bilancio");
	
	Avviso err = (Avviso) request.getAttribute("err");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<script language="javascript">
<!--
var stile = 'top=170, left=90, height=600, width=900, status=no, menubar=no, toolbar=no, scrollbars=yes, resizable=yes';

function popup(apri) {

	window.open(apri, '', stile);
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
		<TABLE id="titolo" border=0 align=center width=100%>
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
		<div id="submenu" align="center" style="padding-top:3px ">
			<ul style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:90%; ">
				<li><a id="current1">Visualizza Bilancio</a></li>
				<li><a href="bilancio?action=page&what=export">Esporta Bilancio</a></li>
				<li><a href="bilancio?action=page&what=conti">Schede Conti</a></li>
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
		<div id="bil" align="center">
			<font face="Geneva, Arial, Helvetica, sans-serif" size="+1" color="#990000">BILANCIO H.O.P.E.<BR><%= bilancio %></font>
		</div>
		<BR>
		<TABLE class="tcontentbilancio" align="center">
			<TR class="intestazione" align="center">
				<TD colspan="5">
					COSTI
				</TD>
			</TR>
<%
			for(int i = 0;i < costi.size(); i++)
			{
				List gruppo = (List) costi.get(i);
				for(int j=0; j< gruppo.size(); j++)
				{
					String[] conto = (String[]) gruppo.get(j);
					if(j == 0)
					{
%>
						<TR id="row1">
							<TD></TD>
							<TD colspan="2" style="border-bottom-width:1px; border-bottom-color:#FF0000; border-bottom-style:solid">
								<B><%= conto[0] %></B>
							</TD>
							<TD style="border-bottom-width:1px; border-bottom-color:#FF0000; border-bottom-style:solid">&nbsp;</TD>
							<TD align="right" style="border-bottom-width:1px; border-bottom-color:#FF0000; border-bottom-style:solid"><%= ((String[])(gruppo.get(gruppo.size()-1)))[3] %></TD>
						</TR>
<%
					}
%>
						<TR id="row0">
							<TD width="3%"></TD>
							<TD width="3%"></TD>
							<TD width="72%" style="border-bottom-width:1px; border-bottom-color:#FF0000; border-bottom-style:dotted;">
								<%= conto[1] %>
							</TD>
							<TD align="right" width="11%" style="border-bottom-width:1px; border-bottom-color:#FF0000; border-bottom-style:dotted;"><%= conto[2] %></TD>
							<TD width="11%"></TD>
						</TR>
<%	
				}
			}
%>
				<TR>
					<TD width="3%"></TD>
					<TD width="3%"></TD>
					<TD width="72%" align="right" style="padding-right:7px; ">
						<B>TOTALE COSTI (€)</B>
					</TD>
					<TD width="11px"></TD>
					<TD align="right">
						<B><%= totalecosti %></B>
					</TD>
				</TR>
		</TABLE>
		<BR>
		<TABLE class="tcontentbilancio" align="center">
			<TR class="intestazione" align="center">
				<TD colspan="5">
					RICAVI
				</TD>
			</TR>
<%
			for(int i = 0;i < ricavi.size(); i++)
			{
				List gruppo = (List) ricavi.get(i);
				for(int j=0; j< gruppo.size(); j++)
				{
					String[] conto = (String[]) gruppo.get(j);
					if(j == 0)
					{
%>
						<TR id="row1">
							<TD></TD>
							<TD colspan="2" style="border-bottom-width:1px; border-bottom-color:#FF0000; border-bottom-style:solid">
								<B><%= conto[0] %></B>
							</TD>
							<TD style="border-bottom-width:1px; border-bottom-color:#FF0000; border-bottom-style:solid">&nbsp;</TD>
							<TD align="right" style="border-bottom-width:1px; border-bottom-color:#FF0000; border-bottom-style:solid"><%= ((String[])(gruppo.get(gruppo.size()-1)))[3] %></TD>
						</TR>
<%
					}
%>	
						<TR id="row0"> 
							<TD width="3%"></TD>
							<TD width="3%"></TD>
							<TD width="72%" style="border-bottom-width:1px; border-bottom-color:#FF0000; border-bottom-style:dotted;">
								<%= conto[1] %>
							</TD>
							<TD align="right" width="11%" style="border-bottom-width:1px; border-bottom-color:#FF0000; border-bottom-style:dotted;"><%= conto[2] %></TD>
							<TD width="11%"></TD>
						</TR>
<%	
				}
			}
%>
				<TR>
					<TD width="3%"></TD>
					<TD width="3%"></TD>
					<TD width="72%" align="right" style="padding-right:7px; ">
						<B>TOTALE RICAVI (€)</B>
					</TD>
					<TD width="11px"></TD>
					<TD align="right" width="11px">
						<B><%= totalericavi %></B>
					</TD>
				</TR>
		</TABLE>
		<BR>
		<TABLE class="tcontentbilancio" align="center">
			<TR class="intestazione" align="center">
				<TD colspan="5">
					ATTIVITA'
				</TD>
			</TR>
<%
			for(int i = 0;i < attivita.size(); i++)
			{
				List gruppo = (List) attivita.get(i);
				for(int j=0; j< gruppo.size(); j++)
				{
					String[] conto = (String[]) gruppo.get(j);
					if(j == 0)
					{
%>
						<TR id="row1">
							<TD></TD>
							<TD colspan="2" style="border-bottom-width:1px; border-bottom-color:#FF0000; border-bottom-style:solid">
								<B><%= conto[0] %></B>
							</TD>
							<TD style="border-bottom-width:1px; border-bottom-color:#FF0000; border-bottom-style:solid">&nbsp;</TD>
							<TD align="right" style="border-bottom-width:1px; border-bottom-color:#FF0000; border-bottom-style:solid"><%= ((String[])(gruppo.get(gruppo.size()-1)))[3] %></TD>
						</TR>
<%
					}
%>
						<TR id="row0">
							<TD width="3%"></TD>
							<TD width="3%"></TD>
							<TD width="72%" style="border-bottom-width:1px; border-bottom-color:#FF0000; border-bottom-style:dotted;">
								<%= conto[1] %>
							</TD>
							<TD align="right" width="11%" style="border-bottom-width:1px; border-bottom-color:#FF0000; border-bottom-style:dotted;"><%= conto[2] %></TD>
							<TD width="11%"> </TD>
						</TR>
<%	
				}
			}
%>
				<TR>
					<TD width="3%"></TD>
					<TD width="3%"></TD>
					<TD width="72%" align="right" style="padding-right:7px; ">
						<B>TOTALE ATTIVITA' (€)</B>
					</TD>
					<TD width="11px"></TD>
					<TD align="right" width="11px">
						<B><%= totaleattivita %></B>
					</TD>
				</TR>
		</TABLE>
		<BR>
		<TABLE class="tcontentbilancio" align="center">
			<TR class="intestazione" align="center">
				<TD colspan="5">
					PASSIVITA'
				</TD>
			</TR>
<%
			for(int i = 0;i < passivita.size(); i++)
			{
				List gruppo = (List) passivita.get(i);
				for(int j=0; j< gruppo.size(); j++)
				{
					String[] conto = (String[]) gruppo.get(j);
					if(j == 0)
					{
%>
						<TR id="row1">
							<TD></TD>
							<TD colspan="2" style="border-bottom-width:1px; border-bottom-color:#FF0000; border-bottom-style:solid">
								<B><%= conto[0] %></B>
							</TD>
							<TD style="border-bottom-width:1px; border-bottom-color:#FF0000; border-bottom-style:solid">&nbsp;</TD>
							<TD align="right" style="border-bottom-width:1px; border-bottom-color:#FF0000; border-bottom-style:solid"><%= ((String[])(gruppo.get(gruppo.size()-1)))[3] %></TD>
						</TR>
<%
					}
%>
						<TR id="row0">
							<TD width="3%"></TD>
							<TD width="3%"></TD>
							<TD width="72%" style="border-bottom-width:1px; border-bottom-color:#FF0000; border-bottom-style:dotted;">
								<%= conto[1] %>
							</TD>
							<TD align="right" width="11%" style="border-bottom-width:1px; border-bottom-color:#FF0000; border-bottom-style:dotted;"><%= conto[2] %></TD>
							<TD width="11%"></TD>
						</TR>
<%	
				}
			}
%>
				<TR>
					<TD width="3%"></TD>
					<TD width="3%"></TD>
					<TD width="72%" align="right" style="padding-right:7px; ">
						<B>TOTALE PASSIVITA' (€)</B>
					</TD>
					<TD width="11px"></TD>
					<TD align="right" width="11px">
						<B><%= totalepassivita %></B>
					</TD>
				</TR>
		</TABLE>
		<BR>
		<table id="buttons" class="tcontentbilancio" align="center">
			<TR>
				<TD align="center">
					<input type="button" value="Indietro" onClick="javascript:history.back();">
				</TD>
				<TD align="center">
					<input type="button" value="STAMPA" onClick="javascript:popup('bilancio?action=stampa&what=<%= what %>&anno=<%= anno %>&dal=<%= dalStr %>&al=<%= alStr %>');">
				</TD>
			</TR>
		</table>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2005</P>
		</DIV>
	</div>
</BODY>
</HTML>
