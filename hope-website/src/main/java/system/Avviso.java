package system;

public class Avviso {
	
	private String testo;
	
	public Avviso () {
		
	}
	
	public Avviso (String testo) {
		this.testo = testo;
	}

	/**
	 * @return Returns the testo.
	 */
	public String getTesto() {
		return testo;
	}

	/**
	 * @param testo The testo to set.
	 */
	public void setTesto(String testo) {
		this.testo = testo;
	}
	

}
