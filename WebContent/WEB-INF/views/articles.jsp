<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.eil.model.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="shared/header.jsp"></jsp:include>
<div role="main" class="container" style="margin-top: 100px;">
	
	<c:if test="${action!=null}">
		<!--div class="alert alert-warning">${action} : ${item}</div-->
	</c:if>
	
	<!-- Form Add / Edit Article -->
	<c:if test="${action=='add' || action=='edit'}">
		<form
			action="<%=request.getContextPath()%>/articles?action=${action}"
			method="post">
			<div class="form-group">
				<input type="hidden" class="form-control" name="id"
					value="${item.id}">
			</div>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="Nom"
					value="${item.nom}" name="nom" required="required"
					onchange="save_value('temp-name','name',this.value)">
			</div>
			<div class="form-group">
				<textarea class="form-control" placeholder="Descriptif" rows="5"
					name="descriptif">${item.descriptif}</textarea>
			</div>
			<div class="form-group">
				<input type="number" step="any" class="form-control"
					placeholder="Prix" value="${item.prix}" name="prix"
					required="required"
					onchange="save_value('temp-price','price',this.value)">
			</div>
			<div class="form-group">
				<input type="number" step="any" class="form-control"
					placeholder="Prix" value="${item.stock}" name="stock"
					required="required"
					onchange="save_value('temp-price','stock',this.value)">
			</div>
			<!--  
			<div class="form-group">
				<input type="text" class="form-control" placeholder="Photo"
					value="${item.photo}" id="image-url" name="photo" readonly>
				<span class="input-group-btn"> <span
					class="btn btn-default btn-file"
					style="left: 180px; top: -45px; overflow: hidden"> <a
						href="#uploadModal" class="nav-item nav-link " data-toggle="modal"><i
							class="fa fa-upload"></i></a>
				</span>
				</span>
			</div>
			<div class="form-group"
				style="text-align: center; margin-top: -60px;">
				<img id='article-img-preview' class="img-preview" src="" />
			</div>
			-->
			<div class="form-group">
				<input type="submit" class="btn btn-primary btn-block btn-lg"
					value="${action=='add' ? 'Ajouter' : 'Modifier'}">
			</div>
		</form>
	</c:if>

	<!-- Form Delete Article (Confirmation) -->
	<c:if test="${action=='delete'}">
		<!-- Form Delete / Article -->
		<div class="alert alert-warning">
			Etes-vous sûr de vouloir supprimer l'article : ${item}?

			<form class="form-inline mt-2 mt-md-0" method="POST"
				action="./articles?action=delete&id=${item.id}">
				<button class="form-control btn btn-outline-danger my-2 my-sm-0"
					type="submit">Delete!</button>
				&nbsp;&nbsp; <a
					href="<%=request.getContextPath()%>/articles"
					class="form-control btn btn-outline-success my-2 my-sm-0">Cancel</a>
			</form>
		</div>
	</c:if>

	<!-- Fiche Article -->
	<c:if test="${action=='detail'}">
		<!-- Card -->
		<div class="alert alert-secondary"
			style="max-width: 75%; margin: auto">

			<div style="float: left; padding: 5px;">
				<img class="card-img-top"
					src="<%=request.getContextPath() %>/assets/photos/${item.photo}" />
				<a href="#!"> <span class="mask rgba-white-slight"></span>
				</a>
			</div>
			<div>

				<h4 class="card-title font-weight-bold">
					<a href="#">${item.nom}</a>
				</h4>

				<ul class="list-unstyled list-inline rating mb-0">
					<li class="list-inline-item mr-0"><i
						class="fa fa-star amber-text"></i></li>
					<li class="list-inline-item mr-0"><i
						class="fa fa-star amber-text"></i></li>
					<li class="list-inline-item mr-0"><i
						class="fa fa-star amber-text"></i></li>
					<li class="list-inline-item mr-0"><i
						class="fa fa-star amber-text"></i></li>
					<li class="list-inline-item"><i
						class="fa fa-star-half-o amber-text"></i></li>
					<li class="list-inline-item"><p class="text-muted">4.5
							(413)</p></li>
				</ul>
				<p class="mb-2">$ • American, Restaurant</p>

				<p class="card-text">${item.descriptif}</p>
				<hr class="my-4">
				<!-- <p class="lead"><strong>Tonight's availability</strong></p>
			    <ul class="list-unstyled list-inline d-flex justify-content-between mb-0">
			      <li class="list-inline-item mr-0">
			        <div class="chip mr-0">5:30PM</div>
			      </li>
			      <li class="list-inline-item mr-0">
			        <div class="chip deep-purple white-text mr-0">7:30PM</div>
			      </li>
			      <li class="list-inline-item mr-0">
			        <div class="chip mr-0">8:00PM</div>
			      </li>
			      <li class="list-inline-item mr-0">
			        <div class="chip mr-0">9:00PM</div>
			      </li>
			    </ul> -->
			</div>
		</div>
		<!-- Card -->
	</c:if>


	<!-- Affichage Panier -->
	<c:if test="${action=='cart'}">
		<div class="table-title">
			<div class="row">
				<div class="col-sm-6">
					<h3>Panier</h3>
				</div>
			</div>
		</div>
		<table class="table">
			<thead class="thead-dark">
				<tr>
					<th scope="col">#</th>
					<th scope="col">Nom</th>
					<th scope="col">Prix</th>
					<th scope="col">Quantité</th>
					<th scope="col"></th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<th colspan="5" style="text-align: right;"
						class="alert alert-success"><c:if test="${cart.size()==0}">
							<c:set var="total" value="0" />
						</c:if> <c:forEach items="${cart}" var="item">
							<c:set var="total" value="${total + item.qtite*item.prix}" />
						</c:forEach>
						<div style="overflow: hidden;">
							Total panier :
							<fmt:formatNumber type="number" maxFractionDigits="2"
								value="${total}" />
							€.
						</div></th>
				</tr>
			</tfoot>
			<tbody>
				<c:forEach items="${cart}" var="item">
					<tr>
						<th scope="row">${item.id} </th>
						<td><c:forEach items="${items}" var="article">
								<c:if test="${article.id==item.id}">
									<c:set var="name" value="${article.nom}" />
								</c:if>
							</c:forEach> ${name}</td>
						<td>${item.prix}€</td>
						<td>${item.qtite}</td>
						<td>
							<c:if test="${user!=null}">
								<button 
									class="btn btn-xs btn-danger pull-right"
                    				onclick="javascript:document.getElementById('cart-delete-${item.id}').submit()">
                    				<i class="material-icons">&#xE15C;</i> 
                    			</button>
                    		    <form class="form-inline mt-2 mt-md-0" id="cart-delete-${item.id}"
				              		method="POST"
									action="<%=request.getContextPath() %>/articles?action=cart-delete">
									<input type="hidden" value="${item.id}" name="id" />				
			                   </form>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>


	<!-- Liste Articles -->
	<c:if test="${action==null}">

			<div class="row">
				<div class="col-sm-6">
					<h3>Nos DvDs et BluRays</h3>
				</div>
				<div class="col-sm-6">
					<c:if test="${user!=null}">
						<a
							href="<%=request.getContextPath()%>/articles?action=add"
							class="btn btn-success"><i class="material-icons">&#xE147;</i>
							<span>Ajouter</span> </a>
					</c:if>
				</div>
			</div>
			
			<br>
			
			<div class="card-columns">
			
				<c:forEach items="${items}" var="item">
					
					<div class="card">
						  <img class="card-img-top" src="<%=request.getContextPath() %>/assets/photos/${item.photo}" alt="Card image cap">
						  <div class="card-body">
						    <h5 class="card-title">${item.nom}</h5>
						    <p class="card-text">${item.descriptif}</p>
						  </div>
						  <ul class="list-group list-group-flush">
						    <li class="list-group-item">Stock : ${item.stock} </li>
						    <li class="list-group-item">Prix : ${item.prix}€</li>
						    <li class="list-group-item"></li>
						  </ul>
							  	<div class="card-body">
							  		<form class="form-inline mt-2 mt-md-0" method="POST"
										action="<%=request.getContextPath() %>/articles?action=cart&id=${item.id}">
										<button class="form-control btn cart-button" title="Add Cart" data-toggle="tooltip" type="submit">
											<i class="fa fa-shopping-cart pl-0"></i> ++
										</button>
									</form>
									<c:if test="${user!=null}">
										<a
											href="<%=request.getContextPath() %>/articles?action=edit&id=${item.id}"
											class="edit" title="Edit" data-toggle="tooltip"><i
											class="material-icons">&#xE254;</i> </a>
										<a
											href="<%=request.getContextPath() %>/articles?action=delete&id=${item.id}"
											class="delete" title="Delete" data-toggle="tooltip"><i
											class="material-icons">&#xE872;</i> </a>
									</c:if>
								</div>		
					</div>
				</c:forEach>
			</div>
	</c:if>

</div>
<jsp:include page="shared/footer.jsp"></jsp:include>
