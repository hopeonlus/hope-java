<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	List ListaConti = (List) request.getAttribute("listaconti");

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
<%
			int prev_tipo = -1;
			int prev_gruppo = -1;
			for(int i = 0; i < ListaConti.size(); i++)
			{
				ContogruppoId cg = ((Contogruppo) ListaConti.get(i)).getId();
				int gruppo = cg.getGruppo().intValue();
				String tipoStr = "";
				int tipo = cg.getTipo().intValue();
				if(tipo == 1)
					tipoStr = "Costi";
				else if(tipo == 2)
					tipoStr = "Ricavi";
				else if(tipo == 3)
					tipoStr = "Attività";
				else if(tipo == 4)
					tipoStr = "Passività";
				
				if(prev_tipo == tipo)
				{
					if(prev_gruppo == gruppo)
					{
%>
						<TR>
							<TD></TD>
							<TD width="3%"></TD>
							<TD>
								<a href="bilancio?action=page&what=select&id=<%= cg.getId().toString() %>"><%= cg.getNomeconto() %></a>
							</TD>
						</TR>
<%
					}
					else
					{
%>
					<TR>
						<TD width="5%"></TD>
						<TD colspan="2">
							<B><%= cg.getNomegruppo() %></B>
						</TD>
					</TR>
					<TR>
						<TD></TD>
						<TD width="3%"></TD>
						<TD>
							<a href="bilancio?action=page&what=select&id=<%= cg.getId().toString() %>"><%= cg.getNomeconto() %></a>
						</TD>
					</TR>
<%
					
					}
				}
				else
				{
%>
					<TR class="intestazione" align="center">
						<TD colspan="3">
							<font style="text-transform:uppercase;"><%= tipoStr %></font>
						</TD>
					</TR>
					<TR>
						<TD width="5%"></TD>
						<TD colspan="2">
							<B><%= cg.getNomegruppo() %></B>
						</TD>
					</TR>
					<TR>
						<TD></TD>
						<TD width="3%"></TD>
						<TD>
							<a href="bilancio?action=page&what=select&id=<%= cg.getId().toString() %>"><%= cg.getNomeconto() %></a>
						</TD>
					</TR>

<%			
				}
				prev_tipo = tipo;
				prev_gruppo = gruppo;
			}
%>

		</TABLE>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2005</P>
		</DIV>
	</div>
</BODY>
</HTML>