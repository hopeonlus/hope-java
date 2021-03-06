<%@ page language="java" import="java.util.*" %>
<%@ page import="mapping.*" %>

<%
	////////////
	/// DATI ///
	////////////
	String isok = (String) request.getAttribute("isok");
	String email = (String) request.getAttribute("email");
	
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
	String[] giorni = {"", "Domenica", "Luned�", "Marted�", "Mercoled�", "Gioved�", "Venerd�", "Sabato"};
	String month_str = mesi[month];%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<META NAME="DESCRIPTION" CONTENT="Sito della ONLUS HOPE.">
<META NAME="KEYWORDS" CONTENT="hope,onlus,angera,adozioni,adozioni a distanza,volontariato,terzo mondo,commercio equo,lago maggiore">
<META NAME="AUTHOR" CONTENT="Stefano Zaninetta">

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

function resetF_menu() {

  with (document.newsletter_menu)
    {
		if(email.value == "Inserisci qui la tua mail")
			email.value="";
	}
}

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
		<!-- <script type="text/javascript" src="http://www.makepovertyhistory.org/whiteband_small_right.js"> </script><noscript><a href="http://www.makepovertyhistory.org/"> http://www.makepovertyhistory.org</a></noscript> // -->
		<div id="banner">
			<img src="./img/main_01.jpg" usemap="#mainIMG_Map" border="0">
		</div>
		
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
							<A HREF="home?mese=<%= month-1 %>&anno=<%= year %>"><img src="img/indietro_on.gif" border="0" width="11px" title="Mese precedente"></a>
						</TD>
						<TD colspan="5" align="center" style="padding-left:0px; padding-right:0px;padding-bottom:5px  ">
							<FONT class="calend_t"><B><%= month_str + "  " + year %></B></FONT>
						</TD>
						<TD align="right" style="padding-left:0px; padding-right:0px;padding-bottom:5px ">
							<A HREF="home?mese=<%= month+1 %>&anno=<%= year %>"><img src="img/avanti_on.gif" border="0" width="11px" title="Mese successivo"></a>
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
								//C'� un evento OGGI??
								if(ok == -1) { %>
									<TD  bgcolor="#000099" align="center"><span onMouseOver="toolTip('Oggi � <%= giorni[i] + " " + d + " " + month_str + " " + year %>')" onMouseOut="toolTip()"><FONT class="calend_w"><B><%= d %></B></FONT></span></TD>
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
								//C'� un evento OGGI??
								if(ok == -1) { %>
									<TD  bgcolor="#000099" align="center"><span onMouseOver="toolTip('Oggi � <%= giorni[i] + " " + d + " " + month_str + " " + year %>')" onMouseOut="toolTip()"><FONT class="calend_w"><B><%= d %></B></FONT></span></TD>
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
				<TABLE width="110" align="center" style="padding-left:1px ">
					<FORM ACTION="home" METHOD="POST" name="newsletter_menu" onSubmit="return isValid()">
					<TR height="19px">
						<TD colspan="2"><div class="content_news" align="left" style="color:#0000CC "><b>Newsletter</b></div></TD>
					</TR>
					<TR>
						<TD colspan="2"><input name="email" type="text" size="20" class="form" value="Inserisci qui la tua mail" onClick="resetF_menu()"></td>
					</tr>
					<TR></TR>
					<TR>
						<td></td>
						<TD align="right"><INPUT TYPE="submit" VALUE ="Iscriviti" class="form_button"></TD>
						<INPUT TYPE="hidden" NAME="action" VALUE="INSERT">
						<INPUT TYPE="hidden" NAME="what" VALUE="NEWSLETTER">
				  </FORM>
					</TR>
				</TABLE>
			</div>
			<div id="menu_sx_content_3">
				<TABLE width="110" align="center">
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
				<img src="img/prossimamente.gif">
			</div>
		</div>
		
		<div id="menu_dx">
			<TABLE cellpadding="0" cellspacing="0" border="0">
				<TR>
					<TD><IMG src="img/cornice/AngSxUp_dx.gif" border="0"></TD>
					<TD><img src="img/cornice/TileUp_dx.gif" width="100" height="16" border="0"></TD>
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
						</font>
					</TD>
					<TD><img src="img/cornice/tileDx_dx.gif" width="24" height="140"></TD>
				</TR>
				<TR>
					<TD><img src="img/cornice/AngSxDown_dx.gif"></TD>
					<TD><img src="img/cornice/tileDown_dx.gif" width="100" height="16"></TD>
					<TD><img src="img/cornice/AngDxDown_dx.gif"></TD>
				</TR>
			</TABLE>
		</div>
		
		<div id="testo">
			<div style="padding-top:3px; color:#000099;">
				<FONT FACE="VERDANA, ARIAL" SIZE="1" COLOR="#000099"> 
				<a href="home">H.O.P.E.</a> > 
				Mailing List
			</div>
			
			<% if(isok == null) {	%>
					<table width="100%" align="center" style="padding-top:14px ">
						<tr>
							<td bgcolor="#EDECFF"><p class="subtitle_news" align="center"><B style="text-transform:uppercase ">Iscriviti alla Newsletter...</b></td>
						</tr>
						<tr>
							<td><p class="subtitle_news" align="center"><BR>...per esser sempre aggiornato su Novit� ed Iniziative dell'associazione!</p></td>
						</tr>
						<tr height="15px"></tr>
						<tr>
							<td align="center">
								<FORM ACTION="home" METHOD="POST" name="newsletter" onSubmit="return isValid()">
									<font class="subtitle_news" align="center"><font color="#FF0000">E-mail : </font></font>
									<input name="email" type="text" size="20" class="form" value="Inserisci qui la tua mail" onClick="resetF()">
							</td>
						</tr>
						<tr></tr>
						<tr></tr>
						<tr>
							<td align="center">
									<INPUT TYPE="submit" VALUE ="Iscriviti" class="form_button">
									<INPUT TYPE="hidden" NAME="action" VALUE="INSERT"></INPUT>
									<INPUT TYPE="hidden" NAME="what" VALUE="NEWSLETTER"></INPUT>
							 	</FORM>
							</td>
						</tr>

						<tr>
							<td><p align="center" class="subtitle_news"><a href="home"><BR>< TORNA ALLA HOME PAGE ></a></p></td>
						</tr>
					</table>
			<% } else { 
					if (isok.equals("1")) { %>
						<table width="100%" align="center" style="padding-top:14px ">
							<tr>
								<td bgcolor="#EDECFF"><p class="subtitle_news" align="center"><B style="text-transform:uppercase ">Registrazione avvenuta con successo</b></td>
							</tr>
							<tr>
								<td><p class="subtitle_news" align="center"><font color="#FF0000"><BR>e-mail : <b><%= email %></b></font></p></td>
							</tr>
							<tr>
								<td><p class="subtitle_news" align="center"><BR>Sarai in questo modo tenuto aggiornato su Novit� ed Iniziative dell'associazione!</p></td>
							</tr>
							<tr>
								<td><p align="center" class="subtitle_news"><a href="home"><BR>< TORNA ALLA HOME PAGE ></a></p></td>
							</tr>
						</table>
					<% } else { %>
						<table width="100%" align="center" style="padding-top:14px ">
							<tr>
								<td bgcolor="#FFE6E6"><p class="subtitle_news" align="center"><B style="text-transform:uppercase ; color:#000000" >Errore in fase di registrazione</b></td>
							</tr>
							<tr>
								<td><p class="subtitle_news" align="center"><font color="#FF0000"><BR>L'e-mail <b><%= email %></b> probabilmente appartiene gi� alla mailing-list.</font></p></td>
							</tr>
							<tr>
								<td><p class="subtitle_news" align="center"><BR><a href="home?action=INSERT&what=NEWSLETTER&email=<%= email %>">> Riprova <</a></p></td>
							</tr>
							<tr>
								<td><p align="center" class="subtitle_news"><a href="home"><BR>< TORNA ALLA HOME PAGE ></a></p></td>
							</tr>
						</table>
					<% } 
					}	%>
		</div>
			<div id="bottom">
				<div class="bottom_text" style="padding-top:5px ">
					<a href="home">Home</a>
					&nbsp&nbsp;|&nbsp&nbsp;
					<a href="home?action=SHOW&what=CHISIAMO">Chi siamo?</a>
					&nbsp&nbsp;|&nbsp&nbsp;
					Newsletter
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
		<area shape="rect" alt="" coords="38,20,118,137">
	</map>
	
</BODY>

</HTML>