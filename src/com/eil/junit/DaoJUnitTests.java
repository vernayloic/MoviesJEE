package com.eil.junit;

import static org.junit.Assert.assertNotEquals;

import java.util.List;

import javax.persistence.EntityManager;

import org.apache.log4j.Logger;
import org.junit.Assert;
import org.junit.Test;

import com.eil.dao.UserDao;
import com.eil.model.User;

public class DaoJUnitTests {
	private static final Logger logger = Logger.getLogger(DaoJUnitTests.class);
	
	@Test
	public void test() {
		UserDao dao = new UserDao();
		EntityManager em = dao.getEntityManager();
		
		Assert.assertNotNull(em);
		
		logger.info("******************************");
		logger.info("em="+em);
		logger.info("******************************");
	}
	@Test
	public void test2() {
		UserDao dao = new UserDao();
		EntityManager em = dao.getEntityManager();
		
		User u = new User();
		u.setPrenom("Homer");
		u.setNom("Simpson");
		dao.add(u);
		
		List<User> items= dao.list();
		assertNotEquals(items.size(), 0);

		logger.info("******************************");
		for (User user : items) {
			logger.info(user.getPrenom()+" "+user.getNom());
		}
		logger.info("******************************");
	}

}
