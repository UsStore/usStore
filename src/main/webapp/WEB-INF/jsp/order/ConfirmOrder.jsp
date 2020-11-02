<%@ include file="../header.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
	.simple_table {
		width: 70%;
		border: none;
		border-collapse: separate;
		border-spacing: 2px;
		padding: 20px;
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

<div class="alert alert-success" role="alert" align="center">
  Please confirm the information below and then press continue....
  <br>주문 정보를 확인하시고, 확인이 완료되었을 경우 계속 주문을 진행해주세요.
</div>

<div align="center" style="padding: 30px">
	<h1>Order Infomation</h1>
	<font size="5"> 
		<b><fmt:formatDate value="${orderForm.order.orderDate}" pattern="yyyy/MM/dd hh:mm:ss" /></b>
	</font>
</div>

<div align="center">
  <table class="simple_table">
    <tr>
      <th colspan="2">
        <font color="white" size="4"><b>결제자 정보</b></font>
      </th>
    </tr>
    <tr>
      <td>이름</td>
      <td>${orderForm.order.billToUsername}</td>
    </tr>
    <tr>
      <td>국가 정보</td>
      <td>${orderForm.order.billCountry}</td>
    </tr>
    <tr>
      <td>도시 정보</td>
      <td>${orderForm.order.billCity}</td>
    </tr>
    <tr>
      <td>주소</td>
      <td>${orderForm.order.billAddr1}</td>
    </tr>
    <tr>
      <td>상세주소</td>
      <td>${orderForm.order.billAddr2}</td>
    </tr>
    <tr>
      <td>우편번호</td>
      <td>${orderForm.order.billZip}</td>
    </tr>

   </table>
   <table class="simple_table">
    <tr style="background-color: #308C7B">
      <th colspan="2">
        <font color="white" size="4"><b>배송지 정보</b></font>
      </th>
    </tr>
    <tr>
      <td>이름</td>
      <td>${orderForm.order.shipToUsername}</td>
    </tr>
    <tr>
      <td>국가 정보</td>
      <td>${orderForm.order.shipCountry}</td>
    </tr>
    <tr>
      <td>도시 정보</td>
      <td>${orderForm.order.shipCity}</td>
    </tr>
    <tr>
      <td>주소</td>
      <td>${orderForm.order.shipAddr1}</td>
    </tr>
    <tr>
      <td>상세주소</td>
      <td>${orderForm.order.shipAddr2}</td>
    </tr>
    <tr>
      <td>우편번호</td>
      <td>${orderForm.order.shipZip}</td>
    </tr>

  </table>
  <br><br>
</div>

<div align="center">
 	<a href="<c:url value="/shop/confirmOrder.do"/>"
	  	class="badge badge-pill" style="font-size: 30px; padding: 10px; background-color: #40bea7;">
	    <font color="white">주문 확인 완료</font>
	</a>
</div>

<%@ include file="../IndexBottom.jsp" %>