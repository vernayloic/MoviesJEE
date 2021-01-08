package com.eil.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.eil.model.User;
import com.eil.model.UserRepository;

@WebServlet("/identify")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger.getLogger(LoginServlet.class);
	
	private UserRepository repository = new UserRepository();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = (String) request.getParameter("action");
		if(action.equals("logout")) {
			HttpSession session = request.getSession();
			
			session.setAttribute("user", null);
			session.setAttribute("message", "");	
			
			response.sendRedirect("./main");
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = (String) request.getParameter("action");
		
		if(action.equals("login")) {
			//1 - gestion login
			String login = request.getParameter("login");
			String password = request.getParameter("password");
			
			logger.info(login+" "+password);
			HttpSession session = request.getSession();
			
			//tester infos login
			User user = repository.Check(login, password);
			
			session.setAttribute("user", user);	//stocker utilisateur courant (ou null si non connecté) dans Session!
			session.setAttribute("message", "");	
			if(user!=null) {
				//user authentifié! (login+password ok!!)
				
				//redirection vers MainServlet (vue 'welcome')				
				response.sendRedirect("./main");
			}else {
				
				//enregister message dans Session!
				session.setAttribute("message", "Login/Password non valide(s)!");				
				response.sendRedirect("./main?page=login");
			}
			
		}
		else if(action.equals("signup")) {
			//2 - gestion inscription..
			// TODO
		}
		
	}

}
