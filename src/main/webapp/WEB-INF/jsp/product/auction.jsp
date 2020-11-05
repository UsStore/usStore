<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../ItemHeader.jsp"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<form name="pform" action="">
	<div class="featured-items">
		<div class="container">
		<%@ include file="filterRegion.jsp"%>
			<div class="row" style="padding: 10px">
				<ul class="nav nav-tabs nav-product-tabs">
					<li class="active">
						<a href="#trending" data-toggle="tab">
							<font size="5">Auction List</font></a>
					</li>
					<li class="pull-right collection-url">
						<a href="<c:url value='/shop/item/addItem.do'>
		               			<c:param name="productId" value="${productId}"/></c:url>">
							<font size="5">경매 추가하기</font></a>
					</li>
				</ul>
				<!-- 로그인 여부 인터셉터로 이동 -->
				<div class="tab-content">
					<div class="tab-pane active" id="trending">
						<c:forEach var="al" items="${auctionList.pageList}" varStatus="status">   
							<!--repeat part -->
							<div class="col-md-3 col-sm-4" style="padding: 10px">
								<div class="single-product">
									<div class="product-block">
										
										<c:if test="${al.imgUrl eq null}">
											<img src="${pageContext.request.contextPath}/images/picture.png" class="thumbnail" alt="">
										</c:if>
										<c:if test="${al.imgUrl ne null}">
											<img src="getImage.do?itemId=${al.itemId}" class="thumbnail" onerror="this.src='${pageContext.request.contextPath}/images/picture.png'" />
										</c:if>

										<a href="<c:url value='/shop/auction/viewItem.do'>
			                               			<c:param name="productId" value="${al.productId}"/>
				                                	<c:param name="itemId" value="${al.itemId}"/>
	                                			</c:url>"> 
											<div class="product-description" style="padding: 10px">

												<p class="title">
													<c:choose>
														<c:when test="${fn:length(al.title) gt 15}">
															<font size="4">
																<c:out value="${fn:substring(al.title, 0, 14)}"/> ...
															</font>
														</c:when>
														<c:otherwise>
															<font size="4">${al.title}</font>
														</c:otherwise>
													</c:choose>
												</p>
												<p class="user"><font size="3">판매자 : ${al.userId}</font></p>
												<p class="user">
													<font size="3"> 낙찰자 : 
							                       <!-- 경매 종료시 낙찰자 출력, 경매 진행중일땐 None 출력 --> 
							                       <c:set var="state" value="${al.auctionState}"/>
							                       <c:if test="${state eq 0}">
												   <td style="padding-left:90px"><c:out value="×"/>
												   </c:if>
							   					   <c:if test="${state eq 1}">
							   					   	<c:if test="${al.unitCost eq 1}">
							   					   		<c:out value="×"/>
							   					   	</c:if>
							   					   	<c:if test="${al.unitCost ne 1}">
							   					   		<c:out value="${(resultBidder.pageList)[status.index].bidder}"/></td>
							   					   	</c:if>
												   </c:if>
												   </font>
												</p>
												<hr>
												<p class="price" align="right">
													시작가 : <c:out value="${al.startPrice}"/><br>
							                   		<!-- 경매 종료시 낙찰가 보여주기, 경매 진행중일땐 현재 최고 가격 보여주기 -->
							                   		<c:set var="state" value="${al.auctionState}"/>
							                       	<c:if test="${state eq 0}">
							                       		<c:set var="uc" value="${al.unitCost}" />
							                       		<c:if test="${uc eq 1}">
							                       			▷미참여◁
							                       		</c:if>
							                       		<c:if test="${uc ne 1}">
							                       			현재 최고가 : <c:out value="${uc}"/>
							                       		</c:if>
							                       	</c:if>	
							                   		<c:if test="${state eq 1}">
							                   			<c:if test = "${al.bidPrice eq 1}">
							                   				▷미참여 종료◁
							                   			</c:if>
							                   			<c:if test = "${al.bidPrice ne 1}">
							                   				낙찰가 : <c:out value="${al.bidPrice}"/>
							                   			</c:if>
							                       	</c:if>	
												</p>
												<hr>
												<p class="" align="center">마감 날짜 :
													<c:out value="${al.deadLine}"/><br>
									                <c:if test="${state eq 0}">
									   					<font color=#6495ED>(경매 진행중)</font><br><br>
									   				</c:if>
									   				<c:if test="${state eq 1}">
									   					<font color=#FF4500>(경매 종료)</font><br><br>
									   				</c:if>
												</p>
											</div>
										</a>
										<div class="product-hover">
											<ul>
												<li><a href="<c:url value="/shop/addItemToCart.do">
													         <c:param name="workingItemId" value="${al.itemId}"/>
													         <c:param name="productId" value="${al.productId}"/></c:url>">
													 <i class="fa fa-cart-arrow-down"></i></a>
												</li>
												<li><a href="<c:url value='/shop/auction/viewItem.do'>
			                               			<c:param name="productId" value="${al.productId}"/>
				                                	<c:param name="itemId" value="${al.itemId}"/>
	                                			</c:url>"> <i class="fa fa-arrows-h"></i></a></li>
												<li><a href=""><i class="fa fa-heart-o"></i></a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<!--repeat part -->

							</tr>
						</c:forEach>
					</div>
				</div>
				<!-- 페이지 구분  -->
			</div>
		</div>
	</div>
	
	<div align="center">
		<span style="padding: 30px; width: 50px; height: 50px;">
			<c:if test="${!auctionList.firstPage}">
				<a href='<c:url value="/shop/auction/listItem2.do">
						<c:param name="productId" value="${productId}"/>
						<c:param name="pageName" value="previous"/></c:url>'>
					<font size="5">BACK </font>
					<img src="${pageContext.request.contextPath}/images/backpage.png" width="40" height="50"/>
				</a>
			</c:if>	
		</span>
		<span style="padding: 30px; width: 50px; height: 50px;">	
			<c:if test="${!auctionList.lastPage}">
				<a href='<c:url value="/shop/auction/listItem2.do">/>
						<c:param name="productId" value="${productId}"/>
			            <c:param name="pageName" value="next"/></c:url>'>
			        <img src="${pageContext.request.contextPath}/images/nextpage.png" width="40" height="50"/><font size="5">NEXT </font>
				</a>
			</c:if>			
		</span>
	</div>
</form>

<%@ include file="../IndexBottom.jsp"%>