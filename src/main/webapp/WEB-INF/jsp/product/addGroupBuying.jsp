<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="itemTop.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="java.util.Calendar"%>
<!DOCTYPE html>
<html>
<head>
<title>공동구매 물품 추가 입력 폼</title>
</head>
<style>
	div#addItemForm {
		position: absolute;
		left: 18%;
		border: none;
		padding: 20px;
	}
</style>
<body>
<div id = "addItemForm">
<h2>ADD ITEM</h2>
<hr width = "927px" align="left"><br><br>
	<spring:hasBindErrors name="GroupBuying" />

	<form:form modelAttribute="GroupBuying" method="post" enctype="multipart/form-data" action="step3.do?${_csrf.parameterName}=${_csrf.token}">
		
	정가 : <form:input type="text" path="listPrice" value="${listPrice}" />
	<form:errors path="listPrice"/> <br><br>
	
	마감 날짜 : 
	<form:input type="date" path="date"/>
	<form:input type="time" path="time"/> 
	<form:errors path="deadLine"/> 
	<br><br>
	
	상품 사진 추가 : <input type="file" name="file" /><br/><br/>
	   
	<a href="<c:url value='/shop/groupBuying/gobackItem.do'>
		         <c:param name="productId" value="${productId}"/>
		     </c:url>
		">[이전 단계로]</a> <input type="submit" value="다음 단계로" />
	</form:form>
</div>
</body>
</html>