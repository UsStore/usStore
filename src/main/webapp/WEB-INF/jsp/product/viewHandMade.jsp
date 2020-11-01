<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="itemTop.jsp" %>
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
		width: 10%;
		height: 10px;
		border: 1px solid blue;
		border-radius: 2em;
		font-size: small;
		text-align: center;
		padding: 5px;
	}
	
	table #item-detail {
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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script>
   function getReview(itemId) {   //매개변수 전달 시도 
      var reqUrl = "/usStore/rest/shop/getReview.do/" + itemId;
       $.ajax({         /* Ajax 호출을 위해  JQuery 이용 */
         type: "get",
         url: reqUrl,
         processData: false,
         success: function(responseJson){   // responseJson: JS object parsed from JSON text
         $("#result").html("<div><div id = 'addItemForm'>");
            // var index = 1;
            var obj = responseJson;
            $("#result > div").append("<table>" +
                    "<tr><th style='border-bottom: none; text-align: left;'>평점"+
                    "</th><th style='border-bottom: none; text-align: left;'>구매자</th>" + 
                    "<th colspan='2' style='border-bottom: none; text-align: left;'>리뷰</th></tr><hr width = '800px' align='left'>");

         if(obj.length == 0) {   $("#result > div").append("<tr><td colspan='4'>작성된 리뷰가 없습니다.</td></tr>");   }   //리뷰가 존재하지 않을 경우
         else {
            for (var i in obj) {
               $("#result > div").append("<tr><td style='text-align: left;'>" + obj[i].rating + 
                                 "점</td><td style='text-align: left;'>익명<td colspan='2' style='text-align: left;'>" + 
                                       obj[i].description + "</td></tr>");
               }
         }
         $("#result > div").append("<tr><td colspan='2' style='border-bottom: hidden; text-align: left;'>" + 
                  "<a href='<c:url value='/shop/AllReviewList.do?itemId=" + itemId + "'/>'> >모든 리뷰 보기</a></td>" + 
                  "<td colspan='2' style='border-bottom: hidden; text-align: right;'>" + 
                  "<a href='<c:url value='/shop/goAddReview.do?itemId=" + itemId + 
                  "'/>'> 리뷰 작성하기 </a></td></tr><br></table></div></div>");
            },
            error: function(request,status,error){
               alert("code = "+ request.status + " message = " + request.responseText);
            }
      });
   };
</script>

<body>
	<table id="item-detail" style="margin-left: auto; margin-right: auto;">
	<tr>
		<!-- ViewCount -->
		<td style="text-align: left; padding: 0px; font-size: small; border-bottom: none;">
		 <c:out value="${handMade.viewCount}" /><font color=gray>view</font>
		</td>
	</tr>
		<!-- ItemId -->
	   	<tr>
   			<th style="border-right: 1px solid black; border-top: 1px solid black;">제품 번호</th>
   			<td style="border-top: 1px solid black;"><c:out value="${handMade.itemId}" /></td>
   		</tr>
   		<tr>
   			<!-- Title -->
	   		<th style="border-right: 1px solid black;">제목</th>
	   		<td><c:out value="${handMade.title}" /></td>
   		</tr>
   		
   		<tr>
   			<!-- UserId -->
   			<th style="border-right: 1px solid black;">판매자</th>
   			<td>
   				<c:out value="${handMade.userId}" />
   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<!-- 판매자 신고하기 -->
				<c:if test="${handMade.userId ne userSession.account.userId}">
					<c:choose>
		   				<c:when test="${! empty userSession.account.userId}">
							<%@ include file="/WEB-INF/jsp/account/accuseFunction.jsp" %>
						</c:when>
						<c:otherwise>
							<span>
								<a href="<c:url value='/addAccuseNoLogin.do'>
					                 <c:param name="itemId" value="${handMade.itemId}"/>
					                 <c:param name="productId" value="${handMade.productId}"/></c:url>">
					                         판매자 신고하기</a>
				            </span>
						</c:otherwise>
					</c:choose>
				</c:if>
			</td>
   		</tr> <!-- userId = suppId -->
   		
   		<tr>
   			<!-- Description -->
   			<td colspan="2" style="padding: 15px;"><c:out value="${handMade.description}" escapeXml="false" /><br></td>
   		</tr>
   		
   		<!-- Image -->
   		<tr>
            <th style="border-right: 1px solid black;">제품 사진</th>
            <td>
            <img src="getImage.do?itemId=${handMade.itemId}" width="350" height="230" onerror="this.style.display='none'" />
               <br/>
            </td>
        </tr>
         
   		<tr>
   			<th style="border-right: 1px solid black;"><font color=blue>#</font>관련태그</th>
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
   		<th style="border-right: 1px solid black;">판매가</th>
   			<td>
   				<c:out value="${handMade.unitCost}" /> 원
   			</td>
   		</tr>
   		
   		<tr>
   			<!-- Quantity -->
   			<th style="border-right: 1px solid black;">수량 </th> 
	   		<td>
	   			<c:if test="${handMade.qty <= 0}">
			        <button type="button" class="btn btn-outline-danger">품절</button>	
			    </c:if> 
			    <c:if test="${handMade.qty > 0}">
			        <font size="2"><fmt:formatNumber value="${handMade.qty}" /> 개 남았습니다.</font>
			    </c:if>
	   		</td>
   		</tr>
   		<c:if test="${handMade.qty <= 0}">	
	   		<tr>
	   			<td colspan="2" style="border-bottom: none;">
	   			<span> 				
		   				<a href="<c:url value="/shop/addItemToCart.do">
							     <c:param name="workingItemId" value="${handMade.itemId}"/>
							     <c:param name="productId" value="${handMade.productId}"/></c:url>">
							 장바구니 추가</a>		
				</span>
	   			</td>
	   		</tr>
   		</c:if>
   		<c:if test="${userSession.account.userId eq handMade.userId}">
	   		<tr>
		   		<td colspan="2" style="text-align: right; padding: 0px; font-size: small; border-bottom: none; border-top: 1px solid black;">
				   <a href="<c:url value='/shop/handMade/edit.do'>
				   				<c:param name="itemId" value="${handMade.itemId}" />
				   			</c:url>
				   			">[게시물 수정하기]</a>
				   <a href="<c:url value='/shop/handMade/deleteItem.do'>
				   				<c:param name="productId" value="${handMade.productId}" />
				   				<c:param name="itemId" value="${handMade.itemId}" />
				   			</c:url>
				   			"> [게시물 삭제하기]</a>
				</td>
			 </tr>
		</c:if>
   	</table>

	<!-- Review -->
	<br>
	<form name="pform" action="">
		<div style="font-size: 15px">
			<script>getReview(${gb.itemId});</script>
			<div id="result"></div>
		</div>
	</form>
	<br><br>
</body>
