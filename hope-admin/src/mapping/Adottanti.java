package mapping;

import mapping.Anagrafe;



/**
 * Adottanti generated by hbm2java
 */

public class Adottanti  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private Bambino bambino;
     private Anagrafe anagrafe;
     private Integer anno;
     private Integer p1;
     private Integer p2;
     private Integer p3;


    // Constructors

    /** default constructor */
    public Adottanti() {
    }
    
    /** constructor with id */
    public Adottanti(Integer id) {
        this.id = id;
    }

    

   
    // Property accessors

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public Bambino getBambino() {
        return this.bambino;
    }
    
    public void setBambino(Bambino bambino) {
        this.bambino = bambino;
    }

    public Anagrafe getAnagrafe() {
        return this.anagrafe;
    }
    
    public void setAnagrafe(Anagrafe anagrafe) {
        this.anagrafe = anagrafe;
    }

    public Integer getAnno() {
        return this.anno;
    }
    
    public void setAnno(Integer anno) {
        this.anno = anno;
    }

    public Integer getP1() {
        return this.p1;
    }
    
    public void setP1(Integer p1) {
        this.p1 = p1;
    }

    public Integer getP2() {
        return this.p2;
    }
    
    public void setP2(Integer p2) {
        this.p2 = p2;
    }

    public Integer getP3() {
        return this.p3;
    }
    
    public void setP3(Integer p3) {
        this.p3 = p3;
    }
   








}