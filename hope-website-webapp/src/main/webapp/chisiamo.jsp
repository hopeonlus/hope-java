<%@ page language="java" import="java.util.*" %>
<%@ page import="mapping.*" %>

<%
	////////////
	/// DATI ///
	////////////

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

function ShowAndHide(id1,id2){
if(document.getElementById){
    el1=document.getElementById(id1);
    el2=document.getElementById(id2);
    if(el1.style.display=="none"){
        el1.style.display="block";
        el2.style.display="none";
        }
    else{
        el1.style.display="none";
        el2.style.display="block";
        }
    }
}
// -->
</script>

<SCRIPT language="JavaScript" src="tooltip.js"></SCRIPT>

<TITLE>H.O.P.E. ONLUS - Chi Siamo</TITLE>
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
				<li><a id="sel">CHi SiAMO</a></li> 
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
			<div id="menu_sx_content_1" style="vertical-align:bottom ">
				<TABLE border="0" align="center" width="136" bgcolor="#FFFFFF">
					<TR>
						<TD align="left" style="padding-left:0px; padding-right:0px;padding-bottom:5px ">
							<A HREF="home?action=SHOW&what=CHISIAMO&mese=<%= month-1 %>&anno=<%= year %>"><img src="img/indietro_on.gif" border="0" width="11px" title="Mese precedente"></a>
						</TD>
						<TD colspan="5" align="center" style="padding-left:0px; padding-right:0px;padding-bottom:5px  ">
							<FONT class="calend_t"><B><%= month_str + "  " + year %></B></FONT>
						</TD>
						<TD align="right" style="padding-left:0px; padding-right:0px;padding-bottom:5px ">
							<A HREF="home?action=SHOW&what=CHISIAMO&mese=<%= month+1 %>&anno=<%= year %>"><img src="img/avanti_on.gif" border="0" width="11px" title="Mese successivo"></a>
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
			<div id="menu_sx_content_2">
				<TABLE width="110" align="center" style="padding-left:1px ">
					<FORM ACTION="home" METHOD="POST" name="newsletter" onSubmit="return isValid()">
					<TR height="19px">
						<TD colspan="2"><h3><b>Newsletter</b></h3></TD>
					</TR>
					<TR>
						<TD colspan="2"><input name="email" type="text" size="20" class="form" value="Inserisci qui la tua mail" onClick="resetF()" onMouseOver="toolTip('Isciviti alla newsletter della HOPE<BR> per esser sempre aggiornato su <BR>Iniziative e News dell associazione')" onMouseOut="toolTip()"></td>
					</tr>
					<TR></TR>
					<TR>
						<td></td>
						<TD align="right"><INPUT TYPE="submit" VALUE ="Iscriviti" class="form_button"></TD>
						<INPUT TYPE="hidden" NAME="action" VALUE="INSERT"></INPUT>
						<INPUT TYPE="hidden" NAME="what" VALUE="NEWSLETTER"></INPUT>
				  </FORM>
					</TR>
				</TABLE>
			</div>
			<div id="menu_sx_content_3">
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
					<TD><img src="img/cornice/tileDown_dx.gif" width="90" height="16"></TD>
					<TD><img src="img/cornice/AngDxDown_dx.gif"></TD>
				</TR>
			</TABLE>
		</div>
		<div id="testo">
			<div style="padding-top:3px; color:#000099;">
				<FONT FACE="VERDANA, ARIAL" SIZE="1" COLOR="#000099"> 
				<a href="home">H.O.P.E.</a> > 
				Chi siamo
				</FONT>
			</div>
			<BR>
			<div id="chisiamono">
				<h2>
				<a href="#" onClick="ShowAndHide('chisiamosi','chisiamono');return(false)"><img src="img/plus.gif" border="0"></a>
				CHi SiAMO</h2>
			</div>
			<div id="chisiamosi">
				<h2>
					<a href="#" onClick="ShowAndHide('chisiamosi','chisiamono');return(false)">
					<img src="img/meno.gif" border="0">
					</a>
					CHi SiAMO
				</h2>

				<p  style="padding-left:30px; padding-right:25px; text-align:justify ">
				La <b>H.O.P.E.</b> ( <b>H</b>elp <b>O</b>ther <b>P</b>eople <b>E</b>verywere ) è un’ Organizzazione non lucrativa di utilità sociale ( ONLUS ), laica e apartitica, costituita da un gruppo di amici che credono nel rispetto cordiale e nella solidarietà fra i popoli. Si prefigge di favorire la conoscenza reciproca fra comunità appartenenti a diverse culture e costumi sociali, soprattutto nei Paesi in via di sviluppo; di collaborare alla mutua crescita, umana ed economica, attraverso lo scambio di visite, di informazioni, di esperienze; di diffondere nella città di Angera e nei comuni limitrofi la cultura della collaborazione e la conoscenza dei problemi dello sviluppo e della pace fra i popoli.  
					La H.O.P.E. è soggetta a uno Statuto, regolarmente registrato, ed è retta da un Consiglio Direttivo, eletto ogni due anni da tutti gli iscritti.
				</p>
			</div>
			
			<div id="attivitano">
				<h2>
				<a href="#" onClick="ShowAndHide('attivitasi','attivitano');return(false)"><img src="img/plus.gif" border="0"></a>
				ATTiViTA' e MEZZi</h2>
			</div>
			
			<div id="attivitasi">
				<h2>
				<a href="#" onClick="ShowAndHide('attivitasi','attivitano');return(false)"><img src="img/meno.gif" border="0"></a>
				ATTiViTA' e MEZZi</h2>

				<p style="padding-left:30px; padding-right:25px; text-align:justify ">
					Le attività specifiche di H.O.P.E. comprendono le seguenti iniziative:
					<font >
					<ul style="padding-right:30px ">
						<li>Sostenere con finanziamenti e consulenze piccoli progetti atti a rendere più autonome e a migliorare il reddito di comunità in paesi del Terzo Mondo. Lo scopo di questi progetti è di fornire un piccolo capitale e un “ know-how “ sufficiente a rendere in seguito le attività locali capaci di sostenersi senza ulteriori sostegni economici.</li>
						<li>Favorire l’attività di adozioni a distanza per ragazzi/e di quelle comunità, destinate a permettere un’ attività di formazione scolastica adeguata.</li>
						<li>Favorire gli scambi di visite, la corrispondenza, la condivisione di esperienze con le suddette comunità</li>
						<li>Promuovere ad Angera, e nei comuni limitrofi, conferenze, dibattiti ed altre similari iniziative sui temi dello sviluppo sostenibile, della pace, del rispetto per l’ ambiente, e simili.</li>
					</ul>
					Per tali iniziative ci finanziamo:
					</font>
					<font >
					<ul style="padding-right:30px ">
						<li>Con le quote d’ associazione</li>
						<li>Con offerte e donazioni ricevute da privati ed Enti</li>
						<li>Col ricavato di iniziative organizzate in zona, tipo manifestazioni ludiche e culturali, nonché la vendita di prodotti del “ Commercio Equo e Solidale “</li>
					</ul>
					</font>
				</p>
			</div>
			
			<div id="statutono">
				<h2>
				<a href="#" onClick="ShowAndHide('statutosi','statutono');return(false)"><img src="img/plus.gif" border="0"></a>
				STATUTO</h2>
			</div>
			
			<div id="statutosi">
				<h2>
				<a href="#" onClick="ShowAndHide('statutosi','statutono');return(false)"><img src="img/meno.gif" border="0"></a>
				STATUTO</h2>

				<p  style="padding-left:30px; padding-right:25px; text-align:justify ">
					E' possibile scaricare il nostro statuto dal collegamento seguente:
					<font >
					<UL style="padding-right:30px ">
						<li><a href="download/statuto_hope.pdf">Statuto H.O.P.E. ONLUS</a> - (<img src="img/pdf.gif" border="0"> - 39kb)</li>
					</UL>
					<BR>
					</font>
				</p>
			</div>
		</div>
			<div id="bottom">
				<div class="bottom_text" style="padding-top:5px ">
					<a href="home">Home</a>
					&nbsp&nbsp;|&nbsp&nbsp;
					Chi siamo?
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