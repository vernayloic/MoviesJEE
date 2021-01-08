<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.eil.model.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>${title}</title>

<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

<link rel="stylesheet" href="./assets/css/custom.css" media="all" />
<style>
.user-title{
	display: inline-block;
    margin-top: 5px;
    margin-right: 10px;
    font-size: 120%;
    color: greenyellow;
}
.badge {
    color: #fff !important;
 /*    border-radius: .125rem;
    -webkit-box-shadow: 0 2px 5px 0 rgba(0,0,0,0.16), 0 2px 10px 0 rgba(0,0,0,0.12); */
    box-shadow: 0 2px 5px 0 rgba(0,0,0,0.16), 0 2px 10px 0 rgba(0,0,0,0.12);
}
.red {
/*     background-color: #f44336 !important;*/
    font-size: 105%; 
}
.fa, .fas {
    font-weight: 900;
    font-size: 120%;
}
 
ul.dropdown-cart{
    min-width:250px;
}
ul.dropdown-cart li .item{
    display:block;
    padding:3px 10px;
    margin: 3px 0;
}
ul.dropdown-cart li .item:hover{
    background-color:#f3f3f3;
}
ul.dropdown-cart li .item:after{
    visibility: hidden;
    display: block;
    font-size: 0;
    content: " ";
    clear: both;
    height: 0;
}

ul.dropdown-cart li .item-left{
    float:left;
}
ul.dropdown-cart li .item-left img,
ul.dropdown-cart li .item-left span.item-info{
    float:left;
}
ul.dropdown-cart li .item-left span.item-info{
    margin-left:10px;   
}
ul.dropdown-cart li .item-left span.item-info span{
    display:block;
}
ul.dropdown-cart li .item-right{
    float:right;
}
ul.dropdown-cart li .item-right button{
    margin-top:5px;
}

ul.dropdown-cart 
{
	margin: .5rem -14rem 0;
}
.text-center {
    text-align: center !important;
}
.item-info{
	margin-right:5px !important;
}
.dropdown a:hover{
	text-decoration: none;
}
</style>

</head>
<body>
	<header>
		<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
			<a class="navbar-brand" href="./"> <img
				src="<%=request.getContextPath()%>/assets/images/ico.png" alt="logo"
				class="logo" />
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarCollapse" aria-controls="navbarCollapse"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarCollapse">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item"><a class="nav-link"
						href="./">Acceuil</a></li>
					<li class="nav-item"><a class="nav-link"
						href="<%=request.getContextPath()%>/main?page=about">A propos</a></li>
					<li class="nav-item"><a class="nav-link"
						href="<%=request.getContextPath()%>/main?page=contact">Contacts</a></li>
					<li class="nav-item"><a class="nav-link"
						href="<%=request.getContextPath()%>/articles">DVDs & BluRays</a></li>
				</ul>
			</div>


			<!-- Login/Logout -->
			<div class="navbar-nav ml-auto">

				

			</div>

			<!-- Panier -->
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">				
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-expanded="false"> <i
							class="fa fa-shopping-cart pl-0"></i> <span
							class="badge badge-pill red">(${cart.size()})</span>
						</a>				
						<ul class="dropdown-menu dropdown-cart" role="menu">
							<c:set var="total" value="0" />
							<c:forEach items="${cart}" var="cartline">
								<li>
				                  <span class="item">
				                    <span class="item-left">
				                        <img src="<%=request.getContextPath() %>/assets/photos/${item.photo}" style="height: 50px; right: 50px;" />
				                        <span class="item-info">				                        	
				                        	<c:forEach items="${items}" var="item">
				                        		<c:if test="${item.id==cartline.id}">
				                        			<c:set var="name" value="${item.nom}" />
				                        		</c:if>
				                        	</c:forEach>				                        	
				                            <span>${name}</span>
				                            <span>${cartline.qtite} | ${cartline.prix} €</span>
				                        </span>
				                    </span>
				                    <span class="item-right">
				                    	<button class="btn btn-xs btn-danger pull-right" onclick="">x</button>
				                    </span>
				                  </span>
				               </li>
				               <c:set var="total" value="${total + cartline.qtite*cartline.prix}" />			               
							</c:forEach>	
							<li class="divider"></li>
							<li class="text-center">Total : <fmt:formatNumber type="number" maxFractionDigits="2" value="${total}"/>€</li>
							<li class="text-center"><a href="<%=request.getContextPath() %>/articles?action=cart">Panier</a></li>
	
							<c:choose>
								<c:when test="${user==null}">
									<li class="text-center"> <a href="<%=request.getContextPath()%>/main?page=login">Se Connecter</a></li>
								</c:when>
								<c:otherwise>
									<li class="text-center"> <a href="<%=request.getContextPath()%>/main">Mon Compte</a></li>
									<li class="text-center"> <a href="<%=request.getContextPath()%>/identify?action=logout">Se Déconnecter</a></li>
								</c:otherwise>
							</c:choose>
						</ul>
					</li>
				</ul>

		</nav>
	</header>