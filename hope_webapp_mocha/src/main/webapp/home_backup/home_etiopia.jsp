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
	String[] giorni = {"", "Domenica", "LunedÏ", "MartedÏ", "MercoledÏ", "GiovedÏ", "VenerdÏ", "Sabato"};
	String month_str = mesi[month];
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<META NAME="DESCRIPTION" CONTENT="Sito della ONLUS HOPE.">
<META NAME="KEYWORDS" CONTENT="hope,onlus,angera,adozioni,adozioni a distanza,volontariato,terzo mondo,commercio equo,lago maggiore">
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

<TITLE>H.O.P.E. ONLUS - Help Other People Everywhere</TITLE>
<STYLE type="text/css">
	@import url("style1.css");
</STYLE>
</HEAD>

<BODY background="img/back_blu.jpg">
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
				<li><a href="dalmondo" onMouseOver="this.id='sel'" onMouseOut="this.id='5'">DAL MONDO</a></li>
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
					<TD><img src="img/cornice/tileSx_dx.gif" width="20" height="110"></TD>
					<TD></TD>
					<TD><img src="img/cornice/tileDx_dx.gif" width="24" height="110"></TD>
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
									<TD  bgcolor="#000099" align="center"><span onMouseOver="toolTip('Oggi Ë <%= giorni[i] + " " + d + " " + month_str + " " + year %>')" onMouseOut="toolTip()"><FONT class="calend_w"><B><%= d %></B></FONT></span></TD>
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
									<TD  bgcolor="#000099" align="center"><span onMouseOver="toolTip('Oggi Ë <%= giorni[i] + " " + d + " " + month_str + " " + year %>')" onMouseOut="toolTip()"><FONT class="calend_w"><B><%= d %></B></FONT></span></TD>
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
						<TD colspan="2"><div class="content_news" align="left" style="color:#0000CC "><b><a href="">Newsletter</a></b></div></TD>
					</TR>
					<TR>
						<TD colspan="2" style="padding-right:5px "><input name="email" type="text" size="18" class="form" value="Inserisci qui la tua mail" onClick="resetF()" onMouseOver="toolTip('Isciviti alla newsletter della HOPE<BR> per esser sempre aggiornato su <BR>Iniziative e News dell associazione')" onMouseOut="toolTip()"></td>
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
						<TD colspan="2" align="center"><div class="content_news" align="center" style="color:#0000CC "><b>AREA SOCI</b></div></TD>
					</TR>
					<TR>
						<TD width="50%"><div class="content_news">Login</div></TD>
						<td><input name="login" type="text" size="12" class="form"></td>
					</tr>
					<TR>
						<TD><div class="content_news">Pass</div></TD>
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
			<TABLE cellpadding="0" cellspacing="0" border="0">
				<TR>
					<TD><IMG src="img/cornice/AngSxUp_dx.gif" border="0"></TD>
					<TD><img src="img/cornice/TileUp_dx.gif" width="90" height="16" border="0"></TD>
					<TD><img src="img/cornice/AngDxUp_dx.gif" border="0"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/tileSx_dx.gif" width="20" height="140"></TD>
					<TD align="center" bgcolor="#FFFFFF">
						<font class="subtitle_news"><strong>NEWS</strong></font>
						<br>
						<font size="2" face="Tahoma">
							<marquee direction="up" scrollAmount=1 width="90" height="120" bgcolor="#FFFFFF" scrolldelay="50">
								<%= high %>
							</marquee>
						</font>					</TD>
					<TD><img src="img/cornice/tileDx_dx.gif" width="24" height="140"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/AngSxDown_dx.gif"></TD>
					<TD><img src="img/cornice/tileDown_dx.gif" width="90" height="16"></TD>
					<TD><img src="img/cornice/AngDxDown_dx.gif"></TD>
				</TR>
				<TR>
					<TD colspan="3" style="padding-left:18px; padding-top:150px">
					<BR>

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
			<table style="vertical-align:bottom; padding-top:12px; padding-left:10px; " width="100%" cellpadding="0">
				<tr>
					<td align="center" colspan="2">
						<FONT FACE="VERDANA, ARIAL" SIZE="2" COLOR="#990000">
							<B>Benvenuto nel sito dell'associazione H.O.P.E.!</B>
							<BR><BR>
						</FONT>					</td>
				</tr>
			</table>
			<TABLE cellpadding="0" cellspacing="0" border="0" bgcolor="#FFFFFF" align="center">
				<TR>
					<TD><IMG src="img/cornice/AngSxUp_dx.gif" border="0"></TD>
					<TD><img src="img/cornice/TileUp_dx.gif" width="388" height="16" border="0"></TD>
					<TD><img src="img/cornice/AngDxUp_dx.gif" border="0"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/tileSx_dx.gif" width="20" height="240"></TD>
					<TD>
						<table width="100%">
							<TR>
								<TD align="center" valign="top" colspan="2">
									<font  class="progetto_large" face="Courier New, Courier, mono" style="font-style:normal;font-weight: normal; ">
										iN PRiMO PiANO: <b>"Testimonianza da un Ospedale Etiopico"</B>
									</font>
								</TD>
							</TR>
							<TR>
								<TD colspan="2" valign="top" >
									<table align="left" style="padding:5px ">
										<tr>
											<td>
												<!--<img src="/img/logo.jpg" align="left" border="0" height="100px">-->
												<a href="./download/etiopia/loc_etiopia_img_2.jpg">
													<img src="./download/etiopia/loc_etiopia_img_MINI.jpg" align="left" border="0" height="180px">
												</a>
											</td>
										</tr>
									</table>
									<font class="testo"><BR>
									<div align="center">
										Dott. Giorgio Gadiva racconta la sua esperienza nell'ospedale di Wolisso (Etiopia)<br><br>
										<font  class="progetto_large" face="Courier New, Courier, mono" style="font-style:normal;font-weight: normal; ">
											<b>Venerdi' 18 Maggio</b>
										</font>
										<br>
										<br>
										<b>Sala Consiliare del Comune di Angera
										<br>
										Vi aspettiamo...
										<br>
										<br>
										<a href="news?action=SHOW&what=NEWS&id=20" style="font-size:14px">:: news ::</a>
										<br><br>
										<a href="./download/etiopia/loc_etiopia_img_2.jpg" style="font-size:14px">:: locandina ::</a>
										</div>
								</TD>
							</TR>
						</table>
					</TD>
					<TD><img src="img/cornice/tileDx_dx.gif" width="24" height="240"></TD>
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
					<TD><img src="img/cornice/tileSx_dx.gif" width="20" height="60"></TD>
					<TD>
						<table width="100%">
							<TR>
								<td rowspan="2">
									<img src="/img/news/acli/acli_00.jpg" alt="" height="50px"/>
								</td>
								<TD align="center" valign="top" colspan="2">
									<font  class="title_news" face="Courier New, Courier, mono" style="font-style:normal;font-weight: normal; ">
										<a href="news?action=SHOW&what=NEWS&id=19"><b>COSE Di QUESTO UNiCO MONDO!</B></a>
									</font>
								</TD>
							</TR>
							<tr>
								<td align="center">
									<font  class="progetto" face="Courier New, Courier, mono" style="font-style:normal;font-weight: normal; ">
										Incontri di educazione alla Mondialita'
									</font>
								</td>
							</tr>
						</table>					</TD>
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
</BODY>

</HTML>