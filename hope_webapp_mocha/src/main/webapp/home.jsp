<%@ page language="java" import="java.util.*" %>
<%@ page import="mapping.*" %>

<%
	////////////
	/// DATI ///
	////////////
	/*List news = (List) request.getAttribute("news"); 
	List img_news = (List) request.getAttribute("img_news");
	Progetti prog = (Progetti) request.getAttribute("progetto");
	Immagini img_prog = (Immagini) request.getAttribute("img_prog");
	
	News news_1 = (News) news.get(0);
	News news_2 = (News) news.get(1);
	Immagini img_news_1 = (Immagini) img_news.get(0);
	Immagini img_news_2 = (Immagini) img_news.get(1);*/
	
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
	String[] giorni = {"", "Domenica", "Lunedi\\'", "Martedi\\'", "Mercoledi\\'", "Giovedi\\'", "Venerdi\\'", "Sabato"};
	String month_str = mesi[month];
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<META NAME="DESCRIPTION" CONTENT="Sito della ONLUS HOPE di Angera.">
<META NAME="KEYWORDS" CONTENT="angera,hope,onlus,commercio equo,adozioni,adozioni a distanza,volontariato,terzo mondo,lago maggiore">
<META NAME="AUTHOR" CONTENT="Stefano Zaninetta">

<script type="text/javascript">
function resetF() {

  with (document.newsletter)
    {
		if(email.value == "Inserisci qui la tua mail")
			email.value="";
	}
}

function Alto1(x){
	img = new Image();
	img.src = x;
	if(img.height > img.width)
		document.write("<img src=\"" + x + "\" height=\"115\" border=\"1\" style=\"border-color:#0000FF \">");
	else
		document.write("<img src=\"" + x + "\" width=\"140\" border=\"1\" style=\"border-color:#0000FF \">");
}

function Alto2(x){
	img = new Image();
	img.src = x;
	if(img.height > img.width)
		document.write("<img src=\"" + x + "\" height=\"85\" border=\"1\" style=\"border-color:#0000FF \">");
	else
		document.write("<img src=\"" + x + "\" width=\"100\" border=\"1\" style=\"border-color:#0000FF \">");
}

function isValid(){
	var str = document.newsletter.email.value;
	if(!((str.indexOf(".") > 2) && (str.indexOf("@") > 0))){
		alert("E-mail non valida. Controlla di averla scritta correttamente.");
		return false;
	}
	else
	{
		return true;
	}
			
}
</script>

<SCRIPT language="JavaScript" src="tooltip.js"></SCRIPT>

<TITLE>HOPE ONLUS Angera - Help Other People Everywhere</TITLE>
<STYLE type="text/css">
	@import url("style1.css");
</STYLE>

<!-- CSS DIV in trasparenza -->
<link rel="stylesheet" href="css/ba/modal.css" type="text/css" />

<!-- javascript british airways -->
<script type="text/javascript" src="js/ba/modal.js"></script>
<script type="text/javascript" src="js/ba/rounded_corners.js"></script>

</HEAD>


