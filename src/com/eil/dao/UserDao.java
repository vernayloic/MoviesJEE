package com.eil.dao;

import javax.persistence.TypedQuery;

import com.eil.model.User;

public class UserDao extends Dao<User> {
	public UserDao() {
		super(User.class, "User");
	}
	
	
	//méthode(s) spécifique(s)
	public User log(String login, String password){		
		
		String query_command = "SELECT u FROM User u WHERE u.login=:login AND u.password=:password";
		
		TypedQuery<User> query =  getEntityManager().createQuery(query_command, User.class);
		query.setParameter("login", login);
		query.setParameter("password", password);

		try {
			return query.getSingleResult();
		} catch (Exception e) {
			return null;
		}	
	}
}
