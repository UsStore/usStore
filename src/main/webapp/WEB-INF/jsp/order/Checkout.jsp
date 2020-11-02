<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../account/IncludeAccount.jsp" %>
 
<br><br>
<table align="center" style="width: 70%">
  <tr style="vertical-align:top">
    <td style="text-align: center">
      <h2>Checkout Summary</h2>
      <br><br>
      <table id="cart" class="table table-hover" style="text-align:center">
      	<thead>
	        <tr bgcolor="#FFFFFF">
	            <th scope="col"><b>제품명</b></th>
	            <th scope="col"><b>제품 설명</b></th>
	            <th scope="col"><b>재고 여부</b></th>
	            <th scope="col"><b>구매 개수</b></th>
	            <th scope="col"><b>제품 가격</b></th>
	            <th scope="col"><b>TOTAL</b></th>
	        </tr>
        </thead>
        <tbody>
        <c:forEach var="cartItem" items="${cart.cartItemList.pageList}">
          <tr bgcolor="#FFFFFF">
            <td scope="row">
               	<a href='<c:url value="/shop/order/viewItem.do">
                  <c:param name="itemId" value="${cartItem.item.itemId}"/>
                  <c:param name="productId" value="${cartItem.item.productId}"/></c:url>'>
                  <c:out value="${cartItem.item.title}" />
                </a>
            </td>
            <td scope="row">
              <c:out value="${cartItem.item.description}" />
            </td>
            <td scope="row" align="center">
            	<c:out value="${cartItem.inStock}" />
            </td>
            <td scope="row" align="center">
            	<c:out value="${cartItem.quantity}" />
            </td>
            <td scope="row" align="center">
            	<fmt:formatNumber value="${cartItem.item.unitCost}" pattern="###,###,###원" />
            </td>
            <td scope="row" align="center">
            	<fmt:formatNumber value="${cartItem.totalPrice}" pattern="###,###,###원" />
            </td>
          </tr>
        </c:forEach>
        <tr bgcolor="#FFFFFF">
          <td scope="row" colspan="7" style="text-align: right; font-size: 20px">
          	<br>
          	<b>Sub Total: 
          	<fmt:formatNumber value="${cart.subTotal}" pattern="###,###,###원" /></b>
          	<br>
          </td>
        </tr>
        </tbody>
      </table>
      <c:if test="${!cart.cartItemList.firstPage}">
        <a href="checkout.do?page=previousCart"><font color="green">
          <B>&lt;&lt; Prev</B></font></a>
      </c:if>
      <c:if test="${!cart.cartItemList.lastPage}">
        <a href="checkout.do?page=nextCart"><font color="green">
          <B>Next &gt;&gt;</B></font></a>
      </c:if>
      <br> 
      <a href='<c:url value="/shop/newOrder.do"/>' class="badge badge-pill badge-light"
      	style="font-size: 30px">
        	주문하기</a>
    </td>
  </tr>
</table>