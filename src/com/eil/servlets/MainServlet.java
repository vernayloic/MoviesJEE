package com.eil.servlets;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.eil.model.User;
import com.eil.model.UserRepository;

/**
 * Servlet implementation class MainServlet
 */
@WebServlet(
		description = "Servlet Principale (Controller)", 
		urlPatterns = { "/MainServlet", "/main" })
public class MainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//gestion des Logs!
	private static final Logger logger = Logger.getLogger(MainServlet.class);

	private static final String VIEWS_FOLDER = "WEB-INF/views/";
	private static final String VIEW_SUFFIX =".jsp";

	public MainServlet() {
		logger.info("Chargement MainServlet!");
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		logger.info("MainServlet : doGet!");

		//PrintWriter out = response.getWriter();
		//response.getWriter().append("Réponse de la Servlet (GET) : ok! context = ").append(request.getContextPath());

		String nom =  (String) request.getParameter("nom"); 
		//	response.getWriter().append("Réception Appel (Get) OK! champ 'nom' = "+nom);

		
		/*
		 * Redirection vers nouvelle Vue!
		 */
		String page =  (String) request.getParameter("page"); 
		if(page==null)
			page = "welcome";

		String view_name = VIEWS_FOLDER+(page==null?"welcome":page)+VIEW_SUFFIX;
		
		if(!view_exist(view_name)) {
			//définir data à envoyer à la vue!
			request.setAttribute("code", 404);
			request.setAttribute("message", "la vue demandée '"+view_name+"' n'existe pas!");
			
			page = "Error";
			view_name = VIEWS_FOLDER+"error"+VIEW_SUFFIX;;
		}

		request.setAttribute("title", page.substring(0,1).toUpperCase()+page.substring(1).toLowerCase());
		request.setAttribute("nom", nom);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(view_name); //préparer redirection vers vue..
		dispatcher.forward(request, response); //..déclencher afficher nouvelle vue
	}
	private boolean view_exist(String view_name) {
		String view_fullpath = getServletContext().getRealPath(view_name);	
		try {			
			File view_file = new File(view_fullpath);	 
			return view_file.exists();
		} catch (Exception e) {}	
		return false;
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		logger.info("MainServlet : doPost!");

		//doGet(request, response);

		String nom =  (String) request.getParameter("nom"); //récup. paramètre de formulaire (name='nom')

		//response.getWriter().append("Réponse de la Servlet (POST) : ok! context = ").append(request.getContextPath());
		response.getWriter().append("Réception Form OK! champ 'nom' = "+nom);
	}

}
