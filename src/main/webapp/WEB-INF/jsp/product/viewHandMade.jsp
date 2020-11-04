<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="ItemHeader.jsp"%> 
<style>

	.review {
		padding: 50px;
	}
	
	table {
		width: 80%;
	}
	
	th, td {
	    border-bottom: 1px solid black;
	    border-collapse: collapse;
	    text-align: center;
	    font-size: medium;
	    padding: 15px;
	}

	.product-info {
		font-size: 15px;
		padding-bottom: 10px;
		align-items: center;
	
	}
	#badge {
		padding: 5px 10px 5px 10px;
		margin-right: 30px;
		font-size: 15px;
		min-width: 100px;
		background-color: #29403C;
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
/*        $("#result").html("<div>"); */
       // var index = 1;
       var obj = responseJson;
       $("#result").append("<table>" +
                  "<tr><td>평점</td>"+
                  "<td>구매자</td>" + 
                  "<td>리뷰</td></tr>");

		if(obj.length == 0) {   
			//리뷰가 존재하지 않을 경우
			$("#result > table").append("<tr><td colspan='3'>작성된 리뷰가 없습니다.</td></tr></table>");   
		} else {
			for (var i in obj) {
				$("#result > table").append("<tr><td>" + obj[i].rating + "점</td><td>익명</td><td>" + 
				     obj[i].description + "</td></tr>");
			}
		}
		$("#result > table").append("<tr><td colspan='3'style='border-bottom: hidden; padding-top: 50px;'>" + 
					"<a href='<c:url value='/shop/AllReviewList.do?itemId=" + itemId + "'/>'> <span class='badge badge-pill badge-dark' id='badge'> 모든 리뷰 보기 </span></a>&nbsp;&nbsp;" + 
						
					"<a href='<c:url value='/shop/goAddReview.do?itemId=" + itemId + 
					"'/>'> <span class='badge badge-pill badge-dark' id='badge'>리뷰 작성하기</span> </a></td></tr></table></div>");
	    }, error: function(request,status,error){
	            alert("code = "+ request.status + " message = " + request.responseText);
	    }
    });
 };
