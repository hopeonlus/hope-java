<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	List ListaGruppi = (List) request.getAttribute("listagruppi");
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
				<li><a id="current">Conti</a></li>
				<li><a href="bilancio">Bilancio</a></li>
				<li><a href="../accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div align="center" style="padding-top:3px ">
			<ul style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:90%; ">
				<li><a href="conti">Gestione Conti</a></li>
				<li><a id="current1">Gestione Gruppi</a></li>
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
		<FORM name="gruppi" action="conti" method="post" onSubmit="return isOk()">
			<TABLE class="tcontentmaxi" align="center">
				<TR class="intestazione">
					<TD width="3%"></TD>
					<TD><B>Gruppo</B></TD>
					<TD><B>Tipo</B></TD>
					<TD></TD>
				</TR>
<%
			for(int i = 0; i < ListaGruppi.size(); i++)
			{
				Gruppo g = ((Gruppo) ListaGruppi.get(i));
				String tipoStr = "";
				int tipo = g.getTipo().intValue();
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
					<TD><%= g.getNome() %></TD>
					<TD width="10%"><%= tipoStr %></TD>
					<TD align="center" width="4%"><a href="conti?action=del&what=gruppi&id=<%= g.getId() %>" onclick="return(confirm('Sicuro?'))"><img src="img/del.gif" border="0"></a></TD>
				</TR>
<%				
			}
%>
				<TR><TD></TD></TR>
				<TR>
					<TD colspan="3" align="center">
						<input type="submit" value="Nuovo gruppo">
					</TD>
				</TR>
			</TABLE>
			<INPUT type="hidden" name="action" value="new">
			<INPUT type="hidden" name="what" value="gruppi">
		</FORM>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2005</P>
		</DIV>
	</div>
</BODY>
</HTML>
