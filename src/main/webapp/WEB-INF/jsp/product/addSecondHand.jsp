<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ include file="itemTop.jsp"%>
<style>
div#addItemForm {
	position: absolute;
	left: 18%;
	border: none;
	padding: 20px;
}
</style>
<div id="addItemForm">
	<h2>ADD ITEM</h2>
	<hr width="927px" align="left">
	<br>
	<br>

	<form:form modelAttribute="secondHandForm"  method="post" enctype="multipart/form-data" action="step3.do?${_csrf.parameterName}=${_csrf.token}">
		
	정가: <form:input type="text" path="listPrice" value="${listPrice}" />
		<form:errors path="listPrice" />
		<br>
		<br>
	
	가격 흥정 여부: 
		<form:radiobuttons items="${radioKind}" path="discount"/>
		<br><br>
	상품 사진 추가 : <input type="file" name="file" /><br><br>

		<a href="<c:url value='/shop/secondHand/gobackItem.do'>
		         <c:param name="productId" value="${productId}"/>
		     </c:url>">[이전 단계로]</a> 
		<input type="submit" value="다음 단계로" />
	</form:form>
</div>

</body>
</html>