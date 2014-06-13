<%@ page language="java" import="java.util.*" %>
<%@ page import="mapping.*"%>

<%
	Users user = (Users) session.getAttribute("user");
	
	List ListaNomi = (List) request.getAttribute("listaNomi");
	
	String orderby = request.getParameter("orderby");
	if(orderby == null)
		orderby = "id";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
"http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
<HEAD>
<STYLE type="text/css">
	@import url("style.css");
</STYLE>
<script>
var debug = false; //set true to enable debug alerts
var myConn;
var method = 'POST';
var url = '<%= request.getContextPath() %>/soci/anagrafe';
var originalClass;
var currentVal;
var currentId;
var oldColor;

function isFocused(elem){
	var elem_tr = document.getElementById( elem.id.split("_")[0] + '_tr');
	originalClass = elem_tr.className;
	currentVal = elem.value;
	currentId = elem.id;
	//elem_tr.style.backgroundColor='yellow';
}

function isChanged(elem){
	var elem_tr = document.getElementById( elem.id.split("_")[0] + '_tr');
	if(currentVal != elem.value){
		var params = 'action=refresh&operation=update&id=' + elem.id + '&value=' + elem.value + '&name=' + elem.name;
		elem_tr.style.backgroundColor='#F3B1B4';
		//elem.style.backgroundColor='#F3B1B4';
		if(myConn == null)
			myConn = new XHConn();
		if (!myConn) alert("XMLHTTP not available. Try a newer/better browser.");
		var fnWhenDone = function (oXML) { saveValues(oXML) };
		if(debug) alert('url: ' + url + '?' + params + ' method: ' + method);
		myConn.connect(url, method, params, fnWhenDone);
	} else {
		if(originalClass == 'row0')
			elem_tr.style.backgroundColor='FFFFFF';
		else
			elem_tr.style.backgroundColor='F7FAFB';
	}
}

function saveValues(oXML){
	if(debug) alert('XML response --> ' + oXML.responseText);
	/*var root_node = oXML.responseXML.getElementsByTagName('id').item(0);
	alert(root_node.firstChild.data);
	*/
	
	try {
		var id = oXML.responseXML.getElementsByTagName('id').item(0).firstChild.data;
		//var elem = document.getElementById( id + '_td');
		var elem = document.getElementById( id.split("_")[0] + '_tr');
		if(originalClass == 'row0')
			elem.style.backgroundColor='FFFFFF';
		else
			elem.style.backgroundColor='F7FAFB';
	} catch (err) {
		if(debug) alert('error=' + err);
		var elem = document.getElementById( currentId.split("_")[0] + '_tr');
		if(originalClass == 'row0')
			elem.style.backgroundColor='FFFFFF';
		else
			elem.style.backgroundColor='F7FAFB';
	}
	/*elem = document.getElementById( id );
	elem.style.backgroundColor='transparent' ;	*/
}



function ajaxDelete(elem) {
	var elem_tr = document.getElementById( elem.id.split("_")[0] + '_tr');
	originalClass = elem_tr.className;
	currentId = elem.id;
	elem_tr.style.backgroundColor='#F3B1B4';
	
	var params = 'action=refresh&operation=delete&id=' + elem.id;
	
	if(myConn == null)
			myConn = new XHConn();
	if (!myConn) alert("XMLHTTP not available. Try a newer/better browser.");
	
	var fnWhenDone = function (oXML) { deleteRow(oXML) };
	if(debug) alert('url: ' + url + '?' + params + ' method: ' + method);
	
	myConn.connect(url, method, params, fnWhenDone);
}

function deleteRow(oXML) {
	
	if(debug) alert('XML response --> ' + oXML.responseText);

	try {
		var id = oXML.responseXML.getElementsByTagName('id').item(0).firstChild.data;
		var rowId = id.split("_")[0] + '_tr';
		
		//ottengo riga intera
		var elem = document.getElementById(rowId);
		
		//elimino riga da table
		document.getElementById('maintable').deleteRow(elem.rowIndex);
	} catch (err) {
		if(debug) alert('error=' + err);
		var elem = document.getElementById( currentId.split("_")[0] + '_tr');
		if(originalClass == 'row0')
			elem.style.backgroundColor='FFFFFF';
		else
			elem.style.backgroundColor='F7FAFB';
	}
}

