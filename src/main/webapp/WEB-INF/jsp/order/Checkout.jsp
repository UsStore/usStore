<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../header.jsp" %>
 <style>
	.simple_table {
		width: 80%;
		border: none;
		border-collapse: separate;
		border-spacing: 2px;
		padding: 20px;
	}
	
	.simple_table th {
		padding: 15px;
		border: none;
		border-top: 1px solid #FFF;
		border-bottom: 1px solid #FFF;
		background: #40BEA7;
		font-weight: normal;
		text-shadow: 0 1px #000;
		vertical-align: middle;
	}
	
	.simple_table td {
		padding: 15px;
		border: none;
		border-bottom: 1px solid #29403C;
		vertical-align: middle;
	}
	
	.simple_table tr {
		min-width: ;
	}
</style>
<br><br>
<div align="center" style="padding: 30px">
	<h1>Checkout Summary</h1>  
</div>
<table class="simple_table" align="center">
	<tr>
		<th><font color="white">제품명</font></th>
		<th><font color="white">제품 설명</font></th>
		<th><font color="white">재고 여부</font></th>
		<th><font color="white">구매 개수</font></th>
		<th><font color="white">제품 가격</font></th>
		<th><font color="white">TOTAL</font></th>
	</tr>
	<c:forEach var="cartItem" items="${cart.cartItemList.pageList}">
		<tr>
			<td> 
				<a href='<c:url value="/shop/order/viewItem.do">
                  <c:param name="itemId" value="${cartItem.item.itemId}"/>
                  <c:param name="productId" value="${cartItem.item.productId}"/></c:url>'>
					<c:out value="${cartItem.item.title}" />
				</a>
			</td>
			<td><c:out value="${cartItem.item.description}" />
			</td>
			<td align="center"><c:out value="${cartItem.inStock}" /></td>
			<td align="center"><c:out value="${cartItem.quantity}" /></td>
			<td align="center">
				<fmt:formatNumber value="${cartItem.item.unitCost}" pattern="###,###,###원" />
			</td>
			<td align="center">
				<fmt:formatNumber value="${cartItem.totalPrice}" pattern="###,###,###원" />
			</td>
		</tr>
	</c:forEach>
	<tr>
		<td colspan="7" style="text-align: right; font-size: 20px">
			<br> <b>Sub Total: <fmt:formatNumber
					value="${cart.subTotal}" pattern="###,###,###원" /></b> <br>
		</td>
	</tr>
</table>
<div style="text-align: center">
	<c:if test="${!cart.cartItemList.firstPage}">
		<a href="checkout.do?page=previousCart"><font color="#164038" size="5">
				<B>&lt;&lt; Prev</B>
		</font></a>
	</c:if>
	<c:if test="${!cart.cartItemList.lastPage}">
		<a href="checkout.do?page=nextCart"><font color="#164038" size="5"> <B>Next
					&gt;&gt;</B></font></a>
	</c:if>
</div>
<br>
<div align="center">
<a href='<c:url value="/shop/newOrder.do"/>'
	class="badge badge-pill" style="font-size: 30px; padding: 10px; background-color: #164038;">  주문하기</a>

</div>
<%@ include file="../IndexBottom.jsp" %>