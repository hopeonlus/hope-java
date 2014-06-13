<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	List costi = (List) request.getAttribute("costi");
	List ricavi = (List) request.getAttribute("ricavi");
	List attivita = (List) request.getAttribute("attivita");
	List passivita = (List) request.getAttribute("passivita");
	
	Float totalecosti = (Float) request.getAttribute("totalecosti");
	Float totalericavi = (Float) request.getAttribute("totalericavi");
	Float totaleattivita = (Float) request.getAttribute("totaleattivita");
	Float totalepassivita = (Float) request.getAttribute("totalepassivita");
	
	String bilancio = (String) request.getAttribute("bilancio");
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
<BODY style="background-color:#FFFFFF" onLoad="setTimeout('print();', 500);">
	<div align="center" style="padding-bottom:30px ">
		<font face="Geneva, Arial, Helvetica, sans-serif" size="+1" color="#000000">BILANCIO H.O.P.E.<BR><%= bilancio %></font>
	</div>
		<TABLE class="tcontentbilanciostampa" align="center">
			<TR class="intestazioneblack" align="center">
				<TD colspan="5" style="order:1px solid black;">
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
							<TD colspan="2" style="border-bottom-width:1px; border-bottom-color:black; border-bottom-style:solid">
								<B><%= conto[0] %></B>
							</TD>
							<TD style="border-bottom-width:1px; border-bottom-color:black; border-bottom-style:solid">&nbsp;</TD>
							<TD align="right" style="border-bottom-width:1px; border-bottom-color:black; border-bottom-style:solid"><%= ((String[])(gruppo.get(gruppo.size()-1)))[3] %></TD>
						</TR>
<%
					}
%>
						<TR id="row0">
							<TD width="2%"></TD>
							<TD width="3%"></TD>
							<TD width="72%" style="border-bottom-width:1px; border-bottom-color:black; border-bottom-style:dotted;">
								<%= conto[1] %>
							</TD>
							<TD align="right" width="11%" style="border-bottom-width:1px; border-bottom-color:black; border-bottom-style:dotted;"><%= conto[2] %></TD>
							<TD width="11%"></TD>
						</TR>
<%	
				}
			}
%>
				<TR>
					<TD width="2%"></TD>
					<TD width="3%"></TD>
					<TD width="72%" align="right" style="padding-right:7px; padding-top:15px;">
						<B>TOTALE COSTI (€)</B>
					</TD>
					<TD width="11px"></TD>
					<TD align="right" style="padding-right:7px; padding-top:15px;">
						<B><%= totalecosti %></B>
					</TD>
				</TR>
		</TABLE>
		<BR>
		<TABLE class="tcontentbilanciostampa" align="center">
			<TR class="intestazioneblack" align="center">
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
							<TD colspan="2" style="border-bottom-width:1px; border-bottom-color:black; border-bottom-style:solid">
								<B><%= conto[0] %></B>
							</TD>
							<TD style="border-bottom-width:1px; border-bottom-color:black; border-bottom-style:solid">&nbsp;</TD>
							<TD align="right" style="border-bottom-width:1px; border-bottom-color:black; border-bottom-style:solid"><%= ((String[])(gruppo.get(gruppo.size()-1)))[3] %></TD>
						</TR>
<%
					}
%>
						<TR id="row0">
							<TD width="2%"></TD>
							<TD width="3%"></TD>
							<TD width="72%" style="border-bottom-width:1px; border-bottom-color:black; border-bottom-style:dotted;">
								<%= conto[1] %>
							</TD>
							<TD align="right" width="11%" style="border-bottom-width:1px; border-bottom-color:black; border-bottom-style:dotted;"><%= conto[2] %></TD>
							<TD width="11%"></TD>
						</TR>
<%	
				}
			}
%>
				<TR>
					<TD width="2%"></TD>
					<TD width="3%"></TD>
					<TD width="72%" align="right" style="padding-right:7px; padding-top:15px;">
						<B>TOTALE RICAVI (€)</B>
					</TD>
					<TD width="11px"></TD>
					<TD align="right" width="11px" style="padding-right:7px; padding-top:15px;">
						<B><%= totalericavi %></B>
					</TD>
				</TR>
		</TABLE>
		<BR>
		<TABLE class="tcontentbilanciostampa" align="center">
			<TR class="intestazioneblack" align="center">
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
							<TD colspan="2" style="border-bottom-width:1px; border-bottom-color:black; border-bottom-style:solid">
								<B><%= conto[0] %></B>
							</TD>
							<TD style="border-bottom-width:1px; border-bottom-color:black; border-bottom-style:solid">&nbsp;</TD>
							<TD align="right" style="border-bottom-width:1px; border-bottom-color:black; border-bottom-style:solid"><%= ((String[])(gruppo.get(gruppo.size()-1)))[3] %></TD>
						</TR>
<%
					}
%>
						<TR id="row0">
							<TD width="2%"></TD>
							<TD width="3%"></TD>
							<TD width="72%" style="border-bottom-width:1px; border-bottom-color:black; border-bottom-style:dotted;">
								<%= conto[1] %>
							</TD>
							<TD align="right" width="11%" style="border-bottom-width:1px; border-bottom-color:black; border-bottom-style:dotted;"><%= conto[2] %></TD>
							<TD width="11%"> </TD>
						</TR>
<%	
				}
			}
%>
				<TR>
					<TD width="2%"></TD>
					<TD width="3%"></TD>
					<TD width="72%" align="right" style="padding-right:7px; padding-top:15px;">
						<B>TOTALE ATTIVITA' (€)</B>
					</TD>
					<TD width="11px"></TD>
					<TD align="right" width="11px" style="padding-right:7px; padding-top:15px;">
						<B><%= totaleattivita %></B>
					</TD>
				</TR>
		</TABLE>
		<BR>
		<TABLE class="tcontentbilanciostampa" align="center">
			<TR class="intestazioneblack" align="center">
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
							<TD colspan="2" style="border-bottom-width:1px; border-bottom-color:black; border-bottom-style:solid">
								<B><%= conto[0] %></B>
							</TD>
							<TD style="border-bottom-width:1px; border-bottom-color:black; border-bottom-style:solid">&nbsp;</TD>
							<TD align="right" style="border-bottom-width:1px; border-bottom-color:black; border-bottom-style:solid"><%= ((String[])(gruppo.get(gruppo.size()-1)))[3] %></TD>
						</TR>
<%
					}
%>
						<TR id="row0">
							<TD width="2%"></TD>
							<TD width="3%"></TD>
							<TD width="72%" style="border-bottom-width:1px; border-bottom-color:black; border-bottom-style:dotted;">
								<%= conto[1] %>
							</TD>
							<TD align="right" width="11%" style="border-bottom-width:1px; border-bottom-color:black; border-bottom-style:dotted;"><%= conto[2] %></TD>
							<TD width="11%"></TD>
						</TR>
<%	
				}
			}
%>
				<TR>
					<TD width="2%"></TD>
					<TD width="3%"></TD>
					<TD width="72%" align="right" style="padding-right:7px; padding-top:15px; ">
						<B>TOTALE PASSIVITA' (€)</B>
					</TD>
					<TD width="11px"></TD>
					<TD align="right" width="11px" style="padding-right:7px; padding-top:15px;">
						<B><%= totalepassivita %></B>
					</TD>
				</TR>
		</TABLE>
		<BR>
		<TABLE id="stampa" class="tcontentbilancio">
			<TR>
				<TD align="center">
					<input type="button" value="STAMPA" onClick="javascript:window.print();">
				</TD>
			</TR>
		</TABLE>
	</div>
</BODY>
</HTML>
