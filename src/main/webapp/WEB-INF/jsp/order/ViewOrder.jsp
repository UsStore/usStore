<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
	<title>My Order</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Cache-Control" content="max-age=0">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="Expires" content="Tue, 01 Jan 1980 1:00:00 GMT">
	<meta http-equiv="Pragma" content="no-cache">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="2020-01 소프트웨어 시스템 개발 ">
	<meta name="author" content="愛+">
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/usstore.css?after" type="text/css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/account.css?after" type="text/css" />
	
	<!-- Bootstrap core JavaScript -->
	<script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	
	<!-- Plugin JavaScript -->
	<script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>
	
	<!-- Custom JavaScript for this theme -->
	<script src="${pageContext.request.contextPath}/js/scrolling-nav.js"></script>
	
	<!-- Bootstrap core CSS -->
	<link href="${pageContext.request.contextPath}/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Custom styles for this template -->
	<link href="${pageContext.request.contextPath}/css/scrolling-nav.css" rel="stylesheet">
	
	<!-- Custom styles for this template -->
	<link href="${pageContext.request.contextPath}/css/simple-sidebar.css" rel="stylesheet">

</head>
<body>

 <nav class="navbar navbar-light" style="background-color: #000000; height: 74px; font-size: 20px;">
	<ul class="navbar-nav">
		<li class="nav-item active">
			<a class="nav-link" href="<c:url value="/shop/index.do"/>">
				<img border="0" src="${pageContext.request.contextPath}/images/back.png"
					style="float: left; width: 30; height: 30; border: 0;" /> &nbsp;
				<font color="white" font-size="10px"> GO TO INDEX </font>
			</a>
		</li>
	</ul>
</nav>
<br>

<div align="center">
  <c:if test="${!empty message}">
    <b><c:out value="${message}" /></b>
  </c:if>
  <h2>Order Infomation</h2>
  <p></p>
  <table class="n13">
    <tr>
      <td align="center" colspan="2"><font size="4">
        <b>Order #<c:out value="${order.orderId}" /></b></font> <br />
        <font size="3"><b>
          <fmt:formatDate value="${order.orderDate}" pattern="yyyy/MM/dd hh:mm:ss" /></b>
        </font></td>
    </tr>
    <tr>
      <td colspan="2"><font color="green" size="4"><b>Payment Details</b></font></td>
    </tr>
    <tr>
      <td>Card Type:</td>
      <td><c:out value="${order.cardType}" /></td>
    </tr>
    <tr>
      <td>Card Number:</td>
      <td><c:out value="${order.creditCard}" /> 
        <font color="red" size="2">* Fake number!</font></td>
    </tr>
    <tr>
      <td>Expiry Date (MM/YYYY):</td>
      <td><c:out value="${order.expiryDate}" /></td>
    </tr>
    <tr>
      <td colspan="2"><font color="green" size="4"><b>Billing Address</b></font></td>
    </tr>
    <tr>
      <td>name:</td>
      <td><c:out value="${order.billToUsername}" /></td>
    </tr>
    <tr>
      <td>Address 1:</td>
      <td><c:out value="${order.billAddr1}" /></td>
    </tr>
    <tr>
      <td>Address 2:</td>
      <td><c:out value="${order.billAddr2}" /></td>
    </tr>
    <tr>
      <td>City:</td>
      <td><c:out value="${order.billCity}" /></td>
    </tr>
    <tr>
      <td>Zip:</td>
      <td><c:out value="${order.billZip}" /></td>
    </tr>
    <tr>
      <td>Country:</td>
      <td><c:out value="${order.billCountry}" /></td>
    </tr>
    <tr>
      <td colspan="2"><font color="green" size="4"><b>Shipping Address</b></font></td>
    </tr>
    <tr>
      <td>name:</td>
      <td><c:out value="${order.shipToUsername}" /></td>
    </tr>
    <tr>
      <td>Address 1:</td>
      <td><c:out value="${order.shipAddr1}" /></td>
    </tr>
    <tr>
      <td>Address 2:</td>
      <td><c:out value="${order.shipAddr2}" /></td>
    </tr>
    <tr>
      <td>City:</td>
      <td><c:out value="${order.shipCity}" /></td>
    </tr>
    <tr>
      <td>Zip:</td>
      <td><c:out value="${order.shipZip}" /></td>
    </tr>
    <tr>
      <td>Country:</td>
      <td><c:out value="${order.shipCountry}" /></td>
    </tr>
    <tr>
      <td>Courier:</td>
      <td><c:out value="${order.courier}" /></td>
    </tr>
    <tr>
      <td colspan="2"><b><font color="green" size="4">Status:</font> 
        <c:out value="${order.status}" /></b></td>
    </tr>
    <tr>
      <td colspan="2">
        <table class="n23" style="width:100%">
          <tr style="background-color:#CCCCCC;">
            <td><b>Item ID</b></td>
            <td><b>Description</b></td>
            <td><b>Quantity</b></td>
            <td><b>Price</b></td>
            <td><b>Total Cost</b></td>
          </tr>
          <c:forEach var="lineItem" items="${order.lineItems}">
            <tr>
              <td>
                <b><a href='<c:url value="/shop/viewItem.do">
                  <c:param name="itemId" value="${lineItem.itemId}"/></c:url>'>
                    <font color="black"><c:out value="${lineItem.itemId}" /></font>
                </a></b></td>
              <td>
                <c:out value="${lineItem.item.title}" />
                <c:out value="${lineItem.item.description}" />                 
              </td>
              <td><c:out value="${lineItem.quantity}" /></td>
              <td align="right"><fmt:formatNumber
                  value="${lineItem.unitPrice}" pattern="###,###,###원" /></td>
              <td align="right"><fmt:formatNumber
                  value="${lineItem.totalPrice}" pattern="###,###,###원" /></td>
            </tr>
          </c:forEach>
          <tr>
            <td colspan="5" align="right"><b>Total: <fmt:formatNumber
               value="${order.totalPrice}" pattern="###,###,###원" /></b></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <a href="<c:url value="/shop/listOrders.do"/>"
  	class="badge badge-pill badge-light" style="font-size: 30px">
        	내 주문 목록 보기</a>
</div>
<br><br><br>
