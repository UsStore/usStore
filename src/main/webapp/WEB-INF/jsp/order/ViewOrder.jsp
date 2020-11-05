<%@ include file="../ItemHeader.jsp"%> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
	.simple_table {
		width: 70%;
		border: none;
		border-collapse: separate;
		border-spacing: 2px;
		padding: 20px;
		vertical-align: middle;
	}
	
	.simple_table th {
		padding: 15px;
		border: none;
		border-left: 5px solid #29403C;
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
		text-align: left;
		vertical-align: baseline;
	}
</style>
<body>

  <c:if test="${!empty message}">
 	<div class="alert alert-success" role="alert" align="center">
   		<b><c:out value="${message}" /></b>
    </div>
  </c:if>
  
  <div align="center" style="padding: 30px">
   	<h2>Order Infomation</h2>
	<font size="4"> 
		<b>Order #<c:out value="${order.orderId}" /></b>
	</font><br> 
	<font size="3">
		<b><fmt:formatDate	value="${order.orderDate}" pattern="yyyy/MM/dd hh:mm:ss" /></b>
	</font>
  </div>

  <table class="simple_table" align="center">
    <tr>
      <th colspan="2">
      	<font color="white" size="4"><b>결제 상세정보</b></font>
      </th>
    </tr>
    <tr>
      <td>결제 종류</td>
      <td><c:out value="${order.cardType}" /></td>
    </tr>
    <tr>
      <td>카드 번호</td>
      <td><c:out value="${order.creditCard}" /> 
        <font color="red" size="2">* Fake number!</font></td>
    </tr>
    <tr>
      <td>카드 유효기간 (MM/YYYY):</td>
      <td><c:out value="${order.expiryDate}" /></td>
    </tr>
   </table>
   
   <table class="simple_table" align="center">
    <tr>
      <th colspan="2">
        <font color="white" size="4"><b>결제자 정보</b></font>
      </th>
    </tr>
    <tr>
      <td>이름</td>
      <td>${order.billToUsername}</td>
    </tr>
    <tr>
      <td>국가 정보</td>
      <td>${order.billCountry}</td>
    </tr>
    <tr>
      <td>도시 정보</td>
      <td>${order.billCity}</td>
    </tr>
    <tr>
      <td>주소</td>
      <td>${order.billAddr1}</td>
    </tr>
    <tr>
      <td>상세주소</td>
      <td>${order.billAddr2}</td>
    </tr>
    <tr>
      <td>우편번호</td>
      <td>${order.billZip}</td>
    </tr>
   </table>
   <table class="simple_table" align="center">
    <tr>
      <th colspan="2">
        <font color="white" size="4"><b>배송지 정보</b></font>
      </th>
    </tr>
    <tr>
      <td>이름</td>
      <td>${order.shipToUsername}</td>
    </tr>
    <tr>
      <td>국가 정보</td>
      <td>${order.shipCountry}</td>
    </tr>
    <tr>
      <td>도시 정보</td>
      <td>${order.shipCity}</td>
    </tr>
    <tr>
      <td>주소</td>
      <td>${order.shipAddr1}</td>
    </tr>
    <tr>
      <td>상세주소</td>
      <td>${order.shipAddr2}</td>
    </tr>
    <tr>
      <td>우편번호</td>
      <td>${order.shipZip}</td>
    </tr>
    <tr>
      <td>택배원 정보</td>
      <td><c:out value="${order.courier}" /></td>
    </tr>
   </table>
   <table class="simple_table" align="center">
    <tr>
      <th colspan="2">
      	<b><font color="white" size="4">구매 제품 정보</font></b>
      </th>
    </tr>
    <tr>
      <td colspan="2">
        <table class="n23" style="width:90%">
          <tr style="background-color:#81CABD;">
            <td><b>ID</b></td>
            <td><b>제품명</b></td>
            <td><b>수량</b></td>
            <td><b>가격</b></td>
            <td><b>총액</b></td>
            <td></td>
          </tr>
          <c:forEach var="lineItem" items="${order.lineItems}">
            <tr>
              <td>
                <b><a href='<c:url value="/shop/order/viewItem.do">
                  <c:param name="itemId" value="${lineItem.itemId}"/>
                  </c:url>'>
                    <font color="black"><c:out value="${lineItem.itemId}" /></font>
                </a></b>
              </td>
              <td>
              	<font color="black"><c:out value="${lineItem.title}" /></font>
              </td>
              <td><c:out value="${lineItem.quantity}" /></td>
              <td align="right">
              	<fmt:formatNumber value="${lineItem.unitPrice}" pattern="###,###,###원" />
              </td>
              <td align="right">
              	<fmt:formatNumber value="${lineItem.totalPrice}" pattern="###,###,###원" />
              </td>
              <td><b><a href='<c:url value="/shop/order/goAddReview.do">
                  <c:param name="itemId" value="${lineItem.itemId}"/>
                  <c:param name="userId" value="${order.userId}"/>
                  </c:url>' class="badge badge-pill" style="font-size: 15px; background-color: #164038;">
                    <font color="white">리뷰 작성</font>
                </a></b>
              </td>
            </tr>
          </c:forEach>
          <tr>
            <td colspan="6">
            	<b> Total: <fmt:formatNumber value="${order.totalPrice}" pattern="###,###,###원" /></b>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <center>
	  <a href="<c:url value="/shop/listOrders.do"/>"
	  	class="badge badge-pill" style="font-size: 30px; padding: 10px; background-color: #40bea7;">
	        	<font color="white">내 주문 목록 보기</font>
	  </a>
  </center>
<br><br><br>
<%@ include file="../IndexBottom.jsp" %>
