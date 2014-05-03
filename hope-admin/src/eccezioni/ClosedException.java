package eccezioni;

public class ClosedException extends Exception{
	
	static String message = "Errore! La data inserita si riferische ad un bilancio già chiuso";
	/**
	 * 
	 */
	private static final long serialVersionUID = 3142276802610291581L;

	public ClosedException() {
		super(message);
	}
	
	public ClosedException(String s) {
		super (s);
	}

}