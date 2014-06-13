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
function refreshMostra(id)
{
	var nome = 'mostra' + id;
	var c;
	for(i = 0; i < document.conti.length; i++)
	{
		if(document.conti.elements[i].name == nome)
		{
			if(document.conti.elements[i].checked)
				c = 'true';
			else
				c = 'false';
		}
	}
	
	return 'conti?action=mostra&id=' + id + '&mostra=' + c;
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
				<li><a href="scritture">Scritture</a></li>
				<li><a id="current">Conti</a></li>
				<li><a href="bilancio">Bilancio</a></li>
				<li><a href="../accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div align="center" style="padding-top:3px ">
			<ul style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:90%; ">
				<li><a id="current1">Gestione Conti</a></li>
				<li><a href="conti?action=view&what=gruppi">Gestione Gruppi</a></li>
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
		<FORM name="conti" action="conti" method="post" onSubmit="return isOk()">
			<TABLE class="tcontentmaxi" align="center">
				<TR class="intestazione">
					<TD width="3%"></TD>
					<TD><B>Conto</B></TD>
					<TD><B>Gruppo</B></TD>
					<TD><B>Tipo</B></TD>
					<TD><B>Mostra</B></TD>
					<TD></TD>
				</TR>
<%
			for(int i = 0; i < ListaConti.size(); i++)
			{
				ContogruppoId cg = ((Contogruppo) ListaConti.get(i)).getId();
				String tipoStr = "";
				int tipo = cg.getTipo().intValue();
				if(tipo == 1)
					tipoStr = "Costo";
				else if(tipo == 2)
					tipoStr = "Ricavo";
				else if(tipo == 3)
					tipoStr = "Attività";
				else if(tipo == 4)
					tipoStr = "Passività";
%>
				<TR id="row<%= i%2 %>">
					<TD><%= i+1 %></TD>
					<TD><%= cg.getNomeconto() %></TD>
					<TD><%= cg.getNomegruppo() %></TD>
					<TD width="10%"><%= tipoStr %></TD>
					<TD width="5%" align="center"><input type="checkbox" name="mostra<%= cg.getId() %>" <% if(cg.isMostra()) out.print("checked"); %> onChange="window.location.href=refreshMostra('<%= cg.getId() %>')"></TD>
					<TD align="center" width="4%"><a href="conti?action=del&what=conti&id=<%= cg.getId() %>" onclick="return(confirm('Sicuro?'))"><img src="img/del.gif" border="0"></a></TD>
				</TR>
<%				
			}
%>
				<TR><TD></TD></TR>
				<TR>
					<TD colspan="6" align="center">
						<input type="submit" value="Nuovo conto">
					</TD>
				</TR>
			</TABLE>
			<INPUT type="hidden" name="action" value="new">
			<INPUT type="hidden" name="what" value="conti">
		</FORM>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2005</P>
		</DIV>
	</div>
</BODY>
</HTML>
