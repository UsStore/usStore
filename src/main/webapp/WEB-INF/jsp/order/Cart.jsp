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

<div align="center" style="padding: 30px">
	<h1>Shopping Cart</h1>  
</div>

<form action='<c:url value="/shop/updateCartQuantities.do"/>' method="post">
	<table class="simple_table" align="center">
		<tr>
			<th><font color="white">제품명</font></th>
			<th><font color="white">제품 설명</font></th>
			<th><font color="white">재고 여부</font></th>
			<th><font color="white">구매 개수</font></th>
			<th><font color="white">제품 가격</font></th>
			<th><font color="white">TOTAL</font></th>
			<th>&nbsp;</th>
		</tr>
		<c:if test="${cart.numberOfItems == 0}">
			<tr bgcolor="#FFFFFF">
				<td colspan="8"><b>Your cart is empty.</b></td>
			</tr>
		</c:if>
		<c:forEach var="cartItem" items="${cart.cartItemList.pageList}">
			<tr>
				<td>
					<a href='<c:url value="/shop/order/viewItem.do">
                  			<c:param name="itemId" value="${cartItem.item.itemId}"/>
                  			<c:param name="productId" value="${cartItem.item.productId}"/></c:url>'>
						<c:out value="${cartItem.item.title}" />
					</a>
				</td>
				<td><c:out value="${cartItem.item.description}" /></td>
				<td>
					<c:out value="${cartItem.inStock}" />
				</td>
				<td>
					<input type="text" size="3" name='<c:out value="${cartItem.item.itemId}"/>'
								value='<c:out value="${cartItem.quantity}"/>' />
				</td>
				<td>
					<fmt:formatNumber value="${cartItem.item.unitCost}" pattern="###,###,###원" />
				</td>
				<td>
					<fmt:formatNumber value="${cartItem.totalPrice}" pattern="###,###,###원" />
				</td>
				<td width="90">
					<a href='<c:url value="/shop/removeItemFromCart.do">
                    		<c:param name="workingItemId" value="${cartItem.item.itemId}"/></c:url>'>
						<img width="50" height="50"
						src="${pageContext.request.contextPath}/images/delete.png" alt="" />
					</a>
				</td>
			</tr>
		</c:forEach>
		<tr bgcolor="#FFFFFF">
			<td colspan="7" style="text-align: right; font-size: 20px"><br>
				<b>Sub Total: <fmt:formatNumber value="${cart.subTotal}"
						pattern="###,###,###원" /></b> <br>
			<br> <input type="image" src="${pageContext.request.contextPath}/images/refresh.png"
						name="update" width="40" height="40" /> <br>
			</td>
		</tr>
	</table>
	<div style="text-align: center">
		<c:if test="${!cart.cartItemList.firstPage}">
			<a href='<c:url value="viewCart.do?page=previousCart"/>'> <font
				color="#164038" size="5"><B>&lt;&lt; Prev</B></font></a>
		</c:if>
		<c:if test="${!cart.cartItemList.lastPage}">
			<a href='<c:url value="viewCart.do?page=nextCart"/>'> <font
				color="#164038" size="5"><B>Next &gt;&gt;</B></font></a>
		</c:if>
	</div>
</form>
<c:if test="${cart.numberOfItems > 0}">
	<br />
	<div style="text-align: center">
		<a href='<c:url value="/shop/checkout.do"/>'
			class="badge badge-pill" style="font-size: 30px; background-color: #164038;"> 
			Go to CheckOut</a>
	</div>
</c:if>

<%@ include file="../IndexBottom.jsp" %>