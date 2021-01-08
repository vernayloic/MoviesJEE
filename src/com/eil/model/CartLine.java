package com.eil.model;

/**
 * Ligne Panier
 */
public class CartLine {
	private int id;
	private int qtite;
	private float prix;
	
	public CartLine(int id, int qtite, float prix) {
		this.id = id;
		this.qtite = qtite;
		this.prix = prix;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getQtite() {
		return qtite;
	}

	public void setQtite(int qtite) {
		this.qtite = qtite;
	}

	public float getPrix() {
		return prix;
	}

	public void setPrix(float prix) {
		this.prix = prix;
	}

	@Override
	public String toString() {
		return "CartLine [id=" + id + ", qtite=" + qtite + ", prix=" + prix + "]";
	}
	
}
