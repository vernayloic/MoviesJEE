package com.eil.dao;

import com.eil.model.Article;

public class ArticleDao  extends Dao<Article> { 
	public ArticleDao() {
		super(Article.class, "Article");
	}
}



////nom unité de persistence dans 'META-INF/persistence.xml'
//private static final String PERSISTENCE_UNIT_NAME = "eil19_jee_pu";	
//private static EntityManager em=null;
//
//public ArticleDao() {
//	if(em==null) {
//		EntityManagerFactory emfactory = 
//				Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);			
//		em = emfactory.createEntityManager();
//	}
//}
////pour tests!
//public EntityManager getEntityManager() {
//	return em;
//}
//
///**
// * CRUD (Opérations)
// */
//public List<Article> list(){		
//	TypedQuery<Article> query = em.createNamedQuery("Article.findAll", Article.class);		
//	return query.getResultList();
//}
//public Article find(int id){	
//	// SELECT a FROM Article a WHERE a.id=:id
//	TypedQuery<Article> query = em.createNamedQuery("Article.find", Article.class);		
//	query.setParameter("id", id);	
//	
//	return query.getSingleResult();
//}
//
//public void delete(Article item) {
//	em.getTransaction().begin();
//	em.remove(item);
//	em.getTransaction().commit();
//}
//public void delete(int id) {
//	Article item = find(id);
//	if(item!=null)
//		delete(item);
//}
//public void update(Article item) {
//	em.getTransaction().begin();
//	em.merge(item);
//	em.getTransaction().commit();
//}
//public void add(Article item) {
//	em.getTransaction().begin();
//	em.persist(item);
//	em.getTransaction().commit();
//}