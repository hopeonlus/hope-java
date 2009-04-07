package mapping;



/**
 * NonsociId generated by hbm2java
 */

public class NonsociId  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private String cognome;
     private String nome;
     private String citta;


    // Constructors

    /** default constructor */
    public NonsociId() {
    }
    

    

   
    // Property accessors

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public String getCognome() {
        return this.cognome;
    }
    
    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getNome() {
        return this.nome;
    }
    
    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCitta() {
        return this.citta;
    }
    
    public void setCitta(String citta) {
        this.citta = citta;
    }
   



   public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof NonsociId) ) return false;
		 NonsociId castOther = ( NonsociId ) other; 
         
		 return ( (this.getId()==castOther.getId()) || ( this.getId()!=null && castOther.getId()!=null && this.getId().equals(castOther.getId()) ) )
 && ( (this.getCognome()==castOther.getCognome()) || ( this.getCognome()!=null && castOther.getCognome()!=null && this.getCognome().equals(castOther.getCognome()) ) )
 && ( (this.getNome()==castOther.getNome()) || ( this.getNome()!=null && castOther.getNome()!=null && this.getNome().equals(castOther.getNome()) ) )
 && ( (this.getCitta()==castOther.getCitta()) || ( this.getCitta()!=null && castOther.getCitta()!=null && this.getCitta().equals(castOther.getCitta()) ) );
   }
   
   public int hashCode() {
         int result = 17;
         
         result = 37 * result + ( getId() == null ? 0 : this.getId().hashCode() );
         result = 37 * result + ( getCognome() == null ? 0 : this.getCognome().hashCode() );
         result = 37 * result + ( getNome() == null ? 0 : this.getNome().hashCode() );
         result = 37 * result + ( getCitta() == null ? 0 : this.getCitta().hashCode() );
         return result;
   }   





}