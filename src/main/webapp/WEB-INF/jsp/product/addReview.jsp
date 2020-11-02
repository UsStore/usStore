<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="itemTop.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script>
	function addReview() {
		 if (confirm("등록 후 수정이 불가능합니다.\n정말 리뷰를 등록하시겠습니까?") == true){    //확인
		     document.addReviewfrm.submit();	//폼 제출
		 }else{   //취소
		     return false;
	 }
	}
</script>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>
</head>
<style>
div#addReviewForm {
	position: absolute;
	left: 18%;
	border: none;
	padding: 20px;
}

*{margin:0; padding:0;}
.star{
  display:inline-block;
  width: 30px;height: 60px;
  cursor: pointer;
}
.star_left{
  background: url(http://gahyun.wooga.kr/main/img/testImg/star.png) no-repeat 0 0; 
  background-size: 60px; 
  margin-right: -3px;
}
.star_right{
  background: url(http://gahyun.wooga.kr/main/img/testImg/star.png) no-repeat -30px 0; 
  background-size: 60px; 
  margin-left: -3px;
}
.star.on{
  background-image: url(http://gahyun.wooga.kr/main/img/testImg/star_on.png);
}
</style>
<body>
	<div id="addReviewForm">
		<h2>리뷰 작성</h2>
		<hr width="927px" align="left"><br>
	<spring:hasBindErrors name="review" />
	<form:form modelAttribute="review" method="post" name="addReviewfrm" action="addReview.do?itemId=${itemId}">
	
		<font size="6px">"${title}"</font>&nbsp;&nbsp;&nbsp;상품은 어떠셨나요?<br><br>
		
		<form:label path="rating">평점: </form:label>
	    	<form:select path="rating">
	        <form:options items="${ ratingOptions }"/>
    	</form:select>
		<br>
		
		리뷰 : <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<form:textarea path="description" placeholder="10자 이상 입력하세요." cols="50" rows="10" />
		<form:errors path="description"/> <br><br>
				
		<td id="submit" colspan="2">
     		<input id="button" type="button" value="리뷰 등록하기" onclick="addReview()">
 		</td>
	</form:form>
	</div>
</body>
</html>