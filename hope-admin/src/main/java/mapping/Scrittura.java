package mapping;

import java.util.Date;


/**
 * Scrittura generated by hbm2java
 */

public class Scrittura  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private Conto dare;
     private Conto avere;
     private Anno anno;
     private Date data;
     private String descrizione;
     private float importo;
     private boolean automatico;
     


    // Constructors

	/** default constructor */
    public Scrittura() {
    }
    
    /** constructor with id */
    public Scrittura(Integer id) {
        this.id = id;
    }

    

   
    // Property accessors

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public Conto getAvere() {
		return avere;
	}

	public void setAvere(Conto avere) {
		this.avere = avere;
	}

	public Conto getDare() {
		return dare;
	}

	public void setDare(Conto dare) {
		this.dare = dare;
	}

	public Date getData() {
        return this.data;
    }
    
    public void setData(Date data) {
        this.data = data;
    }

    public String getDescrizione() {
        return this.descrizione;
    }
    
    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public float getImporto() {
        return this.importo;
    }
    
    public void setImporto(float importo) {
        this.importo = importo;
    }

    public boolean isAutomatico() {
        return this.automatico;
    }
    
    public void setAutomatico(boolean automatico) {
        this.automatico = automatico;
    }

	public Anno getAnno() {
		return this.anno;
	}

	public void setAnno(Anno anno) {
		this.anno = anno;
	}
   








}