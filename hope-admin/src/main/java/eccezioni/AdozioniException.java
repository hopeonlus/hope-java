package eccezioni;

public class AdozioniException extends Exception{

	static String message = "Il bambino selezionato è già stato adottato per l'anno scelto!";
	/**
	 * 
	 */
	private static final long serialVersionUID = 3142276802610291581L;

	public AdozioniException() {
		super(message);
	}
	
	public AdozioniException(String s) {
		super(s);
	}
	
	public AdozioniException(String nome, String anno) {
		super ("Il bambino " + nome + " è già stato adottato per l'anno " + anno + "!");
	}
}
