package mapping;


/**
 * Pagamentosoci generated by hbm2java
 */

public class Pagamentosoci  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private Socio socio;
     private Integer anno;
     private Integer importo;


    // Constructors

    /** default constructor */
    public Pagamentosoci() {
    }
    
    /** constructor with id */
    public Pagamentosoci(Integer id) {
        this.id = id;
    }

    

   
    // Property accessors

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public Socio getSocio() {
        return this.socio;
    }
    
    public void setSocio(Socio socio) {
        this.socio = socio;
    }

    public Integer getAnno() {
        return this.anno;
    }
    
    public void setAnno(Integer anno) {
        this.anno = anno;
    }

    public Integer getImporto() {
        return this.importo;
    }
    
    public void setImporto(Integer importo) {
        this.importo = importo;
    }
   








}