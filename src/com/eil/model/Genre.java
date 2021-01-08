package com.eil.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the articles database table.
 * 
 */
@Entity
@Table(name="genre")

//@NamedQuery(name="Article.findAll", query="SELECT a FROM Article a")

@NamedQueries({
	@NamedQuery(name="Genre.findAll", query="SELECT g FROM Genre g"),
	@NamedQuery(name="Genre.find", query="SELECT g FROM Genre g WHERE g.id=:id")
})
public class Genre implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	private String titre;


	public Genre() {
	}


	public String getTitre() {
		return titre;
	}


	public void setTitre(String titre) {
		this.titre = titre;
	}
}