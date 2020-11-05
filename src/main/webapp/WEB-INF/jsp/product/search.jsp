<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="ItemHeader.jsp"%>
<style>
	
	#badge {
		padding: 5px 10px 5px 10px;
		margin-right: 30px;
		font-size: 15px;
		min-width: 100px;
		background-color: #29403C;
	}

</style>
<form name="pform" action="">
	<div class="featured-items">
		<div class="container">
		<%@ include file="filterRegion.jsp"%>
			<div class="row" style="padding: 10px">
				<ul class="nav nav-tabs nav-product-tabs">
					<c:set var="kind" value="${sKind}"/>
					<c:if test="${'title' eq kind}">
						<li class="active">
							<a href="#trending" data-toggle="tab">
								<font size="5">Search Title</font>
							</a>
						</li>
						<li>&nbsp;&nbsp;&nbsp;&nbsp;</li>
						<li class="collection-url">
							<a href="#best-seller">
								<font color="white" size="5"><c:out value="${searchWord}"/></font>
							</a>
						</li>
					</c:if>
					<c:if test="${'tag' eq kind}">
						<li class="active">
							<a href="#trending" data-toggle="tab">
								<font size="5">Search Tag</font>
							</a>
						</li>
						<li>&nbsp;&nbsp;&nbsp;&nbsp;</li>
						<li class="collection-url">
							<a href="#best-seller">
								<font color="white" size="5"><c:out value="${searchWord}"/></font>
							</a>
						</li>						
					</c:if>
				</ul>
				<!-- 로그인 여부 인터셉터로 이동 -->
				<div class="tab-content">
					<div class="tab-pane active" id="trending">
					    <c:set var="no" value="${noResult}"/>
		                <c:if test="${no == 1}">
		              	 	<c:out value="검색 결과가 없습니다."/>
		                </c:if>
		                <c:if test="${empty no}">
						<c:forEach var="item" items="${resultList.pageList}" varStatus="status">  
							<!--repeat part -->
							<div class="col-md-3 col-sm-4" style="padding: 10px">
								<div class="single-product">
									<div class="product-block">
										
										<c:if test="${item.imgUrl eq null}">
											<img src="${pageContext.request.contextPath}/images/picture.png" alt="" class="thumbnail">
										</c:if>
										<c:if test="${item.imgUrl ne null}">
											<img src="getImage.do?itemId=${item.itemId}&productId=${item.productId}" class="thumbnail" onerror="this.src='${pageContext.request.contextPath}/images/picture.png'" />
										</c:if>

										<a href="<c:url value='/shop/search/selectItem.do'>
									             <c:param name="itemId" value="${item.itemId}"/>
									             </c:url>">
											<div class="product-description" style="padding: 10px">
												<p class="category">
													<font size="4">
													  <c:set var="productId" value="${item.productId}"/>
													  <c:if test="${productId eq 0}">
														<span class="badge badge-pill badge-dark" id="badge"><c:out value="공동구매"/></span>
													  </c:if>
													  <c:if test="${productId eq 1}">
														<span class="badge badge-pill badge-dark" id="badge"><c:out value="경매"/></span>
													  </c:if>
													  <c:if test="${productId eq 2}">
														<span class="badge badge-pill badge-dark" id="badge"><c:out value="중고거래"/></span>
													  </c:if>
													  <c:if test="${productId eq 3}">
														<span class="badge badge-pill badge-dark" id="badge"><c:out value="수공예"/></span>
													  </c:if>
													</font>
												</p>
													
												<p class="title" align="right">
									               <font size="4"><c:out value="${item.title}"/></font>
												</p>
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
						</c:if>
					</div>
				</div>
				<!-- 페이지 구분  -->
			</div>
		</div>
	</div>
	
	<div align="center">
		<span style="padding: 30px; width: 50px; height: 50px;">
			<c:if test="${!resultList.firstPage}">
				<a href='<c:url value="/shop/search/viewItem2.do">
						<c:param name="pageName" value="previous"/></c:url>'>
					<font size="5">BACK </font>
					<img src="${pageContext.request.contextPath}/images/backpage.png" width="40" height="50"/>
				</a>
			</c:if>	
		</span>
		<span style="padding: 30px; width: 50px; height: 50px;">	
			<c:if test="${!resultList.lastPage}">
				<a href='<c:url value="/shop/search/viewItem2.do">/>
						<c:param name="pageName" value="next"/></c:url>'>
			        <img src="${pageContext.request.contextPath}/images/nextpage.png" width="40" height="50"/><font size="5">NEXT </font>
				</a>
			</c:if>			
		</span>
	</div>
</form>


<%@ include file="../IndexBottom.jsp"%>