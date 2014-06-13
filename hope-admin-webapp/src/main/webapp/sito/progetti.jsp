
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="mapping.*" %>
<%
Users user = (Users) session.getAttribute("user");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">

<STYLE type="text/css">
	@import url("style.css");
</STYLE>
<TITLE>HOPE - Gestione Sito Web</TITLE>
</HEAD>
<BODY id="body">
	<div id="container">
		<TABLE border=0 align=center width=100%>
			<TR>
				<TD align=left><img src="./../img/logo.gif" height=80px></TD>
				<TD align=center>
					<font class="bilancio">Gestione Sito Web</font>
					<BR><FONT color=#0000CC style="font-size: 12px;" face="Verdana, Arial, Helvetica, sans-serif"><B>(<%= user.getUsername() %>)</B></font>
				</TD>
				<TD align=right><img src="./../img/logo.gif" height=80px></TD>
			</TR>
		</TABLE>
		<div id="menu" align="center">
			<ul>
				<li><a href="accedisito">Home</a></li>
				<li><a href="news">News</a></li>
				<li><a href="news?action=showeventi">Eventi</a></li>
				<li><a id="current">Progetti</a></li>
				<li><a href="accedisito?what=imgs">Immagini</a></li>
				<li><a href="accedisito?what=newsletter">Newsletter</a></li>
				<li><a href="../accedi?action=logout">Logout</a></li>
			</ul>
		</div>
		<div id="content">
			<%= "basePath --> " + basePath + "<BR>path --> " + path %>
	  	</div>
		<DIV id="fondo">
			<P class="copy">@ by TETE @ 2006</P>
		</DIV>
	</div>
</BODY>
</HTML>
