<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	List LB = (List) request.getAttribute("listabambini");
	
	Avviso err = (Avviso) request.getAttribute("err");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<script language="javascript">
<!--

function kk()
{
	alert('cazzo');
	return false;
}

function isOk()
{
	if(document.ado.anno.value == '')
	{
		alert('Anno non valido!');
		return false;
	}
	if(isNaN(document.ado.anno.value))
	{
		alert('Anno non valido!');
		return false;
	}
	if(parseInt(document.ado.anno.value) < 1900)
	{
		alert('Anno non valido!');
		return false;
	}
	
	var indexB = document.ado.bambino.selectedIndex;
	
	var b_sel = document.ado.bambino.options[indexB].value;
	
	if(b_sel == '-1')
	{
		alert("Selezionare un bambino!");
		return false;
	}
	
	return true;
}
//-->
</script>

<STYLE type="text/css">
	@import url("style.css");
</STYLE>
<TITLE>H.O.P.E. - Help Other People Everywhere</TITLE>
</HEAD>
<BODY id="body">
	<div id="container">
		<TABLE border=0 align=center width=100%>
			<TR>
				<TD align=left><img src="./img/logo.gif" height=80px></TD>
				<TD align=center><p class="bilancio">H.O.P.E. - Gestione Soci</p></TD>
				<TD align=right><img src="./img/logo.gif" height=80px></TD>
			</TR>
		</TABLE>
		<div id="menu" align="center">
			<ul>
				<li><a href="accedisoci">Home</a></li>
				<li><a href="anagrafe">Anagrafe</a></li>
				<li><a href="soci">Soci</a></li>
				<li><a href="#">Azionisti</a></li>
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
		<FORM name="ado" action="adozioni" method="post" onSubmit="return isOk()">
			<TABLE class="tcontent" align="center">
				<TR class="intestazione"><TD colspan="2" align="center">Dettagli Adottante</TD></TR>
				<TR>
					<TD width="40%"><B>Cognome : </B></TD>
					<TD>
						<%= request.getParameter("cognome") %>
					</TD>
				</TR>
				<TR>
					<TD><B>Nome : </B></TD>
					<TD>
						<%= request.getParameter("nome") %>
					</TD>
				</TR>
				<TR>
					<TD><B>Indirizzo : </B></TD>
					<TD>
						<%= request.getParameter("indirizzo") %>
					</TD>
				</TR>
				<TR>
					<TD><B>CAP : </B></TD>
					<TD>
						<%= request.getParameter("cap") %>
					</TD>
				</TR>
				<TR>
					<TD><B>Città : </B></TD>
					<TD>
						<%= request.getParameter("citta") %>
					</TD>
				</TR>
				<TR>
					<TD><B>Nazione : </B></TD>
					<TD>
						<%= request.getParameter("nazione") %>
					</TD>
				</TR>
				<TR>
					<TD><B>Telefono : </B></TD>
					<TD>
						<%= request.getParameter("telefono") %>
					</TD>
				</TR>
				<TR>
					<TD><B>Cellulare : </B></TD>
					<TD>
						<%= request.getParameter("cellulare") %>
					</TD>
				</TR>
				<TR>
					<TD><B>E-mail : </B></TD>
					<TD>
						<%= request.getParameter("email") %>
					</TD>
				</TR>
				<TR>
					<TD><B>Codice Fiscale : </B></TD>
					<TD>
						<%= request.getParameter("codfiscale") %>
					</TD>
				</TR>
				<TR>
					<TD><B>Inviare comunicazioni via POSTA? </B></TD>
					<TD>
						<input type="radio" name="posta" value="true" disabled <% if((request.getParameter("posta")).equals("true")) out.print("checked");%>> Si &nbsp&nbsp&nbsp&nbsp&nbsp; <input type="radio" name="posta" value="false" disabled <% if((request.getParameter("posta")).equals("false")) out.print("checked");%>> No
					</TD>
				</TR>
				<TR><TD colspan="2"></TD></TR>
				<TR>
					<TD colspan="2" class="intestazione" align="center">
						Dettagli adozione:
					</TD>
				</TR>
				<TR><TD></TD></TR>
				<TR>
					<TD><B>Anno : </B></TD>
					<TD>
						<%= request.getParameter("anno") %>
					</TD>
				</TR>
				<TR>
					<TD width="40%"><B>Bambino : </B></TD>
					<TD>
<%
					if(LB.size() > 0)
					{
%>		
						<select name="bambino" style="width:400px ">
							<option value="-1"><B>Nome</B>, Sesso, Nazione, Scuola, Costo</option>
<%
						for(int i = 0; i < LB.size(); i++)
						{
							BambiniliberiId b = ((Bambiniliberi) LB.get(i)).getId();
%>
							<option value="<%= b.getId() %>"><strong><%= b.getNome() %></strong>, <%= b.getSesso() %>, <%= b.getNazione() %>, <%= b.getScuola() %>, <%= b.getCosto() %> €/anno</option>
<%
						}
					}
					else
					{
%>
						<B>Non ci sono bambini disponibili per l'anno scelto.</B>
<%
					}
%>
						</select>
					</TD>
				</TR>
				<TR>
					<TD colspan="2">
						<BR>
						<TABLE align="center" width="100%">
							<TR>
								<TD align="left" width="33%">
									<INPUT type="button" value="Indietro" onClick="javascipt:history.back()">
								</TD>
								<td align="right">
									<INPUT type="submit" value="Inserisci"
<%
									if(LB.size() == 0)
										out.print(" disabled ");
%>	
									>
								</td>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
			<INPUT type="hidden" name="action" value="insert">
			<input type="hidden" name="page" value="insert">
			<input type="hidden" name="id" value="<%= request.getParameter("id") %>">
			<input type="hidden" name="cognome" value="<%= request.getParameter("cognome") %>">
			<input type="hidden" name="nome" value="<%= request.getParameter("nome") %>">
			<input type="hidden" name="indirizzo" value="<%= request.getParameter("indirizzo") %>">
			<input type="hidden" name="cap" value="<%= request.getParameter("cap") %>">
			<input type="hidden" name="citta" value="<%= request.getParameter("citta") %>">
			<input type="hidden" name="nazione" value="<%= request.getParameter("nazione") %>">
			<input type="hidden" name="telefono" value="<%= request.getParameter("telefono") %>">
			<input type="hidden" name="cellulare" value="<%= request.getParameter("cellulare") %>">
			<input type="hidden" name="email" value="<%= request.getParameter("email") %>">
			<input type="hidden" name="codfiscale" value="<%= request.getParameter("codfiscale") %>">
			<input type="hidden" name="anno" value="<%= request.getParameter("anno") %>">
			<input type="hidden" name="posta" value="<%= request.getParameter("posta") %>">
		</FORM>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2005</P>
		</DIV>
	</div>
</BODY>
</HTML>
