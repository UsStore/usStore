<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../ItemHeader.jsp"%> 
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
	
	#detailButton {
		padding: 5px 10px 5px 10px;
		margin-right: 30px;
		font-size: 20px;
		min-width: 200px;
		font-color: black;
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

 function gbJoint(itemId) {
 	if(confirm("공동구매에 참여하시겠습니까?")){
 	    document.location.href="/usStore/shop/groupBuying/goCart.do?workingItemId=" + itemId + "&productId=0";	//확인 클릭
 	 }
 }
 
 function removeGb(itemId) {
 	if(confirm("정말 공동구매를 삭제하시겠습니까?")){
 	    document.location.href="/usStore/shop/groupBuying/delete.do?itemId=" + itemId;	//확인 클릭
 	 }
 }
 
 function editGb(itemId) {
 	if(confirm("공동구매를 수정하시겠습니까?")){
 	    document.location.href="/usStore/shop/groupBuying/edit.do?itemId=" + itemId;	//확인 클릭
 	 }
 }
 
 function getTime() { 
    var time = "${gb.deadLine}";
    var year = time.substring(0, 4);
    var month = time.substring(5, 7) - 1;
    var day = time.substring(8, 10);
    var hour = time.substring(11, 13);
    var minute = time.substring(14, 16);
    var second = time.substring(17);
    
	now = new Date(); 
	dday = new Date(year, month, day, hour, minute, second); 
	// 원하는 날짜, 시간 정확하게 초단위까지 기입.
	days = (dday - now) / 1000 / 60 / 60 / 24; 
	daysRound = Math.floor(days); 
	hours = (dday - now) / 1000 / 60 / 60 - (24 * daysRound); 
	hoursRound = Math.floor(hours); 
	minutes = (dday - now) / 1000 /60 - (24 * 60 * daysRound) - (60 * hoursRound); 
	minutesRound = Math.floor(minutes); 
	seconds = (dday - now) / 1000 - (24 * 60 * 60 * daysRound) - (60 * 60 * hoursRound) - (60 * minutesRound); 
	secondsRound = Math.round(seconds); 
	document.getElementById("counter0").innerHTML = daysRound; 
	document.getElementById("counter1").innerHTML = hoursRound; 
	document.getElementById("counter2").innerHTML = minutesRound; 
	document.getElementById("counter3").innerHTML = secondsRound; 
	newtime = window.setTimeout("getTime();", 1000); 

 } 
