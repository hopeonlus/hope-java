package eccezioni;

public class ScritturaException extends Exception{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7773587581138430332L;
	
	static String message = "ERRORE! Impossibile eliminare la scrittura: ";
	
	public ScritturaException() {
		super(message);
	}
	
	public ScritturaException(String s){
		super(message + s);
	}

}
