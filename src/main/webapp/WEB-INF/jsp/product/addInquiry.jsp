<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../ItemHeader.jsp"%> 
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
		<h2>제품 문의</h2>
		<hr width="927px" align="left"><br>
	<spring:hasBindErrors name="rive" />
	<form:form modelAttribute="InquiryForm" method="post" action="addInquiry.do?itemId=${itemId}">

			<font size="6px">"${title}"</font>&nbsp;&nbsp;&nbsp;상품은 어떠셨나요?<br>
			<br><br>
			<!-- 비밀글 여부 -->
		<%-- 	<div class="product-info">
				<span class="badge badge-pill badge-dark" id="badge">비밀글 여부</span> 
			    <span>
			    	<form:radiobutton path="isSecret" style="margin-left:10px;" />
				</span> <br> <br>
			</div> --%>
			
			<!-- 문의 제묵 -->
			<div class="product-info">
				<span class="badge badge-pill badge-dark" id="badge">제목</span><br><br>
				<span> <form:textarea path="title" cols="100" rows="5" />
				<form:errors path="title" />
				</span> <br> <br>
			</div>

			<!-- 문의 내용 -->
			<div class="product-info">
				<span class="badge badge-pill badge-dark" id="badge">문의 사항</span> <br>
				<br> <span> <form:textarea path="content" cols="100" rows="5" />
				<form:errors path="content" /> <br>
				<br>
				</span> <br> <br>
			</div>

			<div align="center">
			<button class="badge" type="submit" id="submitButton"> 등록하기</button>
		</div>
	</form:form>
	</div>
</body>
</html>