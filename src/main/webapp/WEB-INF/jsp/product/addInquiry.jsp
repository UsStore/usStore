<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../ItemHeader.jsp"%> 
<script>
	function addReview() {
		 if (confirm("등록 후 수정이 불가능합니다.\n정말 게시글을 등록하시겠습니까?") == true){    //확인
		     document.addReviewfrm.submit();	//폼 제출
		 }else{   //취소
		     return false;
	 }
	}
</script>
<style>
	div#addInquiryForm {
		margin-left: 100px;
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
	
	#badge {
		padding: 10px 15px 10px 15px;
		margin-right: 30px;
		font-size: 20px;
		min-width: 100px;
		background-color: #29403C;
	}
	
	#submitButton {
		padding: 10px 15px 10px 15px;
		margin-right: 30px;
		font-size: 25px;
		min-width: 100px;
		background-color: #308C7B;
	}
	
	hr {
		background-color: #308C7B;
		height: 7px;
	}
</style>
<body>
	<div id="addInquiryForm">
		<h2>제품 문의하기</h2>
		<hr width="927px" align="left"><br>
	<spring:hasBindErrors name="rive" />
	<form:form modelAttribute="review" method="post" name="addReviewfrm" action="addReview.do?itemId=${itemId}">

			<font size="6px">"${title}"</font>&nbsp;&nbsp;&nbsp;상품은 어떠셨나요?<br>
			<br><br>
			<!-- Rating -->
			<div class="product-info">
				<span class="badge badge-pill badge-dark" id="badge">평점</span> <span>
					<form:select path="rating" style="width: 150px; height: 45px; font-size: 20px;">
						<form:options items="${ ratingOptions }" />
					</form:select>
				</span> <br> <br>
			</div>

			<!-- Review -->
			<div class="product-info">
				<span class="badge badge-pill badge-dark" id="badge">리뷰</span> <br>
				<br> <span> <form:textarea path="description" cols="100" rows="5" />
				<form:errors path="description" /> <br>
				<br>
				</span> <br> <br>
			</div>

			<div align="center">
			<button type="button" class="badge" id="submitButton" onclick="addReview()">리뷰 등록하기</button>
		</div>
	</form:form>
	</div>
</body>
</html>