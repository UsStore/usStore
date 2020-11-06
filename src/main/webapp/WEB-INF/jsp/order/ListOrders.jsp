<%@ include file="../ItemHeader.jsp"%> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script>
	function getOrder(orderId) {
		var reqUrl = "../rest/order/" + orderId;
		$.ajax({
			type: "get",
			url: reqUrl,
			processData: false,
			success: function(responseJson){	// object parsed from JSON text	
				$("#detail").html("<ul></ul>");
				$("#detail > ul").append("<li>Order ID: " + responseJson.orderId + "</li>");
				$("#detail > ul").append("<li>Order Date: " + new Date(responseJson.orderDate) + "</li>");
				$("#detail > ul").append("<li>User name: " + responseJson.userId + "</li>");
				$("#detail > ul").append("<li>Shipping address: " + responseJson.shipAddr1 + ", " + 
					responseJson.shipAddr2 + ", " + responseJson.shipCity + "</li>");
				var content = "";
				$(responseJson.lineItems).each(function(i, lineItem){	        	
			       	content += "LineItem : " + lineItem.title + ": " + lineItem.quantity +
							" piece(s) of item " + lineItem.itemId + "<br>";
				});
				$("#detail > ul").append ("<li>" + content + "</li>");
				$("#detail > ul").append("<li>Total prices: " + responseJson.totalPrice + "</li>");
			},
			error: function(){
				alert("ERROR", arguments);
			}
		});
	};
</script>
<div align="center" style="padding: 30px;">
  <p>
    <h2>My Order</h2>
  </p>
</div>
 <div align="center" style="padding: 30px;">

  <table class="table" style="width: 80%;'">
    <tr bgcolor="#40BEA7">
      <th scope="col">Order ID</th> 
      <th scope="col">Date</th> 
      <th scope="col">Total Price</th>
    </tr>
    <c:forEach var="order" items="${orderList}">
      <a href="#reviews" data-toggle="tab">
      <tr bgcolor="#FFFFFF">
      	
        <td scope="row">
          <b><a href='<c:url value="/shop/viewOrder.do">
              <c:param name="orderId" value="${order.orderId}"/></c:url>'>
              <font color="black"><c:out value="${order.orderId}" /></font>
            </a></b></td>
          <!-- REST API 내용 부분 -->
        <td scope="row"><fmt:formatDate value="${order.orderDate}"
            pattern="yyyy/MM/dd hh:mm:ss" /></td>
        <td scope="row" onClick="getOrder(${order.orderId});"><fmt:formatNumber value="${order.totalPrice}"
            pattern="###,###,###원" /></td>
      </tr>
      </a>
    </c:forEach>
     	<tr class="tab-pane" id="reviews">
      	<td colspan="3"><div id="detail"></div></td>
      </tr>
  </table>
</div>
<br><br>
<%@ include file="../IndexBottom.jsp" %>