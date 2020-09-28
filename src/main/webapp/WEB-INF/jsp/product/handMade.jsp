<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="itemTop.jsp"%>
<style>
	th, td {
		text-align: center;
		height: 70px;
		padding-left: 50px;
		padding-right: 50px;
	}
</style>
<table id="main-menu">
  <tr>
    <td><a href='<c:url value="/shop/index.do"/>'>
        <b><font color="black" size="2">
          &lt;&lt; Go to Index</font></b></a>
    </td>
  </tr>
</table>

<form name="pform" action="" style="position: absolute; left: 45%; margin: 0 0 0 -420px;">
	<div class="container">
		<div class="row" style="display: inline">
			<div style="display: inline; float: left;">
				<div style="font-size: 15px">
					<h2>HandMade List</h2>
					<p style="text-align: right;">
						<a href="<c:url value='/shop/item/addItem.do'>
		               		<c:param name="productId" value="${productId}"/></c:url>">
		               		수공예  판매하기 </a>
					</p>
					<!-- 로그인 여부 인터셉터로 이동 -->
					<hr>
					<table>
						<tr>
							<th>제품명</th>
							<th>가격</th>
							<th>판매자</th>
							<th>구매 가능 여부</th>
							<th>&nbsp;</th>
						</tr>
						<tbody>
							<c:forEach var="item" items="${handMadeList.pageList}">
								<tr style="height: 70px;">
									<td>
										<a href="<c:url value='/shop/handMade/viewItem.do'>
			                               			<c:param name="productId" value="${item.productId}"/>
				                                	<c:param name="itemId" value="${item.itemId}"/>
	                                			</c:url>"> <font>${item.title}</font>
										</a>
									</td>
									<td>${item.unitCost}원</td>
									<td>${item.userId}</td>
									<c:if test="${item.qty > 0}">
										<td>${item.qty}</td>
										<td><a href='<c:url value="/shop/addItemToCart.do">
					            				<c:param name="workingItemId" value="${item.itemId}"/>
					            				<c:param name="productId" value="${item.productId}"/></c:url>'>
					              		<img width="40" height="40" src="${pageContext.request.contextPath}/images/cart_img.png" alt="" /></a></td> 
									</c:if>
									<c:if test="${item.qty <= 0}">
										<td><button type="button" class="btn btn-outline-danger">품절</button></td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
						<!-- 페이지 구분  -->
						<tr>
							<td colspan="2">
								<c:if test="${!handMadeList.firstPage}">
									<a href='<c:url value="/shop/handMade/listItem2.do">
											<c:param name="productId" value="${productId}"/>
	           								<c:param name="pageName" value="previous"/></c:url>'>
										<font color="black"><B>&lt;&lt; Prev</B></font>
									</a>
								</c:if>
							</td>
							<td colspan="2">
								<c:if test="${!handMadeList.lastPage}">
									<a href='<c:url value="/shop/handMade/listItem2.do">/>
											 <c:param name="productId" value="${productId}"/>
	            							 <c:param name="pageName" value="next"/></c:url>'>
										<font color="black"><B>Next &gt;&gt;</B></font>
									</a>
								</c:if>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<br>
	<br>
</form>
