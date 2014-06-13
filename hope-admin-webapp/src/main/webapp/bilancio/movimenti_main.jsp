<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	List ListaMovimenti = (List) request.getAttribute("listamovimenti");
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
				<li><a href="scritture">Visualizza</a></li>
				<li><a href="scritture?action=new">Nuova</a></li>
				<li><a id="current1">Movimenti</a></li>
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
		<FORM name="movimenti" action="scritture" method="post" onSubmit="return isOk()">
			<TABLE class="tcontentmaxi" align="center">
				<TR class="intestazione">
					<TD width="3%"></TD>
					<TD><B>Nome</B></TD>
					<TD><B>Descrizione</B></TD>
					<TD width="18%"><B>Dare</B></TD>
					<TD width="18%"><B>Avere</B></TD>
					<TD width="2%"></TD>
					<TD width="2%"></TD>
				</TR>
<%
				for(int i = 0; i < ListaMovimenti.size(); i++)
				{
				Movimenti m = (Movimenti) ListaMovimenti.get(i);
%>
				<TR id="row<%= i%2 %>">
					<TD><%= i+1 %></TD>
					<TD><%= m.getNome() %></TD>
					<TD><%= m.getDescrizione() %></TD>
					<TD><%= m.getDare().getNome() %></TD>
					<TD><%= m.getAvere().getNome() %></TD>
					<TD align="center"><a href="scritture?action=view&what=movimenti&id=<%= m.getId().toString() %>"><img src="img/edit.gif" border="0"></a></TD>
					<TD align="center"><a href="scritture?action=del&what=movimenti&id=<%= m.getId().toString() %>" onclick="return(confirm('Sicuro?'))"><img src="img/del.gif" border="0"></a></TD>
				</TR>
<%				
				}
%>
				<TR><TD></TD></TR>
				<TR>
					<TD colspan="7" align="center">
						<input type="submit" value="Nuovo movimento">
					</TD>
				</TR>
			</TABLE>
			<input type="hidden" name="action" value="new">
			<input type="hidden" name="what" value="movimenti">
		</FORM>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2005</P>
		</DIV>
	</div>
</BODY>
</HTML>
