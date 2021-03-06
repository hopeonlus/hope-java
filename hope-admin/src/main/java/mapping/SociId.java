package mapping;



/**
 * SociId generated by hbm2java
 */

public class SociId  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private String nome;
     private String cognome;
     private String indirizzo;
     private String cap;
     private String citta;
     private String nazione;
     private Integer tessera;


    // Constructors

    /** default constructor */
    public SociId() {
    }
    

    

   
    // Property accessors

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public String getNome() {
        return this.nome;
    }
    
    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCognome() {
        return this.cognome;
    }
    
    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getIndirizzo() {
        return this.indirizzo;
    }
    
    public void setIndirizzo(String indirizzo) {
        this.indirizzo = indirizzo;
    }

    public String getCap() {
        return this.cap;
    }
    
    public void setCap(String cap) {
        this.cap = cap;
    }

    public String getCitta() {
        return this.citta;
    }
    
    public void setCitta(String citta) {
        this.citta = citta;
    }

    public String getNazione() {
        return this.nazione;
    }
    
    public void setNazione(String nazione) {
        this.nazione = nazione;
    }

    public Integer getTessera() {
        return this.tessera;
    }
    
    public void setTessera(Integer tessera) {
        this.tessera = tessera;
    }
   



   public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof SociId) ) return false;
		 SociId castOther = ( SociId ) other; 
         
		 return ( (this.getId()==castOther.getId()) || ( this.getId()!=null && castOther.getId()!=null && this.getId().equals(castOther.getId()) ) )
 && ( (this.getNome()==castOther.getNome()) || ( this.getNome()!=null && castOther.getNome()!=null && this.getNome().equals(castOther.getNome()) ) )
 && ( (this.getCognome()==castOther.getCognome()) || ( this.getCognome()!=null && castOther.getCognome()!=null && this.getCognome().equals(castOther.getCognome()) ) )
 && ( (this.getIndirizzo()==castOther.getIndirizzo()) || ( this.getIndirizzo()!=null && castOther.getIndirizzo()!=null && this.getIndirizzo().equals(castOther.getIndirizzo()) ) )
 && ( (this.getCap()==castOther.getCap()) || ( this.getCap()!=null && castOther.getCap()!=null && this.getCap().equals(castOther.getCap()) ) )
 && ( (this.getCitta()==castOther.getCitta()) || ( this.getCitta()!=null && castOther.getCitta()!=null && this.getCitta().equals(castOther.getCitta()) ) )
 && ( (this.getNazione()==castOther.getNazione()) || ( this.getNazione()!=null && castOther.getNazione()!=null && this.getNazione().equals(castOther.getNazione()) ) )
 && ( (this.getTessera()==castOther.getTessera()) || ( this.getTessera()!=null && castOther.getTessera()!=null && this.getTessera().equals(castOther.getTessera()) ) );
   }
   
   public int hashCode() {
         int result = 17;
         
         result = 37 * result + ( getId() == null ? 0 : this.getId().hashCode() );
         result = 37 * result + ( getNome() == null ? 0 : this.getNome().hashCode() );
         result = 37 * result + ( getCognome() == null ? 0 : this.getCognome().hashCode() );
         result = 37 * result + ( getIndirizzo() == null ? 0 : this.getIndirizzo().hashCode() );
         result = 37 * result + ( getCap() == null ? 0 : this.getCap().hashCode() );
         result = 37 * result + ( getCitta() == null ? 0 : this.getCitta().hashCode() );
         result = 37 * result + ( getNazione() == null ? 0 : this.getNazione().hashCode() );
         result = 37 * result + ( getTessera() == null ? 0 : this.getTessera().hashCode() );
         return result;
   }   





}