<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>H.O.P.E. - Caricamento in corso...</title>
</head>

<body>
	<%--<jsp:forward page = "home" />
    <a href="index.jsp">index</a>--%>
<%

        String username="hope2011_website";

        String password="fordfocus";

        String dbName="hope2011_db";

        String dbHost="204.93.193.117";



        try {

                Class.forName("com.mysql.jdbc.Driver");

        } catch(ClassNotFoundException msg) {

                out.println("Error loading driver:" + msg.getMessage());

        }

        try{

        String url ="jdbc:mysql://"+dbHost+":3306/"+dbName;

        Connection Conn = DriverManager.getConnection(url,username, password);

        Statement Stmt = Conn.createStatement();

        String query = "select * from high";

        ResultSet res = Stmt.executeQuery(query);

        while(res.next())

        {

        out.println("Query result : "+res.getObject(1));

        }

        } catch(SQLException e) {

                   String err1Msg = e.getMessage();

         %>

         <TD COLSPAN="2"><STRONG><EM>err1Msg = <%= err1Msg %></EM></STRONG></TD>

         <%

        }



%>


</body>
</html>