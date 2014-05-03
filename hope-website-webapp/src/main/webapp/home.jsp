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
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<META NAME="DESCRIPTION" CONTENT="Sito della ONLUS HOPE di Angera.">
<META NAME="KEYWORDS" CONTENT="angera,hope,onlus,commercio equo,adozioni,adozioni a distanza,volontariato,terzo mondo,lago maggiore">
<META NAME="AUTHOR" CONTENT="Stefano Zaninetta">
<link href='http://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css'>
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
<body onLoad="javascript:window.open('http://www.hopeonlus.it/img/5xmille_avviso_small.jpg', 'remote', 'width=380,height=380,toolbar=no,scrollbars=no,resizable=no,menubar=no')">
	<div id="container">
		<!-- <script type="text/javascript" src="http://www.makepovertyhistory.org/whiteband_small_right.js"> </script><noscript><a href="http://www.makepovertyhistory.org/"> http://www.makepovertyhistory.org</a></noscript> // -->
		<div id="banner">
			<img src="./img/main_01_noround.jpg" usemap="#mainIMG_Map" border="0">		</div>
		
		<div id="menunew">
     		 <ul> 
				<li><a id="sel" href="home">HOME</a></li> 
				<li><a href="home?action=SHOW&what=CHISIAMO" onMouseOver="this.id='sel'" onMouseOut="this.id='1'">CHi SiAMO</a></li> 
				<li><a href="news" onMouseOver="this.id='sel'" onMouseOut="this.id='2'">NEWS</a></li> 
				<li><a href="progetti" onMouseOver="this.id='sel'" onMouseOut="this.id='3'">PROGETTi</a></li> 	
				<li><a href="home?action=SHOW&what=AIUTACI" onMouseOver="this.id='sel'" onMouseOut="this.id='5'">SOSTIENICI</a></li>
    		</ul> 
		</div>		
		
		<div id="content">
		<div id="menu_sx_home">
			
			<div id="menu_sx_content_1_home" style="vertical-align:bottom " class="box">
				<%@include file="calendar.jsp" %>
			</div>
			<div class="box">
				<h2>Notiziari</h2>
				<ul>
					<li><a href="http://hopeonlus.it/download/notiziari/notiziario_natale_2012.pdf">Natale 2012</a></li>
					<li><a href="http://hopeonlus.it/download/notiziari/notiziario_gennaio_2012.pdf">Gennaio 2012</a></li>
				</ul>
			</div>
			<div id="menu_sx_content_2_home" class="box">
				<TABLE  align="center" style="padding-left:0px " bgcolor="#FFFFFF">
					<TR>
						<TD colspan="2"><h3><b>Newsletter</b></h3></TD>
					</TR>
				<tr><td>
				<form action="http://newsletter.hopeonlus.it/index.php?page=mail&" name="subscribe" method="post">
				  <table width="100%" border="0" align="center" cellpadding="5" cellspacing="0">
				    <tr>
				      <td width="94%"><strong>
				        <input name="email" type="text" class="box" id="email2" value="Inserisci e-mail qui" size="20" onfocus="this.value='';" >
				        <input name="group" type="hidden" id="group[]" value="2">
				        </strong></td>
				    </tr>
				    <tr>
				      <td valign="middle"> <div align="center">
				          <input name="subscribe" type="hidden" id="subscribe" value="true">
				          <input name="Submit2" type="submit" class="form_button" value="Iscriviti">
				        </div></td>
				    </tr>
				  </table>
				</form>
				</td></tr>
					
				</TABLE>
			</div>
				<!-- Inizio Codice Shinystat -->
						<script type="text/javascript" language="JavaScript" SRC="http://codice.shinystat.com/cgi-bin/getcod.cgi?USER=hopeonlus"></script>
						<noscript>
							<A HREF="http://www.shinystat.com" target="_top">
							<IMG SRC="http://www.shinystat.com/cgi-bin/shinystat.cgi?USER=hopeonlus" ALT="Free web counters" BORDER="0"></A>
						</noscript>
						<!-- Fine Codice Shinystat -->
		</div>
		
		
		<div id="testo_home">
			<div class="box" align="center">
				<h4 align="left">8 Gennaio 2013</h4>
				<h1 style="color:#990000">
				Ultime Notizie dal Mali...
				</h1>
				<h3>
				<img src="./img/progetti/mali/mali_cover_1.jpg" alt="" width="150px" />
				<img src="./img/progetti/mali/mali_cover_2.jpg" alt="" width="150px" />
				<img src="./img/progetti/mali/mali_cover_3.png" alt="" height="112px" />

				<br/>
				<br/>
				Pubblichiamo le prime immagini inviateci dalla scuola di Severe', Mali, che abbiamo aiutato lo scorso anno fornendo uno stock di materiale didattico e un aiuto economico per sostenere interventi di manutenzione dell'edificio.
				<br/><br/>
				<a href="http://www.hopeonlus.it/progetti?action=SHOW&what=PROGETTO&id=11&x=PHOTOGALLERY"><img src="img/link.png" width="12"/> Vai alle foto</a>
				<br/>
				<a href="http://www.hopeonlus.it/progetti?action=SHOW&what=PROGETTO&id=11"><img src="img/link.png" width="12"/> Scheda del progetto</a>
				</h3>
			</div>
			<!--
				<div class="box">
					<h4 align="left">24 e 25 Novembre 2012</h4>
						<img src="img/loc_natale_2012.jpg" width="500"/>
				</div>
				<br/>
				<div class="box">
					<h4 align="left">17 Novembre 2012</h4>
									<h1 style="color:#990000">
										Disponibile on-line il nuovo notiziario!
									</h1><br/>
									<div align="center">
										<a href="download/notiziari/notiziario_gennaio_2012.pdf">
											<img src="img/pdf.gif"/> Scarica
										</a>
									</div>
				</div>
				
				<br/>
				<div class="box">
					<h4 align="left">13 Marzo 2012</h4>
									<h1 style="color:#990000">
										Assemblea Ordinaria dei Soci
									</h1><br/>
									<h3>
										<b>Sabato 31 marzo</b> alle <b>ore 16,15</b>
										<br/><br/>presso la sala riunioni del Centro Anziani in Angera, piazza Parrocchiale
									</h3>
				</div>
				<br/>
				<div class="box">
					<h4 align="left">14 Gennaio 2012</h4>
									<h1 style="color:#990000">
										Disponibile on-line il primo notiziario del 2012!
									</h1><br/>
									<div align="center"><a href="news?action=SHOW&what=NEWS&id=33">
									<img src="img/link.png" width="12"/> Leggi</a> oppure <a href="download/notiziari/notiziario_gennaio_2012.pdf">
									<img src="img/pdf.gif"/> Scarica</a></div>
				</div>
				<br/>
			-->
				<div class="box" >
					<h4 align="left">05 Gennaio 2012</h4>
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
									<div align="center"><a href="http://www.hopeonlus.it/home?action=SHOW&what=cinquexmille"><img src="img/link.png" width="12"/> MAGGIORI INFORMAZIONI</a></div>
									</h2>
				</div>
				<div class="box">
					<h4 align="left">29 Maggio 2010</h4>
									<h1 style="color:#990000">
										<font color="green">Aggiornamenti</font> <font color="yellow">dal</font> <font color="blue">Brasile</font><br/>
									</h1>
									<h3>
									On-line le immagini della visita del Presidente al centro Lar Joana Angelica di Salvador de Bahia.
									</h3><br/>
									<div align="center">
										<a style="color:red" href="http://www.hopeonlus.it/news?action=SHOW&what=NEWS&id=30&x=PHOTOGALLERY"><img src="img/link.png" width="12"/> guarda le foto</a>
									</div>
									</h2>
				</div>
				<div class="box">
					<h4 align="left">29 Maggio 2010</h4>
									<h1 style="color:#990000">
										<font color="green">Aggiornamenti</font> <font color="yellow">dall'</font><font color="red">Etiopia</font><br/>
									</h1>
									<h3>
									Inaugurato il centro per la cura di bambini malnutriti presso l'ospedale St. Luke di Wolisso, Giorgio Gadiva era la'.
									</h3><br/>
									<div align="center">
										<a style="color:red" href="http://www.hopeonlus.it/news?action=SHOW&what=NEWS&id=31&x=PHOTOGALLERY"><img src="img/link.png" width="12"/> guarda le foto .. .</a>
									</div>
									</h2>

				</div>
			
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

				<div class="box-mini-left">
					<h4 align="left">Progetto</h4>
					<h3 align="center">
					<a href="http://www.hopeonlus.it/progetti?action=SHOW&what=PROGETTO&id=9">
						Lar Joana Angelica<br/>Brasile<br/>
						<img src="img/news/brasile2006/brasil_2006_3.jpg" alt="" width="130" border="0" style="padding-top:7px;"/>
					</a>
					</h3>
				</div>

				<div class="box-mini-right">
					<h4 align="left">Progetto</h4>
					<h3 align="center">
					<a href="http://www.hopeonlus.it/progetti?action=SHOW&what=PROGETTO&id=8">
					St. Luke Hospital<br/>Etiopia<br/>
					<img src="img/news/etiopia2006/etiopia_2006_24.jpg" alt="" width="130" border="0" style="padding-top:7px;"/>
					</a>
					</h3>
				</div>
				<div class="box">
					<font class="progetto" style="color:#003300">
					<div align="center">
					Vuoi diventare nuovo Socio?<br/>
					</div>
					<span style="font-weight:normal">
						Scarica il <a href="download/modulo_iscrizione.pdf">modulo di iscrizione</a>!<br/>
						Per qualunque informazione non esitare a contattarci all'indirizzo <a href="mailto:info@hopeonlus.it">info@hopeonlus.it</a>
					</span>
					</font>
				</div>
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