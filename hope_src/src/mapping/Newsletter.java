package mapping;



/**
 * Newsletter generated by hbm2java
 */

public class Newsletter  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private String email;


    // Constructors

    /** default constructor */
    public Newsletter() {
    }
    
    /** constructor with id */
    public Newsletter(Integer id) {
        this.id = id;
    }

    

   
    // Property accessors

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmail() {
        return this.email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
   








}