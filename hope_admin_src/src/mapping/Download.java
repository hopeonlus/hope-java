package mapping;



/**
 * Download generated by hbm2java
 */

public class Download  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private Tipofile tipofile;
     private News news;
     private String nome;
     private String src;


    // Constructors

    /** default constructor */
    public Download() {
    }
    
    /** constructor with id */
    public Download(Integer id) {
        this.id = id;
    }

    

   
    // Property accessors

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public Tipofile getTipofile() {
        return this.tipofile;
    }
    
    public void setTipofile(Tipofile tipofile) {
        this.tipofile = tipofile;
    }

    public News getNews() {
        return this.news;
    }
    
    public void setNews(News news) {
        this.news = news;
    }

    public String getNome() {
        return this.nome;
    }
    
    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getSrc() {
        return this.src;
    }
    
    public void setSrc(String src) {
        this.src = src;
    }
   








}