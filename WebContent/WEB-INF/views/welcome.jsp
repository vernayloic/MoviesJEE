<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.eil.model.User"%>

<!-- Intégration JSTL (librairie tags) -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- inclure header -->
<jsp:include page="shared/header.jsp"></jsp:include>

<div role="main" class="container" style="margin-top: 100px;">
	<!--  
	<c:if test="${user==null}">
		<div class="alert alert-danger">
			<h5>Vous n'êtes pas identifié! veuillez vous connecter.</h5>
			<a href="<%=request.getContextPath()%>/main?page=login">Se
				Connecter</a>
		</div>
	</c:if>
	<c:if test="${user!=null}">
		<h3>Welcome ${user.prenom}!</h3>
		<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
			Doloribus suscipit ea reiciendis et iste quo temporibus quidem
			officia facere itaque libero velit illo quas. Non necessitatibus
			earum libero accusantium nihil.</p>
	</c:if>
-->
	<c:choose>
		<c:when test="${user==null}">
			<div class="alert alert-warning" style="max-width:60%;margin:auto;">
				<h6>Vous n'êtes pas identifié! veuillez vous connecter.</h6>
				<a href="<%=request.getContextPath()%>/main?page=login">Se
					Connecter</a>
			</div>
		</c:when>
		<c:otherwise>
			<h3>Bienvenue ${user.prenom}!</h3>
			<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
				Doloribus suscipit ea reiciendis et iste quo temporibus quidem
				officia facere itaque libero velit illo quas. Non necessitatibus
				earum libero accusantium nihil.</p>
		</c:otherwise>
	</c:choose>

</div>

<!-- inclure footer -->
<jsp:include page="shared/footer.jsp"></jsp:include>
