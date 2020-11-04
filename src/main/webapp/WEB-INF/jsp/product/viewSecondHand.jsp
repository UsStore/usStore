<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="itemTop.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script>
function getReview(itemId) {   //매개변수 전달 시도 
    var reqUrl = "/usStore/rest/shop/getReview.do/" + itemId;
     $.ajax({         /* Ajax 호출을 위해  JQuery 이용 */
       type: "get",
       url: reqUrl,
       processData: false,
       success: function(responseJson){   // responseJson: JS object parsed from JSON text
       $("#result").html("<div>");
          // var index = 1;
          var obj = responseJson;
          $("#result > div").append("<table>" +
                  "<tr><th style='border-bottom: none; text-align: left;'>평점"+
                  "</th><th style='border-bottom: none; text-align: left;'>구매자</th>" + 
                  "<th style='border-bottom: none; text-align: left;'>리뷰</th></tr><hr width = 100% align='left'></table>");

      	$("#result > div").append("<table>");
			if(obj.length == 0) {   $("#result > div").append("<tr><td>작성된 리뷰가 없습니다.</td></tr>");   }   //리뷰가 존재하지 않을 경우
			else {
				for (var i in obj) {
					$("#result > div").append("<tr><td style='text-align: left;'>" + obj[i].rating + 
											"점</td><td style='text-align: left;'>익명<td style='text-align: left; width: 80%'>" + 
						                     obj[i].description + "</td></tr>");
					}
			}
			$("#result > div").append("<tr><td colspan='2' style='border-bottom: hidden; text-align: left;'>" + 
						"<a href='<c:url value='/shop/AllReviewList.do?itemId=" + itemId + "'/>'> [모든 리뷰 보기] </a>&nbsp;&nbsp;" + 
						
						"<a href='<c:url value='/shop/goAddReview.do?itemId=" + itemId + 
						"'/>'> [리뷰 작성하기] </a></td></tr><br></table></div>");
	         },
	         error: function(request,status,error){
	            alert("code = "+ request.status + " message = " + request.responseText);
	         }
    });
 };
</script>
<html>
<head>
<title>중고거래 상세페이지</title>
</head>
<style type="text/css"> 
	a { text-decoration:none } 
</style> 
<style>
	.right-box {
	  float: right;
	  border-radius: 2em;
	  text-align: center;
	}
	
	span {
		width:10%; 
		height: 10px; 
		border: 1px solid blue;
		border-radius: 2em;
		font-size: small;
		text-align: center;
		padding: 5px;
	}
	
	table {
			border: none;
		 	text-align: center;
			font-size: medium;
			padding: 15px;
	}
	
	 th, td {
				border-bottom: 1px solid black;
			    border-collapse: collapse;
			    text-align: center;
			    font-size: medium;
			    padding: 15px;
	}

</style>
<body>
<!-- 여기서 secondHand는 컨트롤러에서 보내준 모델 객체(db에서 select 결과 ) -->