function keyPressed(e) {

	var keynum;
	var row;
	var cell;
	var rowIndex;
	var cellIndex;
	
	if(window.event) {
		// IE
		keynum = e.keyCode;
	} else if (e.which) {
		// Netscape/Firefox/Opera
		keynum = e.which;
	}
	
	//up
	if(keynum == 38) {
		cell = document.getElementById( currentId ).parentNode;
		row = document.getElementById( currentId.split("_")[0] + '_tr');
		rowIndex = row.rowIndex;
		cellIndex = cell.cellIndex;
		if(rowIndex != 1)
			document.getElementById('maintable').rows[rowIndex-1].cells[cellIndex].getElementsByTagName('input')[0].focus();
	}
	//down
	else if(keynum == 40) {
		cell = document.getElementById( currentId ).parentNode;
		row = document.getElementById( currentId.split("_")[0] + '_tr');
		rowIndex = row.rowIndex;
		cellIndex = cell.cellIndex;
		document.getElementById('maintable').rows[rowIndex+1].cells[cellIndex].getElementsByTagName('input')[0].focus();
	}
	
}

/*	function changeValues(oXML){
		if(debug) alert('XML response --> ' + oXML.responseXml.xml);
		var count = 0;
		var new_values = oXML.responseXml.getElementsByTagName('v');
		while(document.getElementById( 'v_' + count ) != null){
			var tmp = document.getElementById( 'v_' + count );
			if((new_values[count] != null)&&(new_values[count].childNodes[0]) != null){
					var new_val = new_values[count].childNodes[0].nodeValue;
					if((new_val != null) && (tmp.innerHTML != new_val)){
						if(debug) alert('v_' + count + ' changed!');
						tmp.innerHTML = new_val;
					}
				}
			count++;
		}
	}*/
	
