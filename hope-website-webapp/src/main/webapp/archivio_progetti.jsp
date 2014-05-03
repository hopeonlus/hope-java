<%@ page language="java" import="java.util.*" %>
<%@ page import="mapping.*" %>

<%
	////////////
	/// DATI ///
	////////////
	List dati = (List) request.getAttribute("dati");
	List img = (List) request.getAttribute("img");
	String regione = (String) request.getAttribute("nome_regione");
	String id_regione = (String) request.getAttribute("id_regione");
			
	Progetti progetto = new Progetti();

	/////////////////////
	/// EVENTI & HIGH ///
	/////////////////////
	List eventi = (List) request.getAttribute("eventi");
	String high = (String) request.getAttribute("high");
	
	//////////////
	//CALENDARIO//
	//////////////
	String mese = (String) request.getParameter("mese");
	String anno = (String) request.getParameter("anno");
	
	GregorianCalendar today = new GregorianCalendar();
	int mese_oggi = today.get(Calendar.MONTH);
	int giorno_oggi = today.get(Calendar.DATE);
	int anno_oggi = today.get(Calendar.YEAR);
	
	if((mese != null)&&(anno != null))
	{
		int anno_int = Integer.parseInt(anno);
		int mese_int = Integer.parseInt(mese);
		if(mese_int == mese_oggi)
			today = new GregorianCalendar(anno_int, mese_int, giorno_oggi);
		else
			today = new GregorianCalendar(anno_int, mese_int, 1);
	}
	
	int day = today.get(Calendar.DATE);
	int month = today.get(Calendar.MONTH);
	int year = today.get(Calendar.YEAR);
	
	//devo sapere in che giorno della sett cade il primo giorno del mese
	today.clear(Calendar.DATE);
	today.set(Calendar.DATE, 1);
	int day_sett = today.get(Calendar.DAY_OF_WEEK);
	
	int[] day_month = {31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
	if( year%4 == 0 )
		day_month[1] = 29;
	else
		day_month[1] = 28;
		
	int tot_giorni = day_month[month];
	
	int d = 1;
	
	String[] mesi = {"Gennaio", "Febbraio", "Marzo", "Aprile", "Maggio", "Giugno", "Luglio", "Agosto", "Settembr", "Ottobre", "Novembr", "Dicembre"};
	String[] giorni = {"", "Domenica", "Lunedì", "Martedì", "Mercoledì", "Giovedì", "Venerdì", "Sabato"};
	String month_str = mesi[month];%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<script type="text/javascript">
<!--
function newImage(arg) {
	if (document.images) {
		rslt = new Image();
		rslt.src = arg;
		return rslt;
	}
}

function changeImages() {
	if (document.images && (preloadFlag == true)) {
		for (var i=0; i<changeImages.arguments.length; i+=2) {
			document[changeImages.arguments[i]].src = changeImages.arguments[i+1];
		}
	}
}

var preloadFlag = false;
function preloadImages() {
	if (document.images) {
		 
		preloadFlag = true;
	}
}

function Alto(x){
	img = new Image();
	img.src = x;
	if(img.height > img.width)
		document.write("<img src=\"" + x + "\" height=\"75\" border=\"1\" style=\"border-color:#0000FF \">");
	else
		document.write("<img src=\"" + x + "\" width=\"90\" border=\"1\" style=\"border-color:#0000FF \">");
}

// -->
</script>

<SCRIPT language="JavaScript" src="tooltip.js"></SCRIPT>

<TITLE>H.O.P.E. ONLUS - Help Other People Everywhere</TITLE>
<STYLE type="text/css">
	@import url("style1.css");
</STYLE>
</HEAD>

<BODY onLoad="preloadImages();" background="img/back_blu.jpg">
	<div id="container">
		<!--<script type="text/javascript" src="http://www.makepovertyhistory.org/whiteband_small_right.js"> </script><noscript><a href="http://www.makepovertyhistory.org/"> http://www.makepovertyhistory.org</a></noscript>//-->
		<div id="banner">
			<img src="./img/main_01.jpg" usemap="#mainIMG_Map" border="0">
		</div>
		
		<div id="menunew">
     		 <ul> 
				<li><a href="home?action=SHOW&what=CHISIAMO" onMouseOver="this.id='sel'" onMouseOut="this.id='1'">CHi SiAMO</a></li> 
				<li><a href="news" onMouseOver="this.id='sel'" onMouseOut="this.id='2'">NEWS</a></li> 
				<li><a href="progetti" id="sel">PROGETTi</a></li> 	
				<li><a href="adozioni" onMouseOver="this.id='sel'" onMouseOut="this.id='4'">ADOZiONi</a></li> 
				<li><a href="home?action=SHOW&what=AIUTACI" onMouseOver="this.id='sel'" onMouseOut="this.id='5'">SOSTIENICI</a></li>
    		</ul> 
		</div>
		
		<div id="content">
			<div id="menu_sx">
				<TABLE cellpadding="0" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<TR>
						<TD><IMG src="img/cornice/AngSxUp_dx.gif" border="0"></TD>
						<TD><img src="img/cornice/TileUp_dx.gif" width="120" height="16" border="0"></TD>
						<TD><img src="img/cornice/AngDxUp_dx.gif" border="0"></TD>
					</TR>
					<TR>
						<TD><img src="img/cornice/tileSx_dx.gif" width="20" height="120"></TD>
						<TD></TD>
						<TD><img src="img/cornice/tileDx_dx.gif" width="24" height="120"></TD>
					</TR>
					<TR>
						<TD><img src="img/cornice/AngSxDown_dx.gif"></TD>
						<TD><img src="img/cornice/tileDown_dx.gif" width="120" height="16"></TD>
						<TD><img src="img/cornice/AngDxDown_dx.gif"></TD>
					</TR>
				</TABLE>
				<BR>
				<TABLE cellpadding="0" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<TR>
						<TD><IMG src="img/cornice/AngSxUp_dx.gif" border="0"></TD>
						<TD><img src="img/cornice/TileUp_dx.gif" width="120" height="16" border="0"></TD>
						<TD><img src="img/cornice/AngDxUp_dx.gif" border="0"></TD>
					</TR>
					<TR>
						<TD><img src="img/cornice/tileSx_dx.gif" width="20" height="120"></TD>
						<TD></TD>
						<TD><img src="img/cornice/tileDx_dx.gif" width="24" height="120"></TD>
					</TR>
					<TR>
						<TD><img src="img/cornice/AngSxDown_dx.gif"></TD>
						<TD><img src="img/cornice/tileDown_dx.gif" width="120" height="16"></TD>
						<TD><img src="img/cornice/AngDxDown_dx.gif"></TD>
					</TR>
				</TABLE>
				<div id="menu_sx_content_1" style="vertical-align:bottom ">
				<TABLE border="0" align="center" width="136" bgcolor="#FFFFFF">
					<TR>
						<TD align="left" style="padding-left:0px; padding-right:0px;padding-bottom:5px ">
							<A HREF="progetti?action=SHOW&what=<%= (String)request.getParameter("what") %>&id=<%= id_regione %>&mese=<%= month-1 %>&anno=<%= year %>"><img src="img/indietro_on.gif" border="0" width="11px" title="Mese precedente"></a>
						</TD>
						<TD colspan="5" align="center" style="padding-left:0px; padding-right:0px;padding-bottom:5px  ">
							<FONT class="calend_t"><B><%= month_str + "  " + year %></B></FONT>
						</TD>
						<TD align="right" style="padding-left:0px; padding-right:0px;padding-bottom:5px ">
							<A HREF="progetti?action=SHOW&what=<%= (String)request.getParameter("what") %>&id=<%= id_regione %>&mese=<%= month+1 %>&anno=<%= year %>"><img src="img/avanti_on.gif" border="0" width="11px" title="Mese successivo"></a>
						</TD>
					</TR>
					<TR>
						<TD width="14%"><FONT class="calend"><B>D</B></FONT></TD>
						<TD width="14%"><FONT class="calend"><B>L</B></FONT></TD>
						<TD width="14%"><FONT class="calend"><B>M</B></FONT></TD>
						<TD width="14%"><FONT class="calend"><B>M</B></FONT></TD>
						<TD width="14%"><FONT class="calend"><B>G</B></FONT></TD>
						<TD width="14%"><FONT class="calend"><B>V</B></FONT></TD>
						<TD width="14%"><FONT class="calend"><B>S</B></FONT></TD>
					</TR>
					<TR>
					<%
						for(int i = 1; i < day_sett; i++) {
							out.println("<TD></TD>");
						}
						
						for(int i = day_sett; i < 8; i++) {
						
							int ok = -1;
							Eventi tmp = null;
							for(int k = 0; k < eventi.size(); k++)
								{
									tmp = (Eventi) eventi.get(k);
									Date data = tmp.getData();
										Calendar data1 = new GregorianCalendar();
										data1.setTime(data);
										int giorno = data1.get(Calendar.DAY_OF_MONTH);
									if(giorno == d)
									{
										ok = tmp.getId().intValue();
										break;
									}
								}
							
							if((month == mese_oggi)&&(year == anno_oggi)&&(d == day)) {
								//C'è un evento OGGI??
								if(ok == -1) { %>
									<TD  bgcolor="#000099" align="center"><span onMouseOver="toolTip('Oggi è <%= giorni[i] + " " + d + " " + month_str + " " + year %>')" onMouseOut="toolTip()"><FONT class="calend_w"><B><%= d %></B></FONT></span></TD>
								<% } else {  %>
									<TD  bgcolor="#000099" align="center"><a href="news?action=SHOW&what=NEWS&id=<%= ok %>" onMouseOver="toolTip('<table style=font-size:9px><TR><TD colspan=2 align=center><font style=text-transform:uppercase; size=-2><B><%= tmp.getTitolo() %></B></font></td></TR><tr><td>Dove :</td><td><%= tmp.getLuogo() %></td></tr><tr><td>Ore :</td><td><%= tmp.getOra() %></td></tr></table>')" onMouseOut="toolTip()"><FONT class="calend_w"><B><%= d %></B></FONT></a></TD>
								<% }
								} else {
								if(ok == -1) { %>
									<TD align="center"><FONT class="calend"><%= d %></FONT></TD>
								<% } else { %>
									<TD bgcolor="#FFE6C4" align="center"><a href="news?action=SHOW&what=NEWS&id=<%= ok %>" onMouseOver="toolTip('<table style=font-size:9px><TR><TD colspan=2 align=center><font style=text-transform:uppercase; size=-2><B><%= tmp.getTitolo() %></B></font></td></TR><tr><td>Dove :</td><td><%= tmp.getLuogo() %></td></tr><tr><td>Ore :</td><td><%= tmp.getOra() %></td></tr></table>')" onMouseOut="toolTip()"><FONT class="calend_evento"><%= d %></FONT></a></TD>
								<% }
							}
							d++;
						}
					%>
						
					</TR>
						<%
						while(d <= tot_giorni) {
							out.println("<TR>");
							for(int i = 1; ((i < 8)&&(d <= tot_giorni)); i++) {
								
								int ok = -1;
								Eventi tmp = null;
								for(int k = 0; k < eventi.size(); k++)
									{
										tmp = (Eventi) eventi.get(k);
										Date data = tmp.getData();
										Calendar data1 = new GregorianCalendar();
										data1.setTime(data);
										int giorno = data1.get(Calendar.DAY_OF_MONTH);
										if(giorno == d)
										{
											ok = tmp.getNews().getId().intValue();
											break;
										}
									}
								
								if((month == mese_oggi)&&(year == anno_oggi)&&(d == day)) {
								//C'è un evento OGGI??
								if(ok == -1) { %>
									<TD  bgcolor="#000099" align="center"><span onMouseOver="toolTip('Oggi è <%= giorni[i] + " " + d + " " + month_str + " " + year %>')" onMouseOut="toolTip()"><FONT class="calend_w"><B><%= d %></B></FONT></span></TD>
								<% } else {  %>
									<TD  bgcolor="#000099" align="center"><a href="news?action=SHOW&what=NEWS&id=<%= ok %>" onMouseOver="toolTip('<table style=font-size:9px><TR><TD colspan=2 align=center><font style=text-transform:uppercase; size=-2><B><%= tmp.getTitolo() %></B></font></td></TR><tr><td>Dove :</td><td><%= tmp.getLuogo() %></td></tr><tr><td>Ore :</td><td><%= tmp.getOra() %></td></tr></table>')" onMouseOut="toolTip()"><FONT class="calend_w"><B><%= d %></B></FONT></a></TD>
								<% }
								} else {
								if(ok == -1) { %>
									<TD align="center"><FONT class="calend"><%= d %></FONT></TD>
								<% } else { %>
									<TD bgcolor="#FFE6C4" align="center"><a href="news?action=SHOW&what=NEWS&id=<%= ok %>" onMouseOver="toolTip('<table style=font-size:9px><TR><TD colspan=2 align=center><font style=text-transform:uppercase; size=-2><B><%= tmp.getTitolo() %></B></font></td></TR><tr><td>Dove :</td><td><%= tmp.getLuogo() %></td></tr><tr><td>Ore :</td><td><%= tmp.getOra() %></td></tr></table>')" onMouseOut="toolTip()"><FONT class="calend_evento"><%= d %></FONT></a></TD>
								<% }
								} 
								d++;
							}
							out.println("</TR>");
						}
						%>
				</TABLE>
				</div>
				<div id="menu_sx_content_2" align="center">
					<BR>
					<font class="subtitle_news"><strong>NEWS</strong></font>
						<font size="2" face="Tahoma">
							<div align="center">
								<marquee direction="up" scrollAmount=1 width="115" height="110" bgcolor="#FFFFFF" scrolldelay="50">
									<%= high %>
								</marquee>
							</div>
					</font>
				</div>
			</div>
			
			<div id="menu_dx">
				<TABLE cellpadding="0" cellspacing="0" border="0">
					<TR>
						<TD><IMG src="img/cornice/AngSxUp_dx.gif" border="0"></TD>
						<TD><img src="img/cornice/TileUp_dx.gif" width="90" height="16" border="0"></TD>
						<TD><img src="img/cornice/AngDxUp_dx.gif" border="0"></TD>
					</TR>
					<TR>
						<TD><img src="img/cornice/tileSx_dx.gif" width="20" height="90"></TD>
						<TD bgcolor="#FFFFFF"></TD>
						<TD><img src="img/cornice/tileDx_dx.gif" width="24" height="90"></TD>
					</TR>
					<TR>
						<TD><img src="img/cornice/AngSxDown_dx.gif"></TD>
						<TD><img src="img/cornice/tileDown_dx.gif" width="90" height="16"></TD>
						<TD><img src="img/cornice/AngDxDown_dx.gif"></TD>
					</TR>
				</TABLE>
			</div>
			<div id="menu_dx">
				<font class="style1">
					<BR>
					<font style="color:#0000CC; size:13px">&nbsp&nbsp&nbsp;Progetti :<BR><BR></font>
					<%	if(regione.equals("IN CORSO")) { %>
							&nbsp&nbsp&nbsp&nbsp&nbsp;<a href="progetti?action=SHOW&what=ALL"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;TUTTI</a><BR>
							&nbsp&nbsp&nbsp&nbsp&nbsp;<a href="progetti?action=SHOW&what=REALIZZ"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;REALIZZATI</a><BR>
							&nbsp&nbsp&nbsp&nbsp&nbsp;<img src="img/fr1_giu.gif" border="0px"> &nbsp&nbsp;IN CORSO<BR>
							&nbsp&nbsp&nbsp&nbsp&nbsp;<a href="progetti"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;PER REGIONE</a><BR>
					<% } else if(regione.equals("REALIZZATI")) { %>
							&nbsp&nbsp&nbsp&nbsp&nbsp;<a href="progetti?action=SHOW&what=ALL"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;TUTTI</a><BR>
							&nbsp&nbsp&nbsp&nbsp&nbsp;<img src="img/fr1_giu.gif" border="0px"> &nbsp&nbsp;REALIZZATI<BR>
							&nbsp&nbsp&nbsp&nbsp&nbsp;<a href="progetti?action=SHOW&what=INCORSO"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;IN CORSO</a><BR>
							&nbsp&nbsp&nbsp&nbsp&nbsp;<a href="progetti"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;PER REGIONE</a><BR>
					<% } else if(regione.equals("TUTTI")) { %>
							&nbsp&nbsp&nbsp&nbsp&nbsp;<img src="img/fr1_giu.gif" border="0px"> &nbsp&nbsp;TUTTI<BR>
							&nbsp&nbsp&nbsp&nbsp&nbsp;<a href="progetti?action=SHOW&what=REALIZZ"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;REALIZZATI</a><BR>
							&nbsp&nbsp&nbsp&nbsp&nbsp;<a href="progetti?action=SHOW&what=INCORSO"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;IN CORSO</a><BR>
							&nbsp&nbsp&nbsp&nbsp&nbsp;<a href="progetti"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;PER REGIONE</a><BR>
					<% } else { %>
							&nbsp&nbsp&nbsp&nbsp&nbsp;<a href="progetti?action=SHOW&what=ALL"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;TUTTI</a><BR>
							&nbsp&nbsp&nbsp&nbsp&nbsp;<a href="progetti?action=SHOW&what=REALIZZ"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;REALIZZATI</a><BR>
							&nbsp&nbsp&nbsp&nbsp&nbsp;<a href="progetti?action=SHOW&what=INCORSO"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;IN CORSO</a><BR>
							&nbsp&nbsp&nbsp&nbsp&nbsp;<img src="img/fr1_giu.gif" border="0px"> &nbsp&nbsp;PER REGIONE<BR>
					<% } %>
				</font>
			</div>			
			
			<div id="testo">
				<div style="padding-top:3px; color:#000099;">
					<FONT FACE="VERDANA, ARIAL" SIZE="1" COLOR="#000099"> 
					<a href="home">H.O.P.E.</a> > 
					<a href="progetti">Progetti</a> > 
						<%= regione %></FONT>
				</div> 
				<br/>
				<h2>
					<img src="img/meno.gif" border="0">
					PROGETTi
				</h2>
				<%--
				<TABLE width="440px" border="0" cellpadding="0" cellspacing="2">
				<% for(int i = 0; i < dati.size(); i++)
					{ 
						String imgX = ((Immagini) img.get(i)).getImg();
						progetto = (Progetti) dati.get(i);
				%>
						<TR>
							<TD style="padding:5px; border-top:1px dashed #333333; border-bottom:1px dashed #333333;" width="25%">
								<a href="progetti?action=SHOW&what=PROGETTO&id=<%= progetto.getId() %>">
									<script language="javascript">
										Alto("<%=imgX %>");
									</script>
								</a>
							</TD>
				<% if((progetto.getRealizzato()).intValue() == 1) {   %>
							<TD style="padding:5px;background-repeat:no-repeat; background-position:center; border-top:1px dashed #333333; border-bottom:1px dashed #333333;" background="img/realizzato.gif">
				<% } else {   %>
							<TD style="padding:5px; border-top:1px dashed #333333; border-bottom:1px dashed #333333;">
				<%  }  %>
								<a href="progetti?action=SHOW&what=PROGETTO&id=<%= progetto.getId() %>">
									<h2>
										<%= progetto.getTitolo() %>
									</h2>
									<h3>
										<%= progetto.getSottotitolo() %>
									</h3>
								</a>
							</TD>
						</TR>
					<% } %>
				</TABLE>
				--%>
				
				<table width="440px" border="0" cellpadding="0" cellspacing="0">
				<% for(int i = 0; i < dati.size(); i++)
					{
						progetto = (Progetti) dati.get(i);
						String icona = null;
						try {	
							icona = progetto.getRegioni().getIcona_path();
						} catch (Throwable e) {
							int idreg = progetto.getRegioni().getId().intValue();
							switch (idreg)
							{		
								case 1 : icona = "img/africa_icon.gif"; break;
								case 2 : icona = "img/america_icon.gif"; break;
								case 3 : icona = "img/asia_icon.gif"; break;
							}
						}
				%>
					<tr>
						<td style="padding-top:10px; padding-left:30px; " colspan="2">
							<h4>Anno <%= progetto.getInizio() %></h4>
						</td>
					</tr>
					<tr>
						<td style="padding-left:30px; " rowspan="2" align="center">
							<img src="<%= icona %>" alt="" border="0"/>
						</td>
						<td style="padding-left:20px; ">
							<a href="progetti?action=SHOW&what=PROGETTO&id=<%= progetto.getId() %>">
								<h2><%= progetto.getTitolo() %></h2>
							</a>
						</td>
					</tr>
					<tr>
						<td style="padding-left:20px; padding-bottom:8px; ">
							<h3><%= progetto.getSottotitolo() %></h3>							
						</td>
					</tr>
				<%
					}
				%>
					<tr>
						<td colspan="2" style="padding-bottom:30px;">
						</td>
					</tr>
				</table>
		  </div>
			<div id="bottom">
				<div class="bottom_text" style="padding-top:5px ">
					<a href="home">Home</a>
					&nbsp&nbsp;|&nbsp&nbsp;
					<a href="home?action=SHOW&what=CHISIAMO">Chi siamo?</a>
					&nbsp&nbsp;|&nbsp&nbsp;
					<a href="home?action=SHOW&what=NEWSLETTER">Newsletter</A>
					&nbsp&nbsp;|&nbsp&nbsp;
					<A href="home?action=SHOW&what=CONTATTI">Contattaci</a>
					&nbsp&nbsp;|&nbsp&nbsp;
					<a href="home?action=SHOW&what=AIUTACI">Sostienici</A>
					&nbsp&nbsp;|&nbsp&nbsp;
					<a href="home?action=SHOW&what=LINK">Link</a>
				</div>
			</div>
		</div>
	</div>
		
	<map name="mainIMG_map">
		<area shape="rect" alt="" coords="38,20,118,137" href="home">
	</map>
</BODY>

</HTML>