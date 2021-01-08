<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//String title="Erreur";
%>

<jsp:include page="shared/header.jsp"></jsp:include>

<div role="main" class="container" style="margin-top:100px;">	
	<!--  
	<h3>Error : <%= request.getAttribute("code") %></h3>	
	<p><%= request.getAttribute("message") %></p>
	-->
	
	<h3>Error : ${code}</h3>	
	<p>${message}</p>
	
	<p>
	<%
		out.print("page d'erreur!");
	%>
	</p>
	<hr/>
	<a href="./">Retour</a>
</div>
	
<jsp:include page="shared/header.jsp"></jsp:include>