<table style="margin-left: auto; margin-right: auto;">
	<tr>
		<td style="text-align: left; padding: 0px; font-size: small; border-bottom: none;">
		${sh.viewCount}<font color=gray>view</font>
		</td>
	</tr>
   	<tr>
	   	<th style="border-right: 1px solid black; border-top: 1px solid black;">제목</th>
	   	<td style="border-top: 1px solid black;">${sh.title}</td>
   	</tr>	
   	<tr>
   		<th style="border-right: 1px solid black;">판매자</th>
   		<td>${sh.userId}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<c:if test="${sh.userId ne userSession.account.userId}">	
				<c:choose>
		   				<c:when test="${! empty userSession.account.userId}">
							<%@ include file="/WEB-INF/jsp/account/accuseFunction.jsp" %>
						</c:when>
						<c:otherwise>
						<span>
							<a href="<c:url value='/addAccuseNoLogin.do'>
						  			<c:param name="itemId" value="${sh.itemId}"/>
	                         		<c:param name="productId" value="${sh.productId}"/></c:url>">
	                         		판매자 신고하기</a>
	             		</span>
						</c:otherwise>
				</c:choose>
			</c:if>
   		</td>
   	</tr> 
   	<tr>
   		<td colspan="2" style="padding: 15px;">${sh.description}<br></td>
   	</tr>
   	<tr>
   		<th style="border-right: 1px solid black;">제품 사진</th>
        <td>
        	<img src="getImage.do?itemId=${sh.itemId}" width="350" height="230" onerror="this.style.display='none'" />
       		<br/>
        </td>
    </tr>
   	<tr>
   			<th style="border-right: 1px solid black;"><font color=blue>#</font>관련 태그</th>
   			<td>
   			<c:forEach var="tag" items="${tags}">        
	   			<a href='<c:url value="/shop/search/viewItem.do">
	   			<c:param name="tagName" value="${tag.tagName}"/></c:url>'>
	   			#${tag.tagName}
				</a>&nbsp;
			</c:forEach>
   			</td>
   	</tr>
   	<tr>
   			<th style="border-right: 1px solid black;">가격</th>
   			<td>
   				 인터넷 정가  : ${sh.listPrice}원<br>
   				 중고거래 판매가 : ${sh.unitCost}원 
   			</td>
   	</tr>
   	<tr>
   			<th style="border-right: 1px solid black;">에눌가능여부</th>
   			<c:choose>
	   				<c:when test="${sh.discount eq 1}">
						<td><c:out value="에눌 가능" /></td> 
					</c:when>
					<c:otherwise>
						<td> <c:out value="에눌 불가능" /></td> 
					</c:otherwise>
			</c:choose>
   	</tr>
   	<tr>
   		<th style="border-right: 1px solid black;">수량 </th> 
   		<td>
	   			<c:if test="${sh.qty <= 0}">
			        <button type="button" class="btn btn-outline-danger">품절</button>	
			    </c:if> 
			    <c:if test="${sh.qty > 0}">
			        <font size="2"><fmt:formatNumber value="${sh.qty}" /> 개 남았습니다.</font>
			    </c:if>
	   </td>
   	</tr>	
   	<tr>
   		<th style="border-right: 1px solid black;">판매자 대학교</th> 
   		<td>
   			${university}
   		</td>
   	</tr>
   	<c:if test="${sh.qty <= 0}">
   			<tr>
   				<td colspan="2" style="border-bottom: none;">
   					<span>	
   						<a href="<c:url value="/shop/addItemToCart.do">
					     	<c:param name="workingItemId" value="${sh.itemId}"/>
					     	<c:param name="productId" value="${sh.productId}"/></c:url>">
					 			장바구니 추가</a>
					</span>	
				</td>	
			</tr>
	</c:if>	
   	<c:if test="${sh.userId eq userSession.account.userId}"> <!-- 로그인시 실행 -->
		<tr>   		
				<td colspan="2" style="text-align: right; padding: 0px; font-size: small; border-bottom: none; border-top: 1px solid black;">
				   <a href="<c:url value='/shop/secondHand/edit.do'>
				   				<c:param name="itemId" value="${sh.itemId}" />
				   			</c:url>
				   			">[게시물 수정하기]</a>
				   <a href="<c:url value='/shop/secondHand/delete.do'>
				   				<c:param name="itemId" value="${sh.itemId}" />
				   				<c:param name="productId" value="${sh.productId}" />
				   			</c:url>
				   			"> [게시물 삭제하기]</a>
				</td>		
		</tr>
	</c:if>
	
	<tr>
		<td colspan="2"> 
			<a href='<c:url value="/chatting.do"/>'>판매자와 채팅하기 </a>
		</td>
	</tr>
</table><br>
<form name="pform" action="">
		<div style="font-size: 15px">
			<script>getReview(${sh.itemId});</script>
			<div id="result"></div>
		</div>
</form><br><br>
</body>
</html>