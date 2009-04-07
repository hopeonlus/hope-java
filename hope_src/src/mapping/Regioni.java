package mapping;

import java.util.Set;


/**
 * Regioni generated by hbm2java
 * editeto da tete 2 marzo 2008, aggiunto campi icona_path
 */

public class Regioni  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private String regione;
     private String icona_path;
     private Set progettis;


    // Constructors

    /** default constructor */
    public Regioni() {
    }
    
    /** constructor with id */
    public Regioni(Integer id) {
        this.id = id;
    }

    

   
    // Property accessors

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public String getRegione() {
        return this.regione;
    }
    
    public void setRegione(String regione) {
        this.regione = regione;
    }

    public Set getProgettis() {
        return this.progettis;
    }
    
    public void setProgettis(Set progettis) {
        this.progettis = progettis;
    }

	public String getIcona_path() {
		return icona_path;
	}

	public void setIcona_path(String icona_path) {
		this.icona_path = icona_path;
	}
   








}