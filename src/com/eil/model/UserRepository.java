package com.eil.model;

import com.eil.dao.UserDao;

public class UserRepository extends UserDao {
	
	//	static List<User> users = Arrays.asList(
	//		new User(1, "James", "Bond","james","bond"),
	//		new User(2, "Jason", "Bourne","jason","bourne")
	//	);
	//	
	public User Check(String login, String password) {
		//		Optional<User> user = users.stream().filter(
		//				u -> u.getLogin().equals(login) && u.getPassword().equals(password)
		//		).findFirst();
		//		return user.isPresent()?user.get():null;	
		return super.log(login, password);
	}
}