</script>

    <div class="breadcumbs">

        <div class="container">

            <div class="row">

                <span>Home > </span>

                <span>Category > </span>

                <span>HandMade > </span>

                <span>${handMade.title}</span>

            </div>

        </div>

    </div>  

    <div class="short-description">

        <div class="container">

            <div class="row">

                <div class="col-md-6">

                    <div class="product-thumbnail">

                        <div class="col-md-10 col-sm-10 col-xs-10">

							<!-- Image -->
							<!-- 메인 이미지 -->
							
                            <div class="thumb-main-image">
                            	<c:if test="${item.imgUrl eq null}">
									<img src="${pageContext.request.contextPath}/images/picture.png" alt="" class="thumbnail">
								</c:if>
								<c:if test="${item.imgUrl ne null}">
									<img src="getImage.do?itemId=${handMade.itemId}" class="thumbnail" onerror="this.src='${pageContext.request.contextPath}/images/picture.png'" />
								</c:if>
              				</div>
   	
                        </div>

                    </div>

                    <div class="clearfix"></div>

                </div>

                <div class="col-md-6">
                	<!-- ViewCount -->
					<div class="product-info">
						<span class="strong-text"> 
							<c:out value="${handMade.viewCount}" /><font color=gray>view</font>
						</span>
					</div>

                    <!-- Title -->
                    <div class="product-info">
                    	<h1 class="product-title"><c:out value="${handMade.title}" /></h1>
                    </div>
					<hr>
		   			<!-- UserId -->
		   			<div class="product-info">
		   				<span class="badge badge-pill badge-dark" id="badge">판매자</span>
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
							              	<img src="${pageContext.request.contextPath}/images/alert.png" width="25" height="25"/>
							                         판매자 신고하기
							            </a>
						            </span>
								</c:otherwise>
							</c:choose>
						</c:if>
					</div> <!-- userId = suppId -->
					
                    <div class="product-info">
	
						<!-- ItemId -->
                        <span class="product-id">
                        	<span class="badge badge-pill badge-dark" id="badge">제품명</span>
	                        <c:out value="${handMade.itemId}" />
	                    </span>
	                </div>
					<div class="product-info">
						<!-- Quantity -->
                        <span class="product-avilability">
                        	<span class="badge badge-pill badge-dark" id="badge">재고 여부</span>
						   		<c:if test="${handMade.qty <= 0}">
								    품절
								</c:if> 
								<c:if test="${handMade.qty > 0}">
								    <fmt:formatNumber value="${handMade.qty}" /> 개 남았습니다.
								</c:if>
                        	</span>
                    </div>

                    <div class="product-info">
                    	<!-- Description -->
                        <span class="badge badge-pill badge-dark" id="badge">제품 설명</span>
						<p style="padding: 20px; "><c:out value="${handMade.description}" escapeXml="false" /></p>
                    </div>

                    <div class="price">

                        <span><c:out value="${handMade.unitCost}" /> 원</span>

                    </div>

                    <form action="" class="purchase-form">

                       <div class="qt-area">

                           <i class="fa fa-minus"></i>

                           <input name="quantity" class="qt" value="1">

                           <i class="fa fa-plus"></i>

                       </div>

	                    <c:if test="${handMade.qty > 0}">	
					   		<span> 				
						   		<a href="<c:url value="/shop/addItemToCart.do">
									     <c:param name="workingItemId" value="${handMade.itemId}"/>
									     <c:param name="productId" value="${handMade.productId}"/></c:url>">
									<button class="btn btn-theme" type="button">장바구니 추가</button>
								</a>
							</span>
				   		</c:if>
				   		<c:if test="${handMade.qty <= 0}">	
					   		<span> 				
								<button class="btn btn-theme" type="button">품절</button>
							</span>
				   		</c:if>

                    </form>

					<!-- Tags -->
                    <div class="product-info">
                    	<span class="badge badge-pill" id="badge">태그</span>
                    	<br><br>
                    	<span>
	                        <c:forEach var="tag" items="${tags}">      
					   			<a href='<c:url value="/shop/search/viewItem.do">
					   			<c:param name="tagName" value="${tag.tagName}"/></c:url>' class="badge" style="background-color: #40BEA7; padding: 5px 10px 5px 10px; font-size: 15px;">
					   			#${tag.tagName}
								</a>&nbsp;
							</c:forEach>
						</span>
					</div>

			   		<c:if test="${userSession.account.userId eq handMade.userId}">
						<a href="<c:url value='/shop/handMade/edit.do'>
									<c:param name="itemId" value="${handMade.itemId}" />
							    </c:url>
							 	">[게시물 수정하기]</a>
					    <a href="<c:url value='/shop/handMade/deleteItem.do'>
							   		<c:param name="productId" value="${handMade.productId}" />
							   		<c:param name="itemId" value="${handMade.itemId}" />
							   	</c:url>
							   	"> [게시물 삭제하기]</a>
					</c:if>

                    <ul class="product-info-btn">

                        <li><a href=""><i class="fa fa-heart-o"></i> Wishlist</a></li>

                        <li><a href=""><i class="fa fa-arrows-h"></i> Compare</a></li>

                        <li><a href=""><i class="fa fa-envelope-o"></i> Email</a></li>

                        <li><a href=""><i class="fa fa-print"></i> Print</a></li>

                    </ul>
                    
                </div>

            </div>

        </div>

    </div> 

    <div class="container">

        <div class="row">

            <div class="single-product-tabs">

                <ul class="nav nav-tabs nav-single-product-tabs">

                    <li class="active"><a href="#reviews" data-toggle="tab">Reviews</a></li>

                </ul>

                <div class="tab-content">

                    <div class="tab-pane active" id="reviews" align="center">

						<!-- Review -->
						<form name="pform" action="">
							<div class="review">
								<script>getReview(${handMade.itemId});</script>
								<div id="result"></div>
							</div>
						</form>
						
					</div>

                </div>

            </div>

        </div>

    </div>
    

<%@ include file="../IndexBottom.jsp"%>