<!--<body background="img/back_blu.jpg">-->
<body background="img/back_blu.jpg" onLoad="javascript:window.open('http://www.hopeonlus.it/img/5xmille_avviso_small.jpg', 'remote', 'width=380,height=380,toolbar=no,scrollbars=no,resizable=no,menubar=no')">
	<div id="container">
		<!-- <script type="text/javascript" src="http://www.makepovertyhistory.org/whiteband_small_right.js"> </script><noscript><a href="http://www.makepovertyhistory.org/"> http://www.makepovertyhistory.org</a></noscript> // -->
		<div id="banner">
			<img src="./img/main_01.jpg" usemap="#mainIMG_Map" border="0">		</div>
		
		<div id="menunew">
     		 <ul> 
				<li><a href="home?action=SHOW&what=CHISIAMO" onMouseOver="this.id='sel'" onMouseOut="this.id='1'">CHi SiAMO</a></li> 
				<li><a href="news" onMouseOver="this.id='sel'" onMouseOut="this.id='2'">NEWS</a></li> 
				<li><a href="progetti" onMouseOver="this.id='sel'" onMouseOut="this.id='3'">PROGETTi</a></li> 	
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
			
			<TABLE cellpadding="0" cellspacing="0" border="0" bgcolor="#FFFFFF">
				<TR>
					<TD><IMG src="img/cornice/AngSxUp_dx.gif" border="0"></TD>
					<TD><img src="img/cornice/TileUp_dx.gif" width="120" height="16" border="0"></TD>
					<TD><img src="img/cornice/AngDxUp_dx.gif" border="0"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/tileSx_dx.gif" width="20" height="55"></TD>
					<TD></TD>
					<TD><img src="img/cornice/tileDx_dx.gif" width="24" height="55"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/AngSxDown_dx.gif"></TD>
					<TD><img src="img/cornice/tileDown_dx.gif" width="120" height="16"></TD>
					<TD><img src="img/cornice/AngDxDown_dx.gif"></TD>
				</TR>
			</TABLE>
			
			<TABLE cellpadding="0" cellspacing="0" border="0" bgcolor="#FFFFFF">
				<TR>
					<TD><IMG src="img/cornice/AngSxUp_dx.gif" border="0"></TD>
					<TD><img src="img/cornice/TileUp_dx.gif" width="120" height="16" border="0"></TD>
					<TD><img src="img/cornice/AngDxUp_dx.gif" border="0"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/tileSx_dx.gif" width="20" height="130"></TD>
					<TD></TD>
					<TD><img src="img/cornice/tileDx_dx.gif" width="24" height="130"></TD>
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
							<A HREF="home?mese=<%= month-1 %>&anno=<%= year %>"><img src="img/indietro_on.gif" border="0" width="11px" title="Mese precedente"></a>						</TD>
						<TD colspan="5" align="center" style="padding-left:0px; padding-right:0px;padding-bottom:5px  ">
							<FONT class="calend_t"><B><%= month_str + "  " + year %></B></FONT>						</TD>
						<TD align="right" style="padding-left:0px; padding-right:0px;padding-bottom:5px ">
							<A HREF="home?mese=<%= month+1 %>&anno=<%= year %>"><img src="img/avanti_on.gif" border="0" width="11px" title="Mese successivo"></a>						</TD>
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
								//C'Ë un evento OGGI??
								if(ok == -1) { %>
									<TD  bgcolor="#000099" align="center"><span onMouseOver="toolTip('Oggi e\' <%= giorni[i] + " " + d + " " + month_str + " " + year %>')" onMouseOut="toolTip()"><FONT class="calend_w"><B><%= d %></B></FONT></span></TD>
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
								//C'Ë un evento OGGI??
								if(ok == -1) { %>
									<TD  bgcolor="#000099" align="center"><span onMouseOver="toolTip('Oggi e\' <%= giorni[i] + " " + d + " " + month_str + " " + year %>')" onMouseOut="toolTip()"><FONT class="calend_w"><B><%= d %></B></FONT></span></TD>
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
			<div id="menu_sx_content_2">
				<TABLE width="90" align="center" style="padding-left:0px " bgcolor="#FFFFFF">
					<FORM ACTION="home" METHOD="POST" name="newsletter" onSubmit="return isValid()">
					<TR>
						<TD colspan="2"><h3><b>Newsletter</b></h3></TD>
					</TR>
					<TR>
						<TD colspan="2" style="padding-right:5px "><input name="email" type="text" size="18" class="form" value="Inserisci e-mail qui" onClick="resetF()" onMouseOver="toolTip('Isciviti alla newsletter della HOPE<BR> per esser sempre aggiornato su <BR>Iniziative e News dell associazione')" onMouseOut="toolTip()"></td>
					</tr>
					<TR></TR>
					<TR>
						<td></td>
						<TD align="right" style="padding-right:5px "><INPUT TYPE="submit" VALUE ="Iscriviti" class="form_button"></TD>
						<INPUT TYPE="hidden" NAME="action" VALUE="INSERT"></INPUT>
						<INPUT TYPE="hidden" NAME="what" VALUE="NEWSLETTER"></INPUT>
				  </FORM>
					</TR>
				</TABLE>
			</div>
			<div id="menu_sx_content_3">
				<TABLE width="110" align="center" bgcolor="#FFFFFF">
					<FORM ACTION="home" METHOD="POST">
					<TR height="19px">
						<TD colspan="2" align="left"><h3><b>Area soci</b></h3></TD>
					</TR>
					<TR>
						<TD width="50%"><h4 style="border-bottom-width:0px;">Login</h4></TD>
						<td><input name="login" type="text" size="12" class="form"></td>
					</tr>
					<TR>
						<TD><h4 style="border-bottom-width:0px;">Password</h4></TD>
						<td><input type="password" size="12" class="form"></td>
					</TR>
					<TR>
						<TD align="right"><div class="data_news">Ricordami</div></TD>
						<TD><input type="checkbox"></TD>
					</TR>
					<TR></TR>
					<TR>
						<TD colspan="2" align="right"><INPUT TYPE="submit" VALUE ="Login" class="form_button" disabled></TD>
						<INPUT TYPE="hidden" NAME="action" VALUE="LOGIN"></INPUT>
						<INPUT TYPE="hidden" NAME="next" VALUE="HOME"></INPUT>
				  </FORM>
					</TR>
				</TABLE>
			</div>
			<div id="menu_sx_content_3_prossimamente">
				<img src="img/prossimamente.gif">			</div>
		</div>
		
		<div id="menu_dx">
			<TABLE cellpadding="0" cellspacing="0" border="0" height="100%">
				<TR>
					<TD><IMG src="img/cornice/AngSxUp_dx.gif" border="0"></TD>
					<TD><img src="img/cornice/TileUp_dx.gif" width="90" height="16" border="0"></TD>
					<TD><img src="img/cornice/AngDxUp_dx.gif" border="0"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/tileSx_dx.gif" width="20" height="160"></TD>
					<TD align="center" bgcolor="#FFFFFF">
						<h3><strong>NEWS</strong></h3>
						<br>
						<font size="2" face="Tahoma">
							<marquee direction="up" scrollAmount=1 width="90" height="120" bgcolor="#FFFFFF" scrolldelay="50">
								<%= high %>
							</marquee>
						</font>					</TD>
					<TD><img src="img/cornice/tileDx_dx.gif" width="24" height="160"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/AngSxDown_dx.gif"></TD>
					<TD><img src="img/cornice/tileDown_dx.gif" width="90" height="16"></TD>
					<TD><img src="img/cornice/AngDxDown_dx.gif"></TD>
				</TR>
				<TR>
					<TD><IMG src="img/cornice/AngSxUp_dx.gif" border="0"></TD>
					<TD><img src="img/cornice/TileUp_dx.gif" width="90" height="16" border="0"></TD>
					<TD><img src="img/cornice/AngDxUp_dx.gif" border="0"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/tileSx_dx.gif" width="20" height="20"></TD>
					<TD align="center" bgcolor="#FFFFFF">
						<a href="home?action=SHOW&what=cinquexmille">
							<img src="img/5xmille_icon.gif" alt="" border="0"/>
						</a>
					</TD>
					<TD><img src="img/cornice/tileDx_dx.gif" width="24" height="20"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/AngSxDown_dx.gif"></TD>
					<TD><img src="img/cornice/tileDown_dx.gif" width="90" height="16"></TD>
					<TD><img src="img/cornice/AngDxDown_dx.gif"></TD>
				</TR>
				<TR>
					<TD colspan="3" height="100%" style="padding-left:18px; padding-top:115px;vertical-align:bottom;">
					<br/>
						<!-- Inizio Codice Shinystat -->
						<script type="text/javascript" language="JavaScript" SRC="http://codice.shinystat.com/cgi-bin/getcod.cgi?USER=hopeonlus"></script>
						<noscript>
							<A HREF="http://www.shinystat.com" target="_top">
							<IMG SRC="http://www.shinystat.com/cgi-bin/shinystat.cgi?USER=hopeonlus" ALT="Free web counters" BORDER="0"></A>
						</noscript>
						<!-- Fine Codice Shinystat -->					</TD>
				</TR>
			</TABLE>
		</div>
		<div id="testo">
			<TABLE cellpadding="0" cellspacing="0" border="0" bgcolor="#FFFFFF" align="center">
				<TR>
					<TD><IMG src="img/cornice/AngSxUp_dx.gif" border="0"></TD>
					<TD><img src="img/cornice/TileUp_dx.gif" width="388" height="16" border="0"></TD>
					<TD><img src="img/cornice/AngDxUp_dx.gif" border="0"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/tileSx_dx.gif" width="20" height="190"></TD>
					<TD>
					
						<table width="100%">
							<TR>
								<TD align="center">
								<h4 align="left">5 Maggio 2011</h4>
								<h1 style="color:#990000">
									<font color="blue">Scuola Lar Joana Angelica<br/>Brasile<br/></font>							
								</h1>
								<h3>
								<font color="green">Incontro con
									<b>Jussara Rocha Dos Santos</b><br/>
									referente dell'associazione Project for People in Brasile</font><br/>
								</h3>
								<br/>
								<div align="center">
									<font color="red">Venerdi' 13 Maggio<br/>
									ore 20:45<br/>
									Asilo Vedani, Angera</font>
								</div>
								</h2>
								</TD>
							</TR>
						</table>					
					</TD>
					<TD><img src="img/cornice/tileDx_dx.gif" width="24" height="190"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/AngSxDown_dx.gif"></TD>
					<TD><img src="img/cornice/tileDown_dx.gif" width="388" height="16"></TD>
					<TD><img src="img/cornice/AngDxDown_dx.gif"></TD>
				</TR>
			</TABLE>
			
			<TABLE cellpadding="0" cellspacing="0" border="0" bgcolor="#FFFFFF" align="center">
				<TR>
					<TD><IMG src="img/cornice/AngSxUp_dx.gif" border="0"></TD>
					<TD><img src="img/cornice/TileUp_dx.gif" width="388" height="16" border="0"></TD>
					<TD><img src="img/cornice/AngDxUp_dx.gif" border="0"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/tileSx_dx.gif" width="20" height="158"></TD>
					<TD>
					
						<table width="100%">
							<TR>
								<TD align="center">
								<h4 align="left">5 Maggio 2011</h4>
								<h1 style="color:#990000">
									Dona il tuo <b>5 x MILLE</b> alla H.O.P.E!
								</h1>
								<h3>
									<br/>
									Codice Fiscale:
								</h3>
								<h2>
								<b>92013500126</b>
								<br/><br/>
								<div align="center"><a href="http://www.hopeonlus.it/home?action=SHOW&what=cinquexmille">MAGGIORI INFORMAZIONI</a></div>
								</h2>
								</TD>
							</TR>
						</table>					
					</TD>
					<TD><img src="img/cornice/tileDx_dx.gif" width="24" height="158"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/AngSxDown_dx.gif"></TD>
					<TD><img src="img/cornice/tileDown_dx.gif" width="388" height="16"></TD>
					<TD><img src="img/cornice/AngDxDown_dx.gif"></TD>
				</TR>
			</TABLE>
			
			<TABLE cellpadding="0" cellspacing="0" border="0" bgcolor="#FFFFFF" align="center">
				<TR>
					<TD><IMG src="img/cornice/AngSxUp_dx.gif" border="0"></TD>
					<TD><img src="img/cornice/TileUp_dx.gif" width="388" height="16" border="0"></TD>
					<TD><img src="img/cornice/AngDxUp_dx.gif" border="0"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/tileSx_dx.gif" width="20" height="130"></TD>
					<TD>
					
						<table width="100%">
							<TR>
								<TD align="center">
								<h4 align="left">29 Maggio 2010</h4>
								<h1 style="color:#990000">
									<font color="green">Aggiornamenti</font> <font color="yellow">dal</font> <font color="blue">Brasile</font><br/>
								</h1>
								<h3>
								On-line le immagini della visita del Presidente al centro Lar Joana Angelica di Salvador de Bahia.
								</h3>
								<div align="center">
									<a style="color:red" href="http://www.hopeonlus.it/news?action=SHOW&what=NEWS&id=30&x=PHOTOGALLERY">guarda le foto</a>
								</div>
								</h2>
								</TD>
							</TR>
						</table>					
					</TD>
					<TD><img src="img/cornice/tileDx_dx.gif" width="24" height="130"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/AngSxDown_dx.gif"></TD>
					<TD><img src="img/cornice/tileDown_dx.gif" width="388" height="16"></TD>
					<TD><img src="img/cornice/AngDxDown_dx.gif"></TD>
				</TR>
			</TABLE>
			<TABLE cellpadding="0" cellspacing="0" border="0" bgcolor="#FFFFFF" align="center">
				<TR>
					<TD><IMG src="img/cornice/AngSxUp_dx.gif" border="0"></TD>
					<TD><img src="img/cornice/TileUp_dx.gif" width="388" height="16" border="0"></TD>
					<TD><img src="img/cornice/AngDxUp_dx.gif" border="0"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/tileSx_dx.gif" width="20" height="130"></TD>
					<TD>
					
						<table width="100%">
							<TR>
								<TD align="center">
								<h4 align="left">29 Maggio 2010</h4>
								<h1 style="color:#990000">
									<font color="green">Aggiornamenti</font> <font color="yellow">dall'</font><font color="red">Etiopia</font><br/>
								</h1>
								<h3>
								Inaugurato il centro per la cura di bambini malnutriti presso l'ospedale St. Luke di Wolisso, Giorgio Gadiva era la'.
								</h3>
								<div align="center">
									<a style="color:red" href="http://www.hopeonlus.it/news?action=SHOW&what=NEWS&id=31&x=PHOTOGALLERY">guarda le foto .. .</a>
								</div>
								</h2>
								</TD>
							</TR>
						</table>					
					</TD>
					<TD><img src="img/cornice/tileDx_dx.gif" width="24" height="130"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/AngSxDown_dx.gif"></TD>
					<TD><img src="img/cornice/tileDown_dx.gif" width="388" height="16"></TD>
					<TD><img src="img/cornice/AngDxDown_dx.gif"></TD>
				</TR>
			</TABLE>
			<!--<TABLE cellpadding="0" cellspacing="0" border="0" bgcolor="#FFFFFF" align="center">
				<TR>
					<TD><IMG src="img/cornice/AngSxUp_dx.gif" border="0"></TD>
					<TD><img src="img/cornice/TileUp_dx.gif" width="388" height="16" border="0"></TD>
					<TD><img src="img/cornice/AngDxUp_dx.gif" border="0"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/tileSx_dx.gif" width="20" height="130"></TD>
					<TD>
					
						<table width="100%">
							<TR>
								<TD align="center">
								<h4 align="left">15 Ottobre 2009</h4>
								<h1 style="color:#990000">
									Aggiornamenti dall'Etiopia...<br/>
								</h1>
								<h2>
								Procede la costruzione del Centro per la riabilitazione di bambini malnutriti!
								</h2>
								<div align="center"><a href="http://www.hopeonlus.it/news?action=SHOW&what=NEWS&id=29&x=PHOTOGALLERY">Guarda le immagini</a></div>
								</h2>
								</TD>
							</TR>
						</table>					
					</TD>
					<TD><img src="img/cornice/tileDx_dx.gif" width="24" height="130"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/AngSxDown_dx.gif"></TD>
					<TD><img src="img/cornice/tileDown_dx.gif" width="388" height="16"></TD>
					<TD><img src="img/cornice/AngDxDown_dx.gif"></TD>
				</TR>
			</TABLE>-->
			<TABLE cellpadding="0" cellspacing="0" border="0" bgcolor="#FFFFFF" align="left">
				<TR>
					<TD><IMG src="img/cornice/AngSxUp_dx.gif" border="0"></TD>
					<TD><img src="img/cornice/TileUp_dx.gif" width="170" height="16" border="0"></TD>
					<TD><img src="img/cornice/AngDxUp_dx.gif" border="0"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/tileSx_dx.gif" width="20" height="175"></TD>
					<TD>
					
						<table width="100%">
							<TR>
								<TD align="center">
								<h4 align="left">Progetto</h4>
								<h3>
								<a href="http://www.hopeonlus.it/progetti?action=SHOW&what=PROGETTO&id=9">
								Lar Joana Angelica<br/>Brasile<br/>
								<img src="http://www.hopeonlus.it/img/news/brasile2006/brasil_2006_3.jpg" alt="" width="130" border="0" style="padding-top:7px;"/>
								</a>
								</h3>
								</TD>
							</TR>
						</table>					
					</TD>
					<TD><img src="img/cornice/tileDx_dx.gif" width="24" height="175"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/AngSxDown_dx.gif"></TD>
					<TD><img src="img/cornice/tileDown_dx.gif" width="170" height="16"></TD>
					<TD><img src="img/cornice/AngDxDown_dx.gif"></TD>
				</TR>
			</TABLE>
			<TABLE cellpadding="0" cellspacing="0" border="0" bgcolor="#FFFFFF" align="center">
				<TR>
					<TD><IMG src="img/cornice/AngSxUp_dx.gif" border="0"></TD>
					<TD><img src="img/cornice/TileUp_dx.gif" width="170" height="16" border="0"></TD>
					<TD><img src="img/cornice/AngDxUp_dx.gif" border="0"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/tileSx_dx.gif" width="20" height="175"></TD>
					<TD>
					
						<table width="100%">
							<TR>
								<TD align="center">
								<h4 align="left">Progetto</h4>
								<h3>
								<a href="http://www.hopeonlus.it/progetti?action=SHOW&what=PROGETTO&id=8">
								St. Luke Hospital<br/>Etiopia<br/>
								<img src="http://www.hopeonlus.it/img/news/etiopia2006/etiopia_2006_24.jpg" alt="" width="130" border="0" style="padding-top:7px;"/>
								</a>
								</h3>
								</TD>
							</TR>
						</table>					
					</TD>
					<TD><img src="img/cornice/tileDx_dx.gif" width="24" height="175"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/AngSxDown_dx.gif"></TD>
					<TD><img src="img/cornice/tileDown_dx.gif" width="170" height="16"></TD>
					<TD><img src="img/cornice/AngDxDown_dx.gif"></TD>
				</TR>
			</TABLE>
			
			<TABLE cellpadding="0" cellspacing="0" border="0" bgcolor="#FFFFFF" align="center">
				<TR>
					<TD><IMG src="img/cornice/AngSxUp_dx.gif" border="0"></TD>
					<TD><img src="img/cornice/TileUp_dx.gif" width="388" height="16" border="0"></TD>
					<TD><img src="img/cornice/AngDxUp_dx.gif" border="0"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/tileSx_dx.gif" width="20" height="60"></TD>
					<TD>
						<font class="progetto" style="color:#003300">
						<div align="center">
						Vuoi diventare nuovo Socio?<br/>
						</div>
						<span style="font-weight:normal">
							Scarica il <a href="download/modulo_iscrizione.pdf">modulo di iscrizione</a>!<br/>
							Per qualunque informazione non esitare a contattarci all'indirizzo <a href="mailto:info@hopeonlus.it">info@hopeonlus.it</a>
						</span>
						</font>
					</TD>
					<TD><img src="img/cornice/tileDx_dx.gif" width="24" height="60"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/AngSxDown_dx.gif"></TD>
					<TD><img src="img/cornice/tileDown_dx.gif" width="388" height="16"></TD>
					<TD><img src="img/cornice/AngDxDown_dx.gif"></TD>
				</TR>
			</TABLE>
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
					<a href="home?action=SHOW&what=LINK">Link</a>				</div>
			</div>
	  </div>
	</div>
		
	<map name="mainIMG_map">
		<area shape="rect" alt="" coords="38,20,118,137">
	</map>
	<!-- script per google analytics -->
	<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
	</script>
	<script type="text/javascript">
		_uacct = "UA-846658-1";
		urchinTracker();
	</script>
	
	
	
	
	<div id="modalBox" class="2beCurved" style="background-color:#FFFFFF; text-align: center;">
		<table cellpadding="0" cellspacing="0" border="0" align="center">
			<tr>
				<td>
					<img src="img/close.gif" title="" align="right" height="20px" onClick="hideLightboxWrap();" onMouseOver="style.cursor='pointer'"/>
				</td>
			</tr>
			<tr>
				<td>
					<!-- <img src="img/5xmille_avviso_small.jpg" alt="" title=""/> -->
					<img src="img/vendita_natale_2010.jpg" alt="" title="" />
				</td>
			</tr>
		</table>
		<!--<a href="#" onClick="hideLightboxWrap();" style="color:#990000; text-decoration:none;">Chiudi la finestra</a>-->
	</div>
	
	<script language="JavaScript">
	
		//inizializzo box
		//initLightbox('modalBox');
		
		//arrotondo angoli
		settings = {
			  tl: { radius: 20 },
			  tr: { radius: 20 },
			  bl: { radius: 20 },
			  br: { radius: 20 },
			  antiAlias: true,
			  autoPad: true
		  }
	
		  /*
		  Usage:
	
		  newCornersObj = new curvyCorners(settingsObj, classNameStr);
		  newCornersObj = new curvyCorners(settingsObj, divObj1[, divObj2[, divObj3[, . . . [, divObjN]]]]);
		  */
		  var myBoxObject = new curvyCorners(settings, "2beCurved");
		  myBoxObject.applyCornersToAll();
		  
		  //imposto chiusura auto
		  //var timeoutID = setTimeout('hideLightbox(\'modalBox\')', 5000);
		  
		  function hideLightboxWrap() {
			//clearTimeout(timeoutID);
			hideLightbox('modalBox'); 
			return false;
		  }
		  
	</script>

	
</BODY>

</HTML>