</script>

    <div class="breadcumbs">

        <div class="container">

            <div class="row">

                <span>Home > </span>

                <span>Category > </span>

                <span>GroupBuying > </span>

                <span>${gb.title}</span>

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
                            	<c:if test="${gb.imgUrl eq null}">
									<img src="${pageContext.request.contextPath}/images/picture.png" alt="" class="thumbnail">
								</c:if>
								<c:if test="${gb.imgUrl ne null}">
									<img src="getImage.do?itemId=${gb.itemId}" class="thumbnail" onerror="this.src='${pageContext.request.contextPath}/images/picture.png'" />
								</c:if>
              				</div>
   	
                        </div>

                    </div>

                    <div class="clearfix"></div>

                </div>

                <div class="col-md-6" style="padding-bottom: 50px;">
                	<!-- ViewCount -->
					<div class="product-info">
						<span class="strong-text"> 
							<c:out value="${gb.viewCount}" /><font color=gray>view</font>
						</span>
					</div>

                    <!-- Title -->
                    <div class="product-info">
                    	<h1 class="product-title"><c:out value="${gb.title}" /></h1>
                    </div>
					<hr>
		   			<!-- UserId -->
		   			<div class="product-info">
		   				<span class="badge badge-pill badge-dark" id="badge">판매자</span>
		   				<c:out value="${gb.userId}" />
		   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<!-- 판매자 신고하기 -->
						<c:if test="${gb.userId ne userSession.account.userId}">
							<c:choose>
				   				<c:when test="${! empty userSession.account.userId}">
									<%@ include file="/WEB-INF/jsp/account/accuseFunction.jsp" %>
								</c:when>
								<c:otherwise>
									<span>
										<a href="<c:url value='/addAccuseNoLogin.do'>
							                 <c:param name="itemId" value="${gb.itemId}"/>
							                 <c:param name="productId" value="${gb.productId}"/></c:url>">
							              	<img src="${pageContext.request.contextPath}/images/alert.png" width="25" height="25"/>
							                         판매자 신고하기
							            </a>
						            </span>
								</c:otherwise>
							</c:choose>
						</c:if>
					</div> <!-- userId = suppId -->
					
					<div class="product-info">
						<!-- Quantity -->
                        <span class="product-avilability">
                        	<span class="badge badge-pill badge-dark" id="badge">재고 여부</span>
						   		<c:if test="${gb.qty <= 0}">
								    품절
								</c:if> 
								<c:if test="${gb.qty > 0}">
								    <fmt:formatNumber value="${gb.qty}" /> 개 남았습니다.
								</c:if>
                        	</span>
                    </div>

                    <div class="product-info">
                    	<!-- Description -->
                        <span class="badge badge-pill badge-dark" id="badge">제품 설명</span>
						<p style="padding: 20px; "><c:out value="${gb.description}" escapeXml="false" /></p>
                    </div>

					<del>${gb.unitCost}원</del>
                    <div class="price">
                        <span>${gb.listPrice}원&nbsp;<font color=red>&nbsp;&nbsp;&nbsp;${gb.discount}% 할인</font></span>
                    </div>

                    <form action="" class="purchase-form">

                       <div class="qt-area">

                           <i class="fa fa-minus"></i>

                           <input name="quantity" class="qt" value="1">

                           <i class="fa fa-plus"></i>

                       </div>
				   		
				   		<c:if test="${gb.state == 0 && gb.userId ne userSession.account.userId}"> 
				   		<!-- 공동구매 진행중 && 작성자와 본인 아이디가 다르면 공동구매 참여 가능 -->
				           	 <span>
				                <a href="javascript:gbJoint(${gb.itemId})">
				               		<button class="btn btn-theme" type="button">공동구매 참여하기</button>
				                </a>
				             </span>
				        </c:if>
				        <c:if test="${gb.state == 1}">   <!-- 공동구매 마감 -->
				             <span>
				             	<button class="btn btn-theme" type="button"> 공동구매가 마감되었습니다.</button>
				             </span>
				        </c:if>
				        <c:if test="${gb.userId eq userSession.account.userId}">
				        	<span>
				             	<button class="btn btn-theme" type="button" disabled>공동구매 참여하기</button>
				             </span> 
				        </c:if>
				            
				       <br><br><br>
				       <div class="alert alert-success" role="alert" align="center">
						  	<span class="badge badge-pill" id="badge">마감 날짜 : ${gb.deadLine}</span>
						  <p>
						  	<c:set var="state" value="${gb.state}"/>
				        	<c:if test="${state eq 0}">
				            <br>공동구매 종료까지 "<font id=counter0></font>일 <font id=counter1></font>시간 <font id=counter2></font>분 <font id=counter3></font>초" 남았습니다
				            </c:if>
					        <c:if test="${gb.state eq 0}">
					           <script>getTime()</script>
					        </c:if>
						  </p>
						</div>
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
					
                    <ul class="product-info-btn">

                        <li><a href=""><i class="fa fa-heart-o"></i> Wishlist</a></li>

                        <li><a href=""><i class="fa fa-arrows-h"></i> Compare</a></li>

                        <li><a href=""><i class="fa fa-envelope-o"></i> Email</a></li>

                        <li><a href=""><i class="fa fa-print"></i> Print</a></li>

                    </ul>
                    
                </div>
                
                <div align="center">
                	<c:if test="${gb.userId eq userSession.account.userId}">
			            <tr>
			               <td colspan="2" style="text-align: right; padding: 0px; font-size: small; border-bottom: none; border-top: 1px solid black;">
			               <a href="javascript:editGb(${gb.itemId})" style="color: black;">
			               		<button type="button" class="btn btn-lg btn-secondary" id="detailButton">게시물 수정하기</button>
						   </a>
			               <a href="javascript:removeGb(${gb.itemId})" style="color: black;">
			               		<button type="button" class="btn btn-lg btn-secondary" id="detailButton">게시물 삭제하기</button>
			               </a>
			            </td>
			          </tr>
			      	</c:if>
					   <!--* 현재 로그인 user가 글 작성자 일때만 수정/삭제 버튼이 보임 
					   * 작성자 정보는 controller에서 model(db에서 suppId찾아옴)로 넘겨줌
					   * model로 넘어온 suppId와 세션의 로그인Id를 비교함 
					   * 세션에 로그인 정보가 없으면, 즉 null이어도 수정/삭제 안보여줌-->
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
								<script>getReview(${gb.itemId});</script>
								<div id="result"></div>
							</div>
						</form>
						
					</div>

                </div>

            </div>

        </div>

    </div>
    

<%@ include file="../IndexBottom.jsp"%>