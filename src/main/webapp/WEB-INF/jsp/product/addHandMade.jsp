<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="itemTop.jsp" %>

<style>
	div #addHandMadeForm {
		position: absolute;
		left: 18%;
		border: none;
		padding: 20px;
	}
</style>
<div id="addHandMadeForm">
<h2>ADD HANDMADE</h2>
<hr width = "927px" align="left"><br><br>
	<spring:hasBindErrors name="handMadeForm" />
    <form:form modelAttribute="handMadeForm" method="post" enctype="multipart/form-data" action="step3.do?${_csrf.parameterName}=${_csrf.token}">
	  원가: <form:input type="text" path="listPrice" value="${listPrice}"/>
	       <form:errors path="listPrice"/> <br>
	  
	  상품 사진 추가 : <input type="file" name="file" /><br/><br/>
	  
	   	<a href="<c:url value='/shop/handMade/gobackItem.do'>
		         <c:param name="productId" value="${productId}"/></c:url>">
		         이전 단계로</a>
	   <input type="submit" value="다음 단계로" />
   </form:form>
 </div>
</body>
</html>