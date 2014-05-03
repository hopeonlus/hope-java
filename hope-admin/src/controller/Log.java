package controller;

import java.io.FileOutputStream;
import java.io.ObjectOutput;
import java.io.ObjectOutputStream;
import java.io.OutputStream;

public final class Log {

	String file = "../";
	public static String LOG_FILE_BILANCIO = "bilancio.log";
	public static String LOG_FILE_SOCI = "soci.log";

	public Log(String t) {
		
		if(t.equals("bilancio"))
			file = LOG_FILE_BILANCIO;
		else if(t.equals("soci"))
			file = LOG_FILE_SOCI;
	}

	public void append(String text){
		
		try
		{
		OutputStream outStream = new FileOutputStream(file);
		ObjectOutput objectOut = new ObjectOutputStream(outStream);
	
		objectOut.writeObject(text);
	
		objectOut.flush();
		objectOut.close();
		}
		catch (Exception e){
			System.out.println(e.toString());
			}
	}
}