function XHConn()
{
	  var xmlhttp, bComplete = false;
	  try { xmlhttp = new ActiveXObject("Msxml2.XMLHTTP"); }
	  catch (e) { try { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
	  catch (e) { try { xmlhttp = new XMLHttpRequest(); }
	  catch (e) { xmlhttp = false; }}}
	  if (!xmlhttp) return null;
	  this.connect = function(sURL, sMethod, sVars, fnDone)
			{
	    if (!xmlhttp) return false;
	    bComplete = false;
	    sMethod = sMethod.toUpperCase();
	    try {
	      if (sMethod == "GET")
	      {
	        xmlhttp.open(sMethod, sURL+"?"+sVars, true);
	        sVars = "";
	      }
	      else
	      {
	        xmlhttp.open(sMethod, sURL, true);
	        xmlhttp.setRequestHeader("Method", "POST "+sURL+" HTTP/1.1");
	        xmlhttp.setRequestHeader("Content-Type",
	          "application/x-www-form-urlencoded");
	      }
	      xmlhttp.onreadystatechange = function(){
	        if (xmlhttp.readyState == 4 && !bComplete)
	        {
	          bComplete = true;
	          fnDone(xmlhttp);
	        }};
	      xmlhttp.send(sVars);
	    }
	    catch(z) { return false; }
	    return true;
	  };
	  return this;
}
</script>
<TITLE>HOPE - Gestione soci</TITLE>
</HEAD>
<BODY id="body">
	<div id="container">
		<TABLE border=0 align=center width=100%>
			<TR>
				<TD align=left><img src="./img/logo.gif" height=80px></TD>
				<TD align=center>
					<font class="bilancio">Gestione Soci</font>
					<BR><FONT color=#0000CC style="font-size: 12px;" face="Verdana, Arial, Helvetica, sans-serif"><B>( <%= user.getUsername() %> )</B></font>
				</TD>
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
			<table class="tcontentmaxi" align="center">
				<TR>
					<TD align="left">Trovati &nbsp;<B><%= ListaNomi.size() %></B>&nbsp; nominativi :</TD>
				</TR>
			</table>
			<TABLE class="tcontentmaxi" align="center" id="maintable">
				<TR class="intestazione">
					<TD><B>Id <a href="anagrafe?action=page&orderby=id"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD width="16%"><B>Cognome <a href="anagrafe?action=page&orderby=cognome"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD width="16%"><B>Nome <a href="anagrafe?action=page&orderby=nome"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD width="21%"><B>Indirizzo <a href="anagrafe?action=page&orderby=indirizzo"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD width="5%"><B>CAP <a href="anagrafe?action=page&orderby=cap"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD width="15%"><B>Città <a href="anagrafe?action=page&orderby=citta"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD width="7%"><B>Nazione <a href="anagrafe?action=page&orderby=nazione"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD width="16%"><B>Cod. Fiscale <a href="anagrafe?action=page&orderby=codfiscale"><img src="img/giu.gif" border="0"></a></B></TD>
					<TD width="12px"></TD>
					<TD width="12px"></TD>
				</TR>
			<form name="anagrafe" action="anagrafe" method="post">
<%
			for(int i = 0; i < ListaNomi.size(); i++)
			{
				Anagrafe a = (Anagrafe) ListaNomi.get(i);
%>
			<TR class="row<%= i%2 %>" id="<%= a.getId() %>_tr" onMouseOver="javascript:oldColor=this.style.backgroundColor;this.style.backgroundColor='#FFFF66'" onMouseOut="javascript:if(this.style.backgroundColor != '#F3B1B4') this.style.backgroundColor=oldColor;">
				<TD width="4%"><a href="anagrafe?action=view&id=<%= a.getId() %>"><%= a.getId() %></a></TD>
				
				<TD id="<%= a.getId() %>_cognome_td">
					<input type="text" id="<%= a.getId() %>_cognome" name="cognome" value="<%= a.getCognome() %>" onFocus="javascript:isFocused(this)" onBlur="javascript:isChanged(this)" class="input_an<%= i%2 %>" onkeydown="javascript:keyPressed(event);">
				</TD>
					
					
				<TD id="<%= a.getId() %>_nome_td">
					<input type="text" id="<%= a.getId() %>_nome" name="nome" value="<%= a.getNome() %>" onFocus="javascript:isFocused(this)" onBlur="javascript:isChanged(this)" class="input_an<%= i%2 %>" onkeydown="javascript:keyPressed(event);">
				</TD>
				
				
				<TD id="<%= a.getId() %>_indirizzo_td">
					<input type="text" id="<%= a.getId() %>_indirizzo" name="indirizzo" value="<%= a.getIndirizzo() %>" onFocus="javascript:isFocused(this)" onBlur="javascript:isChanged(this)" class="input_an<%= i%2 %>" onkeydown="javascript:keyPressed(event);">
				</TD>
				
				
				<TD id="<%= a.getId() %>_cap_td">
					<input type="text" id="<%= a.getId() %>_cap" name="cap" value="<%= a.getCap() %>" onFocus="javascript:isFocused(this)" onBlur="javascript:isChanged(this)" class="input_an<%= i%2 %>" onkeydown="javascript:keyPressed(event);">
				</TD>
				
				
				<TD id="<%= a.getId() %>_citta_td">
					<input type="text" id="<%= a.getId() %>_citta" name="citta" value="<%= a.getCitta() %>" onFocus="javascript:isFocused(this)" onBlur="javascript:isChanged(this)" class="input_an<%= i%2 %>" onkeydown="javascript:keyPressed(event);">
				</TD>
					
					
				<TD id="<%= a.getId() %>_nazione_td">
					<input type="text" id="<%= a.getId() %>_nazione" name="nazione" value="<%= a.getNazione() %>" onFocus="javascript:isFocused(this)" onBlur="javascript:isChanged(this)" class="input_an<%= i%2 %>" onkeydown="javascript:keyPressed(event);">
				</TD>
					
					
				<TD id="<%= a.getId() %>_codfiscale_td">
					<input type="text" id="<%= a.getId() %>_codfiscale" name="codfiscale" value="<%= a.getCodfiscale() %>" onFocus="javascript:isFocused(this)" onBlur="javascript:isChanged(this)" class="input_an<%= i%2 %>" onkeydown="javascript:keyPressed(event);">
				</TD>
					
					
					
				<TD align="center">
					<a href="anagrafe?action=view&id=<%= a.getId() %>"><img src="img/edit.gif" border="0"></a>
				</TD>
				
				
				<TD align="center">
					<a id="<%= a.getId() %>_delete" onClick="if(confirm('Verranno eliminati TUTTI i dati relativi alla persona!\nSicuro?')) ajaxDelete(this);">
					<img src="img/del.gif" border="0">
					</a>
				</TD>
				
				<%-- OLD (ok)
				<TD align="center">
					<a href="anagrafe?action=del&id=<%= a.getId() %>&orderby=<%= orderby %>" onClick="return(confirm('Verranno eliminati TUTTI i dati relativi alla persona!\nSicuro?'))">
					<img src="img/del.gif" border="0">
					</a>
				</TD>
				--%>
			</TR>
<%			
			}
%>
			</form>
			</TABLE>
	  	</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2006</P>
		</DIV>
	</div>
</BODY>
</HTML>
