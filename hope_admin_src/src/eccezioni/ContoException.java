package eccezioni;

public class ContoException extends Exception{
	
	static String message = "Errore! Impossibile eliminare il Conto perch� presenti una o pi� Scritture con questo Conto.";
	/**
	 * 
	 */
	private static final long serialVersionUID = 3142276802610291581L;

	public ContoException() {
		super(message);
	}
	
	public ContoException(String s) {
		super (s);
	}

}