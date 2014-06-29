package controller;

import java.io.*;
import java.net.*;

public class SendMail {
	static  int SMTPport =  25;
	  static  Socket  socket;
	  static  DataInputStream in;
	  static  DataOutputStream out;
	  static  PrintStream prout;

	 public static void sendMail(String mailServer,
	                             String recipient,
	                             String subject,
	                             String messaggio,
	                             String fileName,
	                             String userName,
	                             String from) {
	  try {
	    Socket s = new Socket(mailServer, SMTPport);
	    BufferedReader in = new BufferedReader( new InputStreamReader(s.getInputStream(), "8859_1") );
	    BufferedWriter out = new BufferedWriter( new OutputStreamWriter(s.getOutputStream(), "8859_1") );

	    String boundary = "Dat_Sep_Str_#COD#";   // Servirà??  -- Data Separator String --

	    sendln(in, out, "EHLO " + userName);
	    sendln(in, out, "MAIL FROM: <"+ from + ">");
	    sendln(in, out, "RCPT TO: <" + recipient + ">" );
	    sendln(in, out, "DATA");
	    sendln(out, "MIME-Version: 1.0");
	    sendln(out, "Subject: " + subject);
	    sendln(out, "From: " + userName + " <" + from + ">");
	    sendln(out, "Content-Type: multipart/mixed; boundary=\"" + boundary +"\"");
	    sendln(out, "\r\n--" + boundary);

	    // Send the body
	    sendln(out, "Content-Type: text/plain; charset=\"us-ascii\"\r\n");
	    sendln(out, messaggio);
	    sendln(out, "\r\n--" +  boundary );

	    // send the attachment
	    String nomeFile = (new File(fileName)).getName();
	    sendln(out, "Content-Type:image/gif; name="+nomeFile);
	    sendln(out, "Content-Disposition: attachment;filename=\""+fileName+"\"");
	    sendln(out, "Content-transfer-encoding: base64\r\n");
	    MIMEBase64.encode(fileName, out);
	    sendln(out, "\r\n--" + boundary);

	    sendln(out, "\r\n\r\n--" + boundary + "--\r\n");
	    sendln(in, out,".");
	    sendln(in, out, "QUIT");
	    s.close();
	    }
	  catch (Exception e) {
	    e.printStackTrace();
	    }
	  }

	 public static void sendln(BufferedReader in, BufferedWriter out, String s) {
	  try {
	    out.write(s + "\r\n");
	    out.flush();
	    Thread.sleep(1000);
	    s = in.readLine();
	    }
	  catch (Exception e) {
	    e.printStackTrace();
	    }
	   }

	 public static void sendln(BufferedWriter out, String s) {
	   try {
	    out.write(s + "\r\n");
	    out.flush();
	    }
	   catch (Exception e) {
	    e.printStackTrace();
	    }
	   }
}
