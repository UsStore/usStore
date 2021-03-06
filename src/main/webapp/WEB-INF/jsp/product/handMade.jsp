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
							<font size="5">HandMade List</font></a>
					</li>
					<li class="pull-right collection-url">
						<a href="<c:url value='/shop/item/addItem.do'>
		               			<c:param name="productId" value="${productId}"/></c:url>">
							<font size="5">수공예 판매하기 </font></a>
					</li>
				</ul>
				<!-- 로그인 여부 인터셉터로 이동 -->
				<div class="tab-content">
					<div class="tab-pane active" id="trending">
						<c:forEach var="item" items="${handMadeList.pageList}">
							<!--repeat part -->
							<div class="col-md-3 col-sm-4" style="padding: 10px">
								<div class="single-product">
									<div class="product-block">
										
										<c:if test="${item.imgUrl eq null}">
											<img src="${pageContext.request.contextPath}/images/picture.png" alt="" class="thumbnail">
										</c:if>
										<c:if test="${item.imgUrl ne null}">
											<img src="getImage.do?itemId=${item.itemId}" class="thumbnail" onerror="this.src='${pageContext.request.contextPath}/images/picture.png'" />
										</c:if>

										<a href="<c:url value='/shop/handMade/viewItem.do'>
			                               			<c:param name="productId" value="${item.productId}"/>
				                                	<c:param name="itemId" value="${item.itemId}"/>
	                                			</c:url>"> 
											<div class="product-description" style="padding: 10px">
	
												<p class="title">
													<c:choose>
														<c:when test="${fn:length(item.title) gt 10}">
															<font size="4">
																<c:out value="${fn:substring(item.title, 0, 9)}"/> ...
															</font>
														</c:when>
														<c:otherwise>
															<font size="4">${item.title}</font>
														</c:otherwise>
													</c:choose>
												</p>
												<p class="user">판매자 : ${item.userId}</p>
												<hr>
												<p class="price" align="right">${item.unitCost}원</p>
											</div>
										</a>
										<div class="product-hover">
											<ul>
												<li><a href="<c:url value="/shop/addItemToCart.do">
													         <c:param name="workingItemId" value="${item.itemId}"/>
													         <c:param name="productId" value="${item.productId}"/></c:url>">
													 <i class="fa fa-cart-arrow-down"></i></a>
												</li>
												<li><a href="<c:url value='/shop/handMade/viewItem.do'>
			                               			<c:param name="productId" value="${item.productId}"/>
				                                	<c:param name="itemId" value="${item.itemId}"/>
	                                			</c:url>"> <i class="fa fa-arrows-h"></i></a></li>
												<li><a href=""><i class="fa fa-heart-o"></i></a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<!--repeat part -->
						</c:forEach>
					</div>
				</div>
				<!-- 페이지 구분  -->
			</div>
		</div>
	</div>
	
	<div align="center">
		<span style="padding: 30px; width: 50px; height: 50px;">
			<c:if test="${!handMadeList.firstPage}">
				<a href='<c:url value="/shop/handMade/listItem2.do">
						<c:param name="productId" value="${productId}"/>
						<c:param name="pageName" value="previous"/></c:url>'>
					<font size="5">BACK </font>
					<img src="${pageContext.request.contextPath}/images/backpage.png" width="40" height="50"/>
				</a>
			</c:if>	
		</span>
		<span style="padding: 30px; width: 50px; height: 50px;">	
			<c:if test="${!handMadeList.lastPage}">
				<a href='<c:url value="/shop/handMade/listItem2.do">/>
						<c:param name="productId" value="${productId}"/>
			            <c:param name="pageName" value="next"/></c:url>'>
			        <img src="${pageContext.request.contextPath}/images/nextpage.png" width="40" height="50"/><font size="5">NEXT </font>
				</a>
			</c:if>			
		</span>
	</div>
</form>

<%@ include file="../IndexBottom.jsp"%>