package com.eil.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the articles database table.
 * 
 */
@Entity
@Table(name="articles")

//@NamedQuery(name="Article.findAll", query="SELECT a FROM Article a")

@NamedQueries({
	@NamedQuery(name="Article.findAll", query="SELECT a FROM Article a"),
	@NamedQuery(name="Article.find", query="SELECT a FROM Article a WHERE a.id=:id")
})
public class Article implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	private String descriptif;

	private String nom;

	private String photo;
	
	private int stock;
	
	private float prix;
	
	@ManyToOne
	@JoinColumn(name="code_genre")
	private Genre genre;

	public Article() {
	}

	public Article(int id, String nom, String descriptif, String photo, float prix, int stock) {
		this.id = id;
		this.descriptif = descriptif;
		this.nom = nom;
		this.photo = photo;
		this.prix = prix;
		this.stock = stock;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescriptif() {
		return this.descriptif;
	}

	public void setDescriptif(String descriptif) {
		this.descriptif = descriptif;
	}

	public String getNom() {
		return this.nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getPhoto() {
		return this.photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public float getPrix() {
		return this.prix;
	}

	public void setPrix(float prix) {
		this.prix = prix;
	}

	@Override
	public String toString() {
		return "[" + id + "]" + nom;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

}