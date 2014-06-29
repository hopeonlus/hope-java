package eccezioni;

public class ClosedEditException extends Exception{

	/**
	 * 
	 */
	private static final long serialVersionUID = 637322439711620636L;
	
	static String message = "ERRORE! Impossibile modificare i dati relativi ad un bilancio già chiuso.";
	
	public ClosedEditException() {
		super(message);
	}
	
	public ClosedEditException(String s) {
		super(s);
	}

}
