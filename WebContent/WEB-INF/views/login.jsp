<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.form-control {
    display: inline !important;
    width: 93% !important;
}

</style>
<jsp:include page="shared/header.jsp"></jsp:include>
<div role="main" class="container" style="margin-top: 100px;">
	

	<form action="./identify?action=login" method="post">
		<h5>Veuillez vous identifier</h5>
		
		<c:if test="${message!=null and message!=''}">
			<div class="alert alert-warning">${message}</div>
		</c:if>
		
		<div class="form-group">
			<i class="fa fa-user"></i> <input type="text" class="form-control"
				placeholder="Login" name="login" required="required">
		</div>
		<div class="form-group">
			<i class="fa fa-lock"></i> <input type="password"
				class="form-control" placeholder="Password" name="password"
				required="required">
		</div>
		<div class="form-group">
			<input type="submit" class="btn btn-primary btn-block btn-lg"
				value="Login">
		</div>
	</form>
	
</div>
<jsp:include page="shared/footer.jsp"></jsp:include>
