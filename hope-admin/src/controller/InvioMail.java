package controller;
import java.util.*;
import java.net.*;
import java.io.*;

public class InvioMail
{ 
static BufferedReader in;
static PrintWriter out;
static String server="smtp.libero.it";
static String mittente="zanitete@libero.it";
static String destinatario="zanitete@gmail.com";
static String messaggio="ciao ciao ciao";
static String soggetto="PROVA";
static String username="SERVER HOPE";

public static void main(String[] args)
{ 
	try
	{ 
		Socket s = new Socket(server, 25);
		out = new PrintWriter(s.getOutputStream());
		in = new BufferedReader(new InputStreamReader(s.getInputStream()));
		
		String hostName = InetAddress.getLocalHost().getHostName();
		
		receive();
		send("HELO " + hostName);
		receive();
		send("MAIL FROM: <" + mittente + ">");
		receive();
		send("RCPT TO: <" + destinatario + ">");
		receive();
		send("DATA");
	    send("MIME-Version: 1.0");
	    send("Subject: " + soggetto);
	    send("From: " + username + " <" + mittente + ">");
	    send("To: " + "tete" + " <" + destinatario + ">");
		receive();
		StringTokenizer tokenizer = new StringTokenizer(messaggio, "\n");
		while (tokenizer.hasMoreTokens())
		send(tokenizer.nextToken());
		send(".");
		receive();
		s.close();
	}
	catch (IOException exception)
	{ 
	System.out.println("Error: " + exception);
	}
}

public static void send(String s) throws IOException
{ 
System.out.println(s);
System.out.println("\n");
out.print(s);
out.print("\r\n");
out.flush();
}

public static void receive() throws IOException
{
String line = in.readLine();
if (line != null)
{
System.out.println(line);
System.out.println("\n");
}
}
}