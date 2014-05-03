<%@ page language="java" import="java.util.*" %>
<%@ page import="system.Avviso"%>
<%@ page import="mapping.*"%>

<%
	Anagrafe n = (Anagrafe) request.getAttribute("nominativo");
	List pagamenti = (List) request.getAttribute("pagamenti");	
	List anagrafe = (List) request.getAttribute("anagrafe");
	
	String nextpage = request.getParameter("nextpage");
	
	Avviso err = (Avviso) request.getAttribute("err");
	
	java.util.Date data = new java.util.Date();
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("dd/MM/yyyy");
    String oggi = formatter.format(data);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<script language="javascript">
<!--
function isOk(w)
{
	if((w.nome.value == '')|(w.cognome.value == '')|(w.indirizzo.value == '')|(w.cap.value == '')|(w.citta.value == '')|(w.nazione.value == ''))
	{
		alert('Completare i campi obbligatori! (*)');
		return false;
	}
	
	return true;
}

function showNames()
{
	el1=document.getElementById('nuovo');
	
	el1.style.display="block";
	document.anagrafe.aggiungi.disabled = true;
}

function inoltra()
{
	var indexA = document.anagrafe.id2.selectedIndex;
	
	var A = document.anagrafe.id2.options[indexA].value;
	window.location.href = 'anagrafe?action=famiglia&what=add&id=<%= n.getId() %>&id1=<%= n.getId() %>&id2=' + A;
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
				<li><a id="current">Anagrafe</a></li>
				<li><a href="soci">Soci</a></li>
				<!--<li><a href="#">Azionisti</a></li>-->
				<li><a href="adozioni">Adozioni</a></li>
				<li><a href="stampa">Stampa</a></li>
				<li><a href="../accedi?action=logout">Logout</a></li>
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
		<FORM name="anagrafe" action="anagrafe" method="post" onSubmit="return isOk(this)">
			<TABLE class="tcontent" align="center">
				<TR class="intestazione" align="center"><TD colspan="2">SCHEDA NOMINATIVO :</TD></TR>
				<TR>
					<TD width="40%"><B>Id : </B></TD>
					<TD><%= n.getId() %></TD>
				</TR>
				<TR>
					<TD><B>Cognome : </B></TD>
					<TD>
						<input type="text" name="cognome" value="<%= n.getCognome() %>" style="width:150px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Nome : </B></TD>
					<TD>
						<input type="text" name="nome" value="<%= n.getNome() %>" style="width:150px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Indirizzo : </B></TD>
					<TD>
						<input type="text" name="indirizzo" value="<%= n.getIndirizzo() %>" style="width:300px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>CAP : </B></TD>
					<TD>
						<input type="text" name="cap" value="<%= n.getCap() %>" style="width:80px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Città (prov) : </B></TD>
					<TD>
						<input type="text" name="citta" value="<%= n.getCitta() %>" style="width:200px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Nazione : </B></TD>
					<TD>
						<input type="text" name="nazione" value="<%= n.getNazione() %>" style="width:150px ">&nbsp&nbsp;*
					</TD>
				</TR>
				<TR>
					<TD><B>Telefono : </B></TD>
					<TD>
						<input type="text" name="telefono" value="<%= n.getTelefono() %>" style="width:150px ">
					</TD>
				</TR>
				<TR>
					<TD><B>Cellulare : </B></TD>
					<TD>
						<input type="text" name="cellulare" value="<%= n.getCellulare() %>" style="width:150px ">
					</TD>
				</TR>
				<TR>
					<TD><B>E-mail : </B></TD>
					<TD>
						<input type="text" name="email" value="<%= n.getEmail() %>" style="width:200px ">
					</TD>
				</TR>
				<TR>
					<TD><B>Codice Fiscale : </B></TD>
					<TD>
						<input type="text" name="codfiscale" value="<%= n.getCodfiscale() %>" style="width:150px ">
					</TD>
				</TR>
				<TR class="intestazione" align="center"><TD colspan="2">Informazioni POSTA :</TD></TR>
				<TR>
					<TD><B>Inviare comunicazioni? </B></TD>
					<TD>
						<input type="radio" name="comunicazioni" value="true" <% if(n.isComunicazioni()) out.print("checked");%>> si &nbsp&nbsp&nbsp&nbsp&nbsp; <input type="radio" name="comunicazioni" value="false" <% if(!n.isComunicazioni()) out.print("checked");%>> no
					</TD>
				</TR>
				<TR>
					<TD>&nbsp</TD>
					<TD>
						<input type="radio" name="posta" value="true" <% if(n.isPosta()) out.print("checked");%>> via posta &nbsp&nbsp&nbsp&nbsp&nbsp; <input type="radio" name="posta" value="false" <% if(!n.isPosta()) out.print("checked");%>> a mano
					</TD>
				</TR>
				<TR>
					<TD valign="top"><B>Inviare insieme ad altri nominativi?</B></TD>
					<TD>
						<table class="tcontent" style="width:60% 	 ">
<%
							Iterator it1 = n.getFamigliasForId1().iterator();
							Iterator it2 = n.getFamigliasForId2().iterator();
							
							while(it1.hasNext())
							{
								Famiglia f1 = (Famiglia) it1.next();
%>
							<TR>
								<TD><%= f1.getAnagrafeById2().getCognome() + " " +  f1.getAnagrafeById2().getNome()%></TD>
								<TD><a href="anagrafe?action=famiglia&what=del&id=<%= n.getId().toString() %>&id1=<%= f1.getAnagrafeById1().getId()%>&id2=<%= f1.getAnagrafeById2().getId()%>" onclick="return(confirm('Sicuro?'))"><img src="img/del.gif" border="0"></a></TD>
							</TR>
<%
							}
							while(it2.hasNext())
							{
								Famiglia f2 = (Famiglia) it2.next();
%>
							<TR>
								<TD><%= f2.getAnagrafeById1().getCognome() + " " +  f2.getAnagrafeById1().getNome()%></TD>
								<TD><a href="anagrafe?action=famiglia&what=del&id=<%= n.getId().toString() %>&id1=<%= f2.getAnagrafeById1().getId()%>&id2=<%= f2.getAnagrafeById2().getId()%>" onclick="return(confirm('Sicuro?'))"><img src="img/del.gif" border="0"></a></TD>
							</TR>
<%
							}
%>
						
							<TR id="nuovo" style="display:none ">
								<TD>
									<select name="id2" style="width:250px ">
<%
									for(int i = 0; i < anagrafe.size(); i++)
									{
										Anagrafe a = (Anagrafe) anagrafe.get(i);
%>
										<option value="<%= a.getId() %>"><%= a.getCognome() + " " + a.getNome() + ", " + a.getCitta() %></option>
<%
									}
%>
									</select>
								</TD>
								<TD>
									<a onClick="javascript:inoltra()"><img src="img/save.jpg" border="0" style="cursor:pointer "></a>
								</TD>
							</TR>
							<TR><TD></TD></TR>
							<TR>
								<TD align="center" colspan="2"><input type="button" class="btn" value="Aggiungi" name="aggiungi" onClick="javascript:showNames()"></TD>
							</TR>
						</table>
					</TD>
				</TR>
				<TR>
					<TD><B></B></TD>
				</TR>
				<TR><TD colspan="2"><BR></TD></TR>
				<TR>
					<TD align="left">
						<INPUT type="button" class="btn" value="Indietro" onClick="javascript:history.back()">
					</TD>
					<TD align="right">
						<input type="submit" class="btn" value="Salva">
					</TD>
				</TR>
			</TABLE>
			<INPUT type="hidden" name="action" value="edit">
			<input type="hidden" name="id" value="<%= n.getId() %>">
			<input type="hidden" name="nextpage" value="<%= nextpage %>">
		</FORM>
		</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2005</P>
		</DIV>
	</div>
</BODY>
</HTML>
