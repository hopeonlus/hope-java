package eccezioni;

public class GruppoException extends Exception{
	
	static String message = "Errore! Impossibile eliminare il Gruppo perchè presenti una o più Scritture con Conti appartenenti a questo Gruppo.";
	/**
	 * 
	 */
	private static final long serialVersionUID = 3142276802610291581L;

	public GruppoException() {
		super(message);
	}
	
	public GruppoException(String s) {
		super (s);
	}

}