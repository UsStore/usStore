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

 function participation(price, unitCost, startPrice) {
		var p = parseInt(price);
		var u = parseInt(unitCost);
		var s = parseInt(startPrice);
		
		alert("입력 가격 : " + p);

		if ((p > s) && (p > u)) {
			var c = confirm("경매에 참여하시겠습니까?");

			if (c) {
				form.submit();
			}
			else {
				alert("참여 취소");
			}
		} else {
			alert("참여 금액이 적습니다.");
		}
	}
 
 function getTime() { 
    var time = "${auction.deadLine}";
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

                <span>Auction > </span>

                <span>${auction.title}</span>

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
                            	<c:if test="${auction.imgUrl eq null}">
									<img src="${pageContext.request.contextPath}/images/picture.png" alt="" class="thumbnail">
								</c:if>
								<c:if test="${auction.imgUrl ne null}">
									<img src="getImage.do?itemId=${auction.itemId}" class="thumbnail" onerror="this.src='${pageContext.request.contextPath}/images/picture.png'" />
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
							<c:out value="${auction.viewCount}" /><font color=gray>view</font>
						</span>
					</div>

                    <!-- Title -->
                    <div class="product-info">
                    	<h1 class="product-title"><c:out value="${auction.title}" /></h1>
                    </div>
					<hr>
		   			<!-- UserId -->
		   			<div class="product-info">
		   				<span class="badge badge-pill badge-dark" id="badge">판매자</span>
		   				<c:out value="${auction.userId}" />
		   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<!-- 판매자 신고하기 -->
						<c:if test="${auction.userId ne userSession.account.userId}">
							<c:choose>
				   				<c:when test="${! empty userSession.account.userId}">
									<%@ include file="/WEB-INF/jsp/account/accuseFunction.jsp" %>
								</c:when>
								<c:otherwise>
									<span>
										<a href="<c:url value='/addAccuseNoLogin.do'>
							                 <c:param name="itemId" value="${auction.itemId}"/>
							                 <c:param name="productId" value="${auction.productId}"/></c:url>">
							              	<img src="${pageContext.request.contextPath}/images/alert.png" width="25" height="25"/>
							                         판매자 신고하기
							            </a>
						            </span>
								</c:otherwise>
							</c:choose>
						</c:if>
					</div> <!-- userId = suppId -->

                    <div class="product-info">
                    	<!-- Description -->
                        <span class="badge badge-pill badge-dark" id="badge">제품 설명</span>
						<p style="padding: 20px; "><c:out value="${auction.description}" escapeXml="false" /></p>
                    </div>

                    <div class="price">
                        <span>
                        	<c:set var="state" value="${auction.auctionState}"/>
   							<c:if test="${state eq 0}">
   								<font color=#6495ED>경매 진행중</font>
   							</c:if>
   							<c:if test="${state eq 1}">
			   					<font color=#FF4500>경매 종료</font>
			   				</c:if>
                        </span>
                    </div>
                    
                    <div class="product-info" align="right">
                    		<p><font size="5"> 시작 가격 : ${auction.startPrice}원 </font></p>
			   				<c:set var="state" value="${auction.auctionState}"/>
			   				<c:if test="${state eq 0}">
			   					<c:set var="uc" value="${auction.unitCost}" />
			   					<c:if test="${uc eq 1}">
			   					<p><font size="5"> ▷미참여◁ </font></p>
			   					</c:if>
			   					<c:if test="${uc ne 1}">
			   					<p><font size="5"> 현재 최대 금액 : ${auction.unitCost}원 </font></p>
			   					</c:if>
			   				</c:if>
			   				<c:if test="${state eq 1}">
			   					<p><font size="5"> 낙찰 가격 : <ins></ins> ${auction.bidPrice}원 </font></p>
			   				</c:if>
			   				<br>
                    </div>
					<div class="alert alert-success" role="alert" align="center">
						<p>
							<c:set var="state" value="${auction.auctionState}" />
							<span class="badge badge-pill" id="badge">마감 날짜 : ${auction.deadLine}</span>
							<c:if test="${state eq 0}">
								<br>
								<br>경매 종료까지 "<font id=counter0></font>일 <font id=counter1></font>시간 <font
									id=counter2></font>분 <font id=counter3></font>초" 남았습니다
				   				</c:if>
							<c:if test="${state eq 0}">
								<script>getTime()</script>
							</c:if>
						</p>
					</div>
 				   		
						<c:if test="${state eq 0}">
			   				<br>
			   				<div class="product-info" align="center">
				   				<form name="form" action="<c:url value='/shop/auction/participateItem.do'/>">
				   					<input type="text" id="price" name="price" placeholder="참여 가격을 입력하세요."/>
									&nbsp;
									<span onclick="participation(price.value, ${auction.unitCost}, ${auction.startPrice})">
										<!-- 로그인 여부 따지기 -->
										<a href="#"><button class="btn btn-theme" type="button">경매 참여</button></a>
									</span>
								</form>
			   				</div>
						</c:if>
						<c:if test="${state eq 1}">
							<c:set var="id" value="${userSession.account.userId}"/>
							<c:set var="bidder" value="${bidder}"/>
							<c:if test="${id eq bidder}">
								<br><span>
								<!-- 로그인 여부 따지기 -->
								<c:set var="qty" value="${auction.qty}"/>
								<c:if test="${qty eq 0}">
									<button class="btn btn-theme" type="button">수량이 없습니다</button>
								</c:if>
								<c:if test="${qty ne 0}">
									<a href="<c:url value="/shop/addItemToCart.do">
										     <c:param name="workingItemId" value="${auction.itemId}"/>
										     <c:param name="productId" value="${auction.productId}"/></c:url>">
										 <button class="btn btn-theme" type="button">장바구니 추가</button></a>
								</c:if>
								</span>
							</c:if>
						</c:if>

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
				   	<c:if test="${userSession.account.userId eq auction.userId}">
						<a href="<c:url value='/shop/auction/updateItem.do?itemId=${auction.itemId}'>
							    </c:url>" style="color: black;">
							<button type="button" class="btn btn-lg btn-secondary" id="detailButton">게시물 수정하기</button></a>
						<a href="<c:url value='/shop/auction/deleteItem.do?itemId=${auction.itemId}'>
							   	</c:url>" style="color: black;">
							<button type="button" class="btn btn-lg btn-secondary" id="detailButton">게시물 삭제하기</button></a>
					</c:if>
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
								<script>getReview(${auction.itemId});</script>
								<div id="result"></div>
							</div>
						</form>
						
					</div>

                </div>

            </div>

        </div>

    </div>
    

<%@ include file="../IndexBottom.jsp"%>