package mapping;

import java.util.Set;

/**
 * Anagrafe generated by hbm2java
 */

public class Anagrafe implements java.io.Serializable {

	// Fields

	private Integer id;
	private String nome;
	private String indirizzo;
	private String cap;
	private String citta;
	private String nazione;
	private String telefono;
	private String cellulare;
	private String email;
	private String codfiscale;
	private String cognome;
	private boolean posta;
	private boolean comunicazioni;

	public boolean isComunicazioni() {
		return comunicazioni;
	}

	public void setComunicazioni(boolean comunicazioni) {
		this.comunicazioni = comunicazioni;
	}

	private Set famigliasForId1;
	private Set socios;
	private Set famigliasForId2;
	private Set adottantis;

	// Constructors

	public Set getFamigliasForId1() {
		return famigliasForId1;
	}

	public void setFamigliasForId1(Set famigliasForId1) {
		this.famigliasForId1 = famigliasForId1;
	}

	public Set getFamigliasForId2() {
		return famigliasForId2;
	}

	public void setFamigliasForId2(Set famigliasForId2) {
		this.famigliasForId2 = famigliasForId2;
	}

	public boolean isPosta() {
		return posta;
	}

	public void setPosta(boolean posta) {
		this.posta = posta;
	}

	public Set getAdottantis() {
		return adottantis;
	}

	public void setAdottantis(Set adottantis) {
		this.adottantis = adottantis;
	}

	/** default constructor */
	public Anagrafe() {
	}

	/** constructor with id */
	public Anagrafe(Integer id) {
		this.id = id;
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

	public String getTelefono() {
		return this.telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public String getCellulare() {
		return this.cellulare;
	}

	public void setCellulare(String cellulare) {
		this.cellulare = cellulare;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCodfiscale() {
		return this.codfiscale;
	}

	public void setCodfiscale(String codfiscale) {
		this.codfiscale = codfiscale;
	}

	public String getCognome() {
		return this.cognome;
	}

	public void setCognome(String cognome) {
		this.cognome = cognome;
	}

	public Set getSocios() {
		return this.socios;
	}

	public void setSocios(Set socios) {
		this.socios = socios;
	}

}