<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	List ListaPagamenti = (List) request.getAttribute("pagamentosoci");	
	Socio socioo = (Socio) request.getAttribute("socio");
	
	Anagrafe socio = socioo.getAnagrafe();
	String tessera = socioo.getTessera().toString();
	
	String what = request.getParameter("what");
	String anno = request.getParameter("anno");
	String dal = request.getParameter("dal");
	String al = request.getParameter("al");
	
	Avviso err = (Avviso) request.getAttribute("err");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<script language="javascript">
<!--
function sicuro()
{
	if(confirm('Sicuro?'))
		window.location.href='soci?action=delsocio&what=<%= what %>&anno=<%= anno %>&dal=<%= dal %>&al=<%= al %>&tessera=<%= tessera %>';
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
				<li><a id="current">Soci</a></li>
				<!--<li><a href="#">Azionisti</a></li>-->
				<li><a href="adozioni">Adozioni</a></li>
				<li><a href="stampa">Stampa</a></li>
				<li><a href="../accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div align="center" style="padding-top:3px ">
			<ul style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:90%; ">
				<li><a href="soci">Visualizza</a></li>
				<li><a id="current1">Inserisci</a></li>
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
		<FORM name="socio" action="anagrafe" method="get">
			<TABLE class="tcontent" align="center">
				<TR class="intestazione"><TD colspan="2" align="center">SCHEDA SOCIO</TD></TR>
				<TR>
					<TD width="40%"><B>N° tessera : </B></TD>
					<TD><B><%= tessera %></B></TD>
				</TR>
				<TR>
					<TD><B>Cognome : </B></TD>
					<TD>
						<%= socio.getCognome() %>
					</TD>
				</TR>
				<TR>
					<TD><B>Nome : </B></TD>
					<TD>
						<%= socio.getNome() %>
					</TD>
				</TR>
				<TR>
					<TD><B>Indirizzo : </B></TD>
					<TD>
						<%= socio.getIndirizzo() %>
					</TD>
				</TR>
				<TR>
					<TD><B>CAP : </B></TD>
					<TD>
						<%= socio.getCap() %>
					</TD>
				</TR>
				<TR>
					<TD><B>Città : </B></TD>
					<TD>
						<%= socio.getCitta() %>
					</TD>
				</TR>
				<TR>
					<TD><B>Nazione : </B></TD>
					<TD>
						<%= socio.getNazione() %>
					</TD>
				</TR>
				<TR>
					<TD><B>Telefono : </B></TD>
					<TD>
						<%= socio.getTelefono() %>
					</TD>
				</TR>
				<TR>
					<TD><B>Cellulare : </B></TD>
					<TD>
						<%= socio.getCellulare() %>
					</TD>
				</TR>
				<TR>
					<TD><B>E-mail : </B></TD>
					<TD>
						<%= socio.getEmail() %>
					</TD>
				</TR>
				<TR>
					<TD><B>Codice Fiscale : </B></TD>
					<TD>
						<%= socio.getCodfiscale() %>
					</TD>
				</TR>
				<TR>
					<TD><B>Inviare comunicazioni via POSTA? </B></TD>
					<TD>
						<input type="radio" name="posta" value="true" <% if(socio.isPosta()) out.print("checked");%> disabled> Si &nbsp&nbsp&nbsp&nbsp&nbsp; <input type="radio" name="posta" value="false" <% if(!socio.isPosta()) out.print("checked");%> disabled> No
					</TD>
				</TR>
				<TR><TD colspan="2"></TD></TR>
				<TR>
					<td colspan="2" align="right">
						<input type="submit" value="Modifica">
					</td>
				</TR>
				<TR><TD colspan="2"></TD></TR>
				<TR>
					<TD colspan="2" class="intestazione" align="center">
						Dettaglio pagamenti:
					</TD>
				</TR>
				<TR><TD></TD></TR>
				<TR>
					<TD colspan="2">
						<TABLE class="tcontent" align="center" style="width:50% ">
							<TR id="row1">
								<TD><B>Anno</B></TD>
								<TD><B>Importo</B></TD>
								<TD></TD>
							</TR>
<%
						for(int i = 0; i< ListaPagamenti.size(); i++)
						{
							Pagamentosoci ps = (Pagamentosoci) ListaPagamenti.get(i);
%>
							<TR id="row0">
								<TD><%= ps.getAnno() %></TD>
								<TD><%= ps.getImporto() %></TD>
								<TD align="center"><a href="soci?action=delpagamento&idp=<%= ps.getId() %>&what=<%= what %>&anno=<%= anno %>&dal=<%= dal %>&al=<%= al %>&tessera=<%= tessera %>" onclick="return(confirm('Sicuro?'))"><img src="img/del.gif" border="0"></a></TD>
							</TR>
<%
						}
						if(ListaPagamenti.size() == 0)
						{
%>
							<TR id="row0">
								<TD colspan="3" align="center">
									Nessun pagamento inserito
								</TD>
							</TR>
<%
						}
%>
							<TR><TD></TD></TR>

							<TR>
								<TD colspan="3" align="center">
									<input type="button" value="Inserisci" style="font-size:9px " onClick="window.location.href='soci?action=insert&page=scheda&what=<%= what %>&anno=<%= anno %>&dal=<%= dal %>&al=<%= al %>&tessera=<%= tessera %>'">
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD colspan="2">
						<BR>
						<TABLE align="center" width="100%">
<%
						if(what == null)
						{
%>
							<TR>
								<TD align="left" width="33%">
									<INPUT type="button" value="Indietro" onClick="window.location.href='soci?action=insert&page=first'">
								</TD>
								<td align="center" width="33%">
									<INPUT type="button" value="Cancella" onClick="javascript:sicuro()">
								</td>
								<td align="right">
									<INPUT type="button" value="Ok" onClick="window.location.href='soci?action=insert&page=first'">
								</td>
							</TR>
<%
						}
						else if(what.equals("null"))
						{
%>
							<TR>
								<TD align="left" width="33%">
									<INPUT type="button" value="Indietro" onClick="window.location.href='soci?action=insert&page=first'">
								</TD>
								<td align="center" width="33%">
									<INPUT type="button" value="Cancella" onClick="javascript:sicuro()">
								</td>
								<td align="right">
									<INPUT type="button" value="Ok" onClick="window.location.href='soci?action=insert&page=first'">
								</td>
							</TR>
<%
						}
						else
						{
%>		
							<TR>
								<TD align="left" width="33%">
									<INPUT type="button" value="Indietro" onClick="window.location.href='soci?action=select&what=<%= what %>&anno=<%= anno %>&dal=<%= dal %>&al=<%= al %>'">
								</TD>
								<td align="center" width="33%">
									<INPUT type="button" value="Cancella" onClick="javascript:sicuro()">
								</td>
								<td align="right">
									<input type="button" value="OK" onClick="window.location.href='soci?action=select&what=<%= what %>&anno=<%= anno %>&dal=<%= dal %>&al=<%= al %>'">
								</td>
							</TR>
<%						
						}
%>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
			<INPUT type="hidden" name="action" value="view">
			<input type="hidden" name="id" value="<%= socio.getId() %>">
			<input type="hidden" name="nextpage" value="soci/soci?action=view&tessera=<%= tessera %>&what=<%= what %>&anno=<%= anno %>&dal=<%= dal %>&al=<%= al %>">
		</FORM>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2005</P>
		</DIV>
	</div>
</BODY>
</HTML>
