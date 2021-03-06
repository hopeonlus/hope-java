package mapping;



/**
 * FamigliaId generated by hbm2java
 */

public class FamigliaId  implements java.io.Serializable {


    // Fields    

     private Integer id2;
     private Integer id1;


    // Constructors

    /** default constructor */
    public FamigliaId() {
    }
    

    

   
    // Property accessors

    public Integer getId2() {
        return this.id2;
    }
    
    public void setId2(Integer id2) {
        this.id2 = id2;
    }

    public Integer getId1() {
        return this.id1;
    }
    
    public void setId1(Integer id1) {
        this.id1 = id1;
    }
   



   public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof FamigliaId) ) return false;
		 FamigliaId castOther = ( FamigliaId ) other; 
         
		 return ( (this.getId2()==castOther.getId2()) || ( this.getId2()!=null && castOther.getId2()!=null && this.getId2().equals(castOther.getId2()) ) )
 && ( (this.getId1()==castOther.getId1()) || ( this.getId1()!=null && castOther.getId1()!=null && this.getId1().equals(castOther.getId1()) ) );
   }
   
   public int hashCode() {
         int result = 17;
         
         result = 37 * result + ( getId2() == null ? 0 : this.getId2().hashCode() );
         result = 37 * result + ( getId1() == null ? 0 : this.getId1().hashCode() );
         return result;
   }   





}