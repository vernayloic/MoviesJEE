<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.eil.model.User" %>

<!-- Intégration JSTL (librairie tags) -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- inclure header -->
<jsp:include page="shared/header.jsp"></jsp:include>

<div role="main" class="container" style="margin-top:100px;">
${CartItems}
</div>

<!-- inclure footer -->
<jsp:include page="shared/footer.jsp"></jsp:include>	 
	 