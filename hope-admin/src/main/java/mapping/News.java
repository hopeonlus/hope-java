package mapping;

import java.util.Date;
import java.util.Set;


/**
 * News generated by hbm2java
 */

public class News  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private Categorienews categorienews;
     private String titolo;
     private String sottotitolo;
     private String testo;
     private Date data;
     private String home;
     private Set downloads;
     private Set eventis;
     private Set newsimgs;
     private Set highs;


    // Constructors

    /** default constructor */
    public News() {
    }
    
    /** constructor with id */
    public News(Integer id) {
        this.id = id;
    }

    

   
    // Property accessors

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public Categorienews getCategorienews() {
        return this.categorienews;
    }
    
    public void setCategorienews(Categorienews categorienews) {
        this.categorienews = categorienews;
    }

    public String getTitolo() {
        return this.titolo;
    }
    
    public void setTitolo(String titolo) {
        this.titolo = titolo;
    }

    public String getSottotitolo() {
        return this.sottotitolo;
    }
    
    public void setSottotitolo(String sottotitolo) {
        this.sottotitolo = sottotitolo;
    }

    public String getTesto() {
        return this.testo;
    }
    
    public void setTesto(String testo) {
        this.testo = testo;
    }

    public Date getData() {
        return this.data;
    }
    
    public void setData(Date data) {
        this.data = data;
    }

    public String getHome() {
        return this.home;
    }
    
    public void setHome(String home) {
        this.home = home;
    }

    public Set getDownloads() {
        return this.downloads;
    }
    
    public void setDownloads(Set downloads) {
        this.downloads = downloads;
    }

    public Set getEventis() {
        return this.eventis;
    }
    
    public void setEventis(Set eventis) {
        this.eventis = eventis;
    }

    public Set getNewsimgs() {
        return this.newsimgs;
    }
    
    public void setNewsimgs(Set newsimgs) {
        this.newsimgs = newsimgs;
    }

    public Set getHighs() {
        return this.highs;
    }
    
    public void setHighs(Set highs) {
        this.highs = highs;
    }
   








}