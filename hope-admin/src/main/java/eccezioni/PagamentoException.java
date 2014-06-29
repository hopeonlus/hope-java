package eccezioni;

public class PagamentoException extends Exception{

	static String message = "Esite giÃ  un pagamento per l'anno selezionato!";
	/**
	 * 
	 */
	private static final long serialVersionUID = 3142276802610291581L;

	public PagamentoException() {
		super(message);
	}
	
	public PagamentoException(String s) {
		super (s);
	}
}
