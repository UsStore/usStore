<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="ItemHeader.jsp"%>
<!-- db에서 select 결과 보여주는 페이지 -->
<style>  
   span#black {
      width:10%; 
      height: 10px; 
      border: 1px solid black;
      border-radius: 2em;
      font-size: small;
      text-align: center;
      padding: 5px;
   }
   
   span#red {
      width:10%; 
      height: 10px; 
      border: 1px solid red;
      border-radius: 2em;
      font-size: small;
      text-align: center;
      padding: 5px;
   }
</style>
<form name="pform" action="">
	<div class="featured-items">
		<div class="container">
			<%@ include file="filterRegion.jsp"%>
			<div class="row" style="padding: 10px">
				<ul class="nav nav-tabs nav-product-tabs">
					<li class="active"><a href="#trending" data-toggle="tab">
							<font size="5">GroupBuying List</font>
					</a></li>
					<li class="pull-right collection-url"><a
						href="<c:url value='/shop/item/addItem.do'>
		               			<c:param name="productId" value="${productId}"/></c:url>">
							<font size="5">공동구매 물품 판매하기</font>
					</a></li>
				</ul>
				<!-- 로그인 여부 인터셉터로 이동 -->
				<div class="tab-content">
					<div class="tab-pane active" id="trending">
						<c:forEach var="gb" items="${groupBuyingList.pageList}">
							<!--repeat part -->
							<div class="col-md-3 col-sm-4" style="padding: 10px">
								<div class="single-product">
									<div class="product-block">
										<c:if test="${gb.imgUrl eq null}">
											<img src="${pageContext.request.contextPath}/images/picture.png" alt="" class="thumbnail">
										</c:if>
										<c:if test="${gb.imgUrl ne null}">
											<img src="getImage.do?itemId=${gb.itemId}" class="thumbnail" onerror="this.src='${pageContext.request.contextPath}/images/picture.png'" />
										</c:if>

										<a href="<c:url value='/shop/groupBuying/viewItem.do'>
			                               			<c:param name="productId" value="${gb.productId}"/>
				                                	<c:param name="itemId" value="${gb.itemId}"/>
	                                			</c:url>">
											<div class="product-description" style="padding: 10px;">
												<p class="title">제품명 : ${gb.title}</p>
												<hr>
												<p class="price" align="right">
													<del>
														정가 :
														<fmt:formatNumber value="${gb.listPrice}" pattern="###,###원" />
													</del>
													<br> 할인가 :
													<fmt:formatNumber value="${gb.unitCost}" pattern="###,###원" />
												</p>
												<p class="price" align="right">할인율 : ${gb.discount}%</p>
												<hr>
												<p class="quantity" align="right">수량 : ${gb.qty}</p>
												<p class="dueDate" align="right">마감 날짜 : ${gb.deadLine}</p>
												<p class="state" align="center">
													<c:choose>
														<c:when test="${gb.state eq 1}">
															<span id="black">마감</span>
														</c:when>
														<c:otherwise>
															<span id="red"><font color="red">진행중</font></span>
														</c:otherwise>
													</c:choose>
												</p>
											</div>
										</a>
									</div>
									<div class="product-hover">
										<ul>
											<li><a
												href="<c:url value="/shop/addItemToCart.do">
													         <c:param name="workingItemId" value="${gb.itemId}"/>
													         <c:param name="productId" value="${gb.productId}"/></c:url>">
													<i class="fa fa-cart-arrow-down"></i>
											</a></li>
											<li><a
												href="<c:url value='/shop/groupBuying/viewItem.do'>
			                               			<c:param name="productId" value="${gb.productId}"/>
				                                	<c:param name="itemId" value="${gb.itemId}"/>
	                                			</c:url>">
													<i class="fa fa-arrows-h"></i>
											</a></li>
											<li><a href=""><i class="fa fa-heart-o"></i></a></li>
										</ul>
									</div>
								</div>
							</div>
						</c:forEach>
						<!--repeat part -->
					</div>
				</div>
			</div>
			<!-- 페이지 구분  -->
		</div>
	</div>

	<div align="center">
		<span style="padding: 30px; width: 50px; height: 50px;">
			<c:if test="${!groupBuyingList.firstPage}">
				<a href='<c:url value="/shop/groupBuying/listItem2.do">
						<c:param name="productId" value="${productId}"/>
						<c:param name="pageName" value="previous"/></c:url>'>
					<font size="5">BACK </font>
					<img src="${pageContext.request.contextPath}/images/backpage.png" width="40" height="50"/>
				</a>
			</c:if>	
		</span>
		<span style="padding: 30px; width: 50px; height: 50px;">	
			<c:if test="${!groupBuyingList.lastPage}">
				<a href='<c:url value="/shop/groupBuying/listItem2.do">/>
						<c:param name="productId" value="${productId}"/>
			            <c:param name="pageName" value="next"/></c:url>'>
			        <img src="${pageContext.request.contextPath}/images/nextpage.png" width="40" height="50"/><font size="5">NEXT </font>
				</a>
			</c:if>			
		</span>
	</div>
</form>

<%@ include file="../IndexBottom.jsp"%>
