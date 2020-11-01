<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="itemTop.jsp"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<style>
	div#addItemForm {
		position: absolute;
		left: 18%;
		border: none;
		padding: 20px;
	}
</style>
<title>경매 입력 폼</title>
</head>
<body>
<div id = "addItemForm">
<h2>ADD ITEM</h2>
<hr width = "927px" align="left"><br><br>
	<spring:hasBindErrors name="Auction" />

	<form:form modelAttribute="Auction" method="post" enctype="multipart/form-data" action="step3.do?${_csrf.parameterName}=${_csrf.token}">
		
	시작 가격 : <form:input type="int" path="startPrice" value="${startPrice}"/>
	<form:errors path="startPrice"/> <br>	
	
	마감 날짜 : <form:input type="date" path="date"/>
	<form:input type="time" path="time"/> 
	<form:errors path="deadLine"/> 
	<br>
	
	상품 사진 추가 : <input type="file" name="file" /><br/><br/>
	
	<a href="<c:url value='/shop/auction/gobackItem.do'>
		         <c:param name="productId" value="${productId}"/>
		     </c:url>
		">[이전 단계로]</a> <input type="submit" value="다음 단계로" />
	</form:form>
</div>	
</body>
</html>