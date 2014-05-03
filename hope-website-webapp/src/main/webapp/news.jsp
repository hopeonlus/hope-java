<%@ page language="java" import="java.util.*" %>
<%@ page import="mapping.*" %>

<%
	////////////
	/// DATI ///
	////////////
	String x = (String) request.getParameter("x");
	if(x == null)
		x = "NEWS";
		
	String n_imgStr = (String) request.getParameter("n_img");
	if(n_imgStr == null)
		n_imgStr = "0";
	int n_img = Integer.parseInt(n_imgStr);
	
	String totImgStr = (String) request.getAttribute("totImg");
	int totImg = 0;
	if(totImgStr != null)
		totImg = Integer.parseInt(totImgStr);
		
	News news = (News) request.getAttribute("dati");
	List img = (List) request.getAttribute("img");
	String prev = (String) request.getAttribute("prev");
	String next = (String) request.getAttribute("next");
	
	//dati per immagini
	List ListaImg = (List) request.getAttribute("ListaImg");

	String id = news.getId().toString();
	String titolo = news.getTitolo();
	String sottotitolo = news.getSottotitolo();
	String testo = news.getTesto();
	
	Date d1 = news.getData();
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("d MMMMM yyyy", java.util.Locale.ITALY);
	String data_ins = formatter.format(d1);

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
var photos=new Array();
var which=0;

function preloadImages() {
	if (document.images) {
		 
		
		<% /*for(int i = 0; i < totImg; i++)
			{
				out.println("photos[" + i + "]=\"" + ((Immagini) ListaImg.get(i)).getImg() + "\";");
			}
		*/%>
		preloadFlag = true;
	}
}

/*function backward(){
	if (which>0){
		which--;
		document.images.photo.src=photos[which];
		x = Alto(photos[which]);
		if(x)
		{
			document.images.photo.height = "350";
		}
		else
		{
			document.images.photo.width="350";
		}
	}
}

function forward(){
	if (which < photos.length-1){
		which++;
		document.images.photo.src=photos[which];
	}
}
*/

function Alto(x){
	img = new Image();
	img.src = x;
	if(img.height > img.width)
		document.write("<a href=\""+x+"\"><img src=\"" + x + "\" height=\"500\" name=\"photo\" border=\"1\"/></a>");
	else
		document.write("<a href=\""+x+"\"><img src=\"" + x + "\" width=\"550\" name=\"photo\" border=\"1\"/></a>");
}

