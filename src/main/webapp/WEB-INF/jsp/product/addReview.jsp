<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="itemTop.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
	<form:form modelAttribute="review" method="post" action="checkReview.do?itemId=${itemId}&score=${score}">
	
		<font size="6px">"${title}"</font>&nbsp;&nbsp;&nbsp;상품은 어떠셨나요?<br><br>
		
		별점 : &nbsp;&nbsp;
		<div class="star-box">
		  <span class="star star_left"></span>
		  <span class="star star_right"></span>
		
		  <span class="star star_left"></span>
		  <span class="star star_right"></span>
		
		  <span class="star star_left"></span>
		  <span class="star star_right"></span>
		
		 <span class="star star_left"></span>
		 <span class="star star_right"></span>
		
		 <span class="star star_left"></span>
		 <span class="star star_right"></span>
		</div>
		
		<script>
			//star rating 0 - 9 -> 각 0.5점씩 총 5점
				$(".star").on('click',function(){
				  var idx = $(this).index();
				  $(".star").removeClass("on");
				  for(var i=0; i<=idx; i++){
				      $(".star").eq(i).addClass("on");
				  }
				  alert("idx: " + idx);
	
//				  window.open('/usStore/shop/review.do?itemId=' + itemId + '&score=' + idx); //점수를 form score 로 제출해주기
				});	
		</script>
		<br>
		
		리뷰 : <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<form:textarea path="description" placeholder="내용을 입력하세요." cols="50" rows="10" />
		<form:errors path="description"/> <br><br>
				
		<input type="submit" value="다음 단계로" />
	</form:form>
	</div>
</body>
</html>