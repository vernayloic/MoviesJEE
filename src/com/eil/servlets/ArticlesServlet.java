package com.eil.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.eil.model.Article;
import com.eil.model.ArticleRepository;
import com.eil.model.CartLine;


@WebServlet("/articles")
public class ArticlesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger.getLogger(ArticlesServlet.class);	
	private ArticleRepository repository = new ArticleRepository();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");

		//		if(action.equalsIgnoreCase("cart")) {
		//			//paginate(request);			
		//		}
		//		else 
		
		if(action!=null) {
			if(action.equalsIgnoreCase("edit") || action.equalsIgnoreCase("delete")) {
				try {
					int id = Integer.parseInt(request.getParameter("id"));
					Article item = repository.find(id);

					//request.getSession().setAttribute("item", item);
					request.setAttribute("item", item);
				} catch (Exception e) {
					logger.error("Error = "+e);		
				}
			}
			else if(action.equalsIgnoreCase("add")) {
				//				if(request.getSession().getAttribute("item")==null)
				//					request.getSession().setAttribute("item", new Article());

				//equest.getSession().setAttribute("newItem", new Article());
				request.setAttribute("item", new Article());
			}else if(action.equalsIgnoreCase("detail")) {
				try {

					int id = Integer.parseInt(request.getParameter("id"));
					Article item = repository.find(id);

					request.setAttribute("item", item);
				} catch (Exception e) {
					logger.error("Error = "+e);		
				}
			}
			
			
		}

		display(action, request, response);
	}

	private void display(String action, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

//		List<Article> items = repository.list();			
//		request.setAttribute("items", items);
		
		paginate(request); //envoi data avec pagination!!
		
		request.setAttribute("action", action); //permet de distinguer affichage dans vue (articles.jsp)
		request.getRequestDispatcher("WEB-INF/views/articles.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");

		if(action.equalsIgnoreCase("delete")) {
			try {
				logger.info("action delete!");

				int id = Integer.parseInt(request.getParameter("id"));
				Article item = repository.find(id);

				if(item!=null)
					repository.delete(item);

				display(null, request, response);
			} catch (Exception e) {
				logger.info("action delete ==> Error : "+e);
			}
			display(null, request, response);
		}else if(action.equalsIgnoreCase("add")) {

			try {
				logger.info("action add!");

				//request.getParameter("photo")
				Article item = new Article(0, request.getParameter("nom"), request.getParameter("descriptif"),"",
						Float.parseFloat(request.getParameter("prix").replace(",",".")),Integer.parseInt(request.getParameter("stock"))
						);

				repository.add(item);

				request.getSession().setAttribute("item", new Article());
				
				display(null, request, response);

			} catch (Exception e) {
				logger.info("action add ==> Error : "+e);				
			}
		}else if(action.equalsIgnoreCase("edit")) {
			try {
				logger.info("action edit : "+request.getParameter("id"));

				Article item = new Article(Integer.parseInt(request.getParameter("id")), 
						request.getParameter("nom"), request.getParameter("descriptif"),"",
						Float.parseFloat(request.getParameter("prix").replace(",",".")),Integer.parseInt(request.getParameter("stock"))
						);

				repository.update(item);
				request.getSession().setAttribute("item", new Article());
				
				display(null, request, response);

			} catch (Exception e) {
				logger.info("action update ==> Error : "+e);				
			}
		}else if(action.equals("cart")) {
			//gestion panier : ajout article dans Panier!

			int id = Integer.parseInt(request.getParameter("id"));
			logger.info("Ajout article ID="+id+" dans Panier!");

			HttpSession session = request.getSession();
			ajoutPanier(session, id);	

			//(ré)afficher vue articles
			display(null, request, response);

		}else if(action.equals("cart-delete")) {
			//gestion panier : supprimer article dans Panier!

			int id = Integer.parseInt(request.getParameter("id"));
			logger.info("Delete article ID="+id+" dans Panier!");

			HttpSession session = request.getSession();
			supprimerPanier(session, id);	

			//(ré)afficher vue panier
			display("cart", request, response);
		}		

	}
	private void supprimerPanier(HttpSession session, int id) {
		@SuppressWarnings("unchecked")
		List<CartLine> cart = (List<CartLine>) session.getAttribute("cart");	
		for (CartLine cartLine : cart) {
			if(cartLine.getId()==id) {
				cart.remove(cartLine);
				break;
			}
		}
		session.setAttribute("cart", cart);	
	}

	@SuppressWarnings("unchecked")
	private void ajoutPanier(HttpSession session , int id) {		
		List<CartLine> cart; //panier
		//récup/création panier
		if(session.getAttribute("cart")==null) {
			//panier n'existe pas..donc création!
			session.setAttribute("cart", new ArrayList<CartLine>());
		}
		cart = (List<CartLine>) session.getAttribute("cart");	
		//ajout article dans panier et sauvegarder dans Session
		boolean found = false;
		for (CartLine cartLine : cart) {
			if(cartLine.getId()==id) {
				cartLine.setQtite(cartLine.getQtite()+1);
				found = true;
				break;
			}
		}
		if(!found) {
			Article a = repository.find(id);
			float prix = (a==null)? 0f : a.getPrix();
			cart.add(new CartLine(id, 1, prix));
		}
		session.setAttribute("cart", cart);
	}
	
	
	static int items_by_page_count = 3;
	static int current_page = 1;
	int pages_count = 0;	

	private void paginate(HttpServletRequest request) {		
		List<Article> items = repository.list();				

		int items_count = items.size();		
		pages_count = (items_count / items_by_page_count) + ((items_count % items_by_page_count)>0?1:0);

		int num_page =1;
		try {
			num_page = Integer.parseInt(request.getParameter("n"));
		} catch (Exception e) {}

		if(num_page>=1 && num_page<=pages_count)
			current_page=num_page;


		int index_last = current_page * items_by_page_count;
		int index_first = index_last - items_by_page_count;


		if(items_count<index_last)
			index_last = items_count;

		logger.info("********************************");	
		logger.info("Pagination ==> pages count : "+pages_count);	
		logger.info("Pagination ==> current page : "+current_page);	
		logger.info("Pagination ==> index : "+index_first+" - "+index_last);	
		logger.info("********************************");

		request.setAttribute("current_page", current_page); 
		request.setAttribute("pages_count", pages_count); 
		request.setAttribute("items_count", items_count);

		request.setAttribute("items", items.subList(index_first, index_last)); 
	}

}