function AltoGallery(x){
	img = new Image();
	img.src = x;
	if(img.height > img.width)
		document.write("<img src=\"" + x + "\" height=\"170\" border=\"1\">");
	else
		document.write("<img src=\"" + x + "\" width=\"170\" border=\"1\">");
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
		<!--<script type="text/javascript" src="http://www.makepovertyhistory.org/whiteband_small_right.js"> </script><noscript><a href="http://www.makepovertyhistory.org/"> http://www.makepovertyhistory.org</a></noscript> // -->
		<div id="banner">
			<img src="./img/main_01.jpg" usemap="#mainIMG_Map" border="0">
		</div>
		
		<div id="menunew">
     		 <ul> 
				<li><a href="home?action=SHOW&what=CHISIAMO" onMouseOver="this.id='sel'" onMouseOut="this.id='1'">CHi SiAMO</a></li> 
				<li><a href="news" id="sel">NEWS</a></li> 
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
							<A HREF="news?action=SHOW&what=NEWS&id=<%= id %>&mese=<%= month-1 %>&anno=<%= year %>"><img src="img/indietro_on.gif" border="0" width="11px" title="Mese precedente"></a>
						</TD>
						<TD colspan="5" align="center" style="padding-left:0px; padding-right:0px;padding-bottom:5px  ">
							<FONT class="calend_t"><B><%= month_str + "  " + year %></B></FONT>
						</TD>
						<TD align="right" style="padding-left:0px; padding-right:0px;padding-bottom:5px ">
							<A HREF="news?action=SHOW&what=NEWS&id=<%= id %>&mese=<%= month+1 %>&anno=<%= year %>"><img src="img/avanti_on.gif" border="0" width="11px" title="Mese successivo"></a>
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
			
<% 			if(x.equals("NEWS")) { %>
			
			<div id="menu_dx" style="padding-top:30px">
				<font class="style1">
					<BR><BR>
					&nbsp&nbsp&nbsp&nbsp;<img src="img/fr1_giu.gif" border="0px"> &nbsp&nbsp;NOTIZIA<BR>
					&nbsp&nbsp&nbsp&nbsp;<a href="news?action=SHOW&what=NEWS&id=<%= id %>&x=PHOTOGALLERY"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;IMMAGINI</a><BR>
					&nbsp&nbsp&nbsp&nbsp;<a href="news?action=SHOW&what=NEWS&id=<%= id %>&x=DOWNLOAD"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;DOWNLOAD</a><BR>
					&nbsp&nbsp&nbsp&nbsp;<a href="javascript:print()"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;STAMPA</a><BR>
					&nbsp&nbsp&nbsp&nbsp;<a href=""><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;INVIA PAGINA</a><BR>
				</font>
			</div>
			
			
			<div id="testo">
				<div style="padding-top:3px; color:#000099;">
					<FONT FACE="VERDANA, ARIAL" SIZE="1" COLOR="#000099"> 
					<a href="home">H.O.P.E.</a> > 
					<a href="news">News</a> > 
					<a href="news?action=SHOW&what=NEWS&id=<%= id %>"><%= titolo %></a></FONT>
				</div>
				<TABLE width="440px" border="0" cellpadding="0" cellspacing="0">
					<TR>
						<TD style="padding-top: 12px; padding-bottom:7px;">
							<h4><%= data_ins %></h4>
							<h1 style="padding-left:10px;"><%= titolo %></h1>
						</TD>
					</TR>
					<% if(sottotitolo != null && !sottotitolo.isEmpty()) { %>
						<TR>
							<TD style="padding-bottom:10px;">
								<h3 style="padding-left:10px;"><%= sottotitolo %></h3>
							</TD>
						</TR>
					<% } %>
				</TABLE>
				<div style="width:430px; padding-left:5px; padding-right:5px;padding-bottom:15px;">
					<TABLE align="left">
						<TR>
							<TD style="padding-bottom: 10px; padding-right:10px">
									<SCRIPT language="javascript">
										AltoGallery("<%= ((Immagini) img.get(0)).getImg() %>");
									</SCRIPT>
							</TD>
						</TR>
					</TABLE>
					<p align="left"><%= testo %></p>
				</div>
		  </div>
		  
<%			} else if(x.equals("PHOTO")){   %>
			
			<!--
			<div id="menu_dx" style="padding-top:30px">
				<font class="style1">
					<BR><BR>
					&nbsp&nbsp&nbsp&nbsp;<a href="news?action=SHOW&what=NEWS&id=<%= id %>"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;NOTIZIA</a><BR>
					&nbsp&nbsp&nbsp&nbsp;<a href="news?action=SHOW&what=NEWS&id=<%= id %>&x=PHOTOGALLERY"><img src="img/fr1_giu.gif" border="0px"> &nbsp&nbsp;IMMAGINI</A><BR>
					&nbsp&nbsp&nbsp&nbsp;<a href="news?action=SHOW&what=NEWS&id=<%= id %>&x=DOWNLOAD"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;DOWNLOAD</a><BR>
					&nbsp&nbsp&nbsp&nbsp;<a href="javascript:print()"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;STAMPA</a><BR>
					&nbsp&nbsp&nbsp&nbsp;<a href=""><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;INVIA PAGINA</a><BR>
				</font>
			</div>
			-->
			
			<div id="testo">
				<div style="padding-top:3px; color:#000099;">
					<FONT FACE="VERDANA, ARIAL" SIZE="1" COLOR="#000099"> 
					<a href="home">H.O.P.E.</a> > 
					<a href="news">News</a> > 
					<a href="news?action=SHOW&what=NEWS&id=<%= id %>"><%= titolo %></a></FONT>
				</div> 
				<div align="center" style="padding-top:25px ">
					<% if(ListaImg != null) { 
						String img_src = ((Immagini) ListaImg.get(0)).getImggrande(); %>
						<script language="javascript">
							Alto("<%= img_src %>");
						</script>
						<BR>
						<div align="center" style="padding-top: 15px; padding-bottom: 15px;">
						<% if(prev != null) { %>
							<a href="news?action=SHOW&what=NEWS&id=<%= id %>&x=PHOTO&n_img=<%= prev %>"><img src="img/indietro_on.gif" border="0"></a>
						<% } else {  %>
							<img src="img/indietro_off.gif">
						<% } 
						
						for(int j = 1; j <= totImg; j++) { 
							if(j != n_img) { %>
								&nbsp;<font class="style1" style="size:12px; text-decoration:underline; color:#0000CC;"><a href="news?action=SHOW&what=NEWS&id=<%= id %>&x=PHOTO&n_img=<%= Integer.toString(j) %>"><%= Integer.toString(j) %></a></font>&nbsp;
						<% } else { %>
								&nbsp;<font class="style1"><%= Integer.toString(j) %></font>&nbsp;
						<% } 
						
						} if(next != null) { %>
							<a href="news?action=SHOW&what=NEWS&id=<%= id %>&x=PHOTO&n_img=<%= next %>"><img src="img/avanti_on.gif" border="0"></a>
						<% } else {  %>
							<img src="img/avanti_off.gif">
						<% } %>
						<!--
						<input type="button" class="form_button" value="<<" name="B2" onClick="backward()">
						
						<input type="button" class="form_button" value=">>" name="B1" onClick="forward()">
						// -->
						</div>
					<% } else { %>
						<font class="subtitle_news"><BR><BR>Non sono disponibili immagini</font>
					<% } %>
				</div>
			</div>

<%			} else if(x.equals("DOWNLOAD")) { %>
			
			<div id="menu_dx" style="padding-top:30px">
				<font class="style1">
					<BR><BR>
					&nbsp&nbsp&nbsp&nbsp;<a href="news?action=SHOW&what=NEWS&id=<%= id %>"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;NOTIZIA</a><BR>
					&nbsp&nbsp&nbsp&nbsp;<a href="news?action=SHOW&what=NEWS&id=<%= id %>&x=PHOTOGALLERY"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;IMMAGINI</a><BR>
					&nbsp&nbsp&nbsp&nbsp;<img src="img/fr1_giu.gif" border="0px"> &nbsp&nbsp;DOWNLOAD</a><BR>
					&nbsp&nbsp&nbsp&nbsp;<a href="javascript:print()"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;STAMPA</a><BR>
					&nbsp&nbsp&nbsp&nbsp;<a href=""><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;INVIA PAGINA</a><BR>
				</font>
			</div>
			
			
			<div id="testo">
				<div style="padding-top:3px; color:#000099;">
					<FONT FACE="VERDANA, ARIAL" SIZE="1" COLOR="#000099"> 
					<a href="home">H.O.P.E.</a> > 
					<a href="news">News</a> > 
					<a href="news?action=SHOW&what=NEWS&id=<%= id %>"><%= titolo %></a></FONT>
				</div> 
			</div>
<%			} else if(x.equals("PHOTOGALLERY")) {   %>
			
			<!--
			<div id="menu_dx" style="padding-top:30px">
				<font class="style1">
					<BR><BR>
					
					&nbsp&nbsp&nbsp&nbsp;<a href="news?action=SHOW&what=NEWS&id=<%= id %>"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;NOTIZIA</a><BR>
					&nbsp&nbsp&nbsp&nbsp;<img src="img/fr1_giu.gif" border="0px"> &nbsp&nbsp;IMMAGINI<BR>
					&nbsp&nbsp&nbsp&nbsp;<a href="news?action=SHOW&what=NEWS&id=<%= id %>&x=DOWNLOAD"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;DOWNLOAD</a><BR>
					&nbsp&nbsp&nbsp&nbsp;<a href="javascript:print()"><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;STAMPA</a><BR>
					&nbsp&nbsp&nbsp&nbsp;<a href=""><img src="img/fr1.gif" border="0px"> &nbsp&nbsp;INVIA PAGINA</a><BR>
				</font>
			</div>
			-->
			
			<div id="testo">
				<div style="padding-top:3px; color:#000099;">
					<FONT FACE="VERDANA, ARIAL" SIZE="1" COLOR="#000099"> 
					<a href="home">H.O.P.E.</a> > 
					<a href="news">News</a> > 
					<a href="news?action=SHOW&what=NEWS&id=<%= id %>"><%= titolo %></a></FONT>
				</div>
				
				<div align="center" style="padding-top:20px; padding-right: 10px">
					<TABLE>
						<TR>
						<%if(ListaImg != null){
							for(int i = 0; i < ListaImg.size(); i++){
								Immagini tmp = (Immagini) ListaImg.get(i);
								if((i%3 == 0)&&(i > 0)){ %>
						</tr>
						<tr>
						<% } %>
						 <td height="90" width="90" align="center">
							<A HREF="news?action=SHOW&what=NEWS&id=<%= id %>&x=PHOTO&n_img=<%= i+1 %>">
							<script language="javascript">
								AltoGallery("<%= tmp.getImg() %>");
							</script>
							</a><br>
						 </td>
						  <%}
						}else{%>
							<font class="subtitle_news"><BR><BR>Non sono disponibili immagini</font>
						  <% } %>
						</TR>
					</TABLE>
				</div>
				
			</div>
			
<%			}	%>
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