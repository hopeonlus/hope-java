package eccezioni;

public class LoginException extends Exception{
	
	static String message = "Autenticazione fallita!";
	/**
	 * 
	 */
	private static final long serialVersionUID = 3142276802610291581L;

	public LoginException() {
		super(message);
	}
	
	public LoginException(String s) {
		super (s);
	}

}