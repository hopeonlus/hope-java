package mapping;



/**
 * ProgettiimgId generated by hbm2java
 */

public class ProgettiimgId  implements java.io.Serializable {


    // Fields    

     private Integer idprogetto;
     private Integer idimg;


    // Constructors

    /** default constructor */
    public ProgettiimgId() {
    }
    

    

   
    // Property accessors

    public Integer getIdprogetto() {
        return this.idprogetto;
    }
    
    public void setIdprogetto(Integer idprogetto) {
        this.idprogetto = idprogetto;
    }

    public Integer getIdimg() {
        return this.idimg;
    }
    
    public void setIdimg(Integer idimg) {
        this.idimg = idimg;
    }
   



   public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof ProgettiimgId) ) return false;
		 ProgettiimgId castOther = ( ProgettiimgId ) other; 
         
		 return ( (this.getIdprogetto()==castOther.getIdprogetto()) || ( this.getIdprogetto()!=null && castOther.getIdprogetto()!=null && this.getIdprogetto().equals(castOther.getIdprogetto()) ) )
 && ( (this.getIdimg()==castOther.getIdimg()) || ( this.getIdimg()!=null && castOther.getIdimg()!=null && this.getIdimg().equals(castOther.getIdimg()) ) );
   }
   
   public int hashCode() {
         int result = 17;
         
         result = 37 * result + ( getIdprogetto() == null ? 0 : this.getIdprogetto().hashCode() );
         result = 37 * result + ( getIdimg() == null ? 0 : this.getIdimg().hashCode() );
         return result;
   }   





}