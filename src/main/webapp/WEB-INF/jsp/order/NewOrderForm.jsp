<%@ include file="../ItemHeader.jsp"%> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:set var="targetUrl">
	<c:url value="/shop/newOrderSubmitted.do" />
</c:set>

<script>
	$(document).ready(function(){
	    $("#checkBoxId").change(function(){
	        if($("#checkBoxId").is(":checked")){
	            // 배송지 정보가 다를 경우이므로 내용 삭제
	            $("#inputShipToUsername").attr("value", "");
	            $("#inputShipAddr1").attr("value", "");
	            $("#inputShipAddr2").attr("value", "");
	            $("#inputShipCity").attr("value", "");
	            $("#inputShipZip").attr("value", "");
	            $("#inputShipCountry").attr("value", "");
	        }
	    });
	});

	$(document).ready(function() {
		$("#cardType").change(function(){
			var cardType = document.getElementById("cardType");
			var selectValue = cardType.options[cardType.selectedIndex].value;
			
			if(selectValue == "KakaoPay") {
				$("#card").hide();
				$("#modalButton").hide();
				$("#kakaopay").show();
			} else if(selectValue == "Visa" || selectValue == "MasterCard") {
				$("#card").show();
				$("#kakaopay").hide();
				$("#modalButton").show();
			} else {
				$("#card").hide();
				$("#kakaopay").hide();
				$("#modalButton").show();
			}
		});
	});
	
</script>
<style>
	.newOrderForm {
		font-size: 18px;
	}
	.newOrderForm input:not(:placeholder-shown) {
		padding-top: 25px;
		padding-left: 20px;
		padding-right: 20px;
    }
    
   	.newOrderForm label:not(:placeholder-shown) {
		padding-top: 25px;
		padding-left: 20px;
		padding-right: 20px;
    }
</style>

<div align="center">
	<form:form modelAttribute="orderForm" action="${targetUrl}" method="post">
		<form:errors cssClass="error" />
		<br>
		<h1>Order Infomation</h1>
		<br>
		<table class="orderInfo">
			<tr class="orderInfo">
				<td colspan="4" style="text-align: center">
					<form:checkbox path="shippingAddressRequired"  id="checkBoxId" label="배송 정보가 주문자와 다릅니다." />
				</td>
			</tr>
			<tr class="orderInfo">
				<td style="text-align: center">
					<font color="#40bea7" size="5">
						<b>Billing Address (주문자 정보)</b>
					</font>
				</td>
				<td style="text-align: center">
					<font color="#40bea7" size="5">
						<b>Shipping Address (배송지 정보)</b>
					</font>
				</td>
			</tr>
			<tr class="orderInfo">
				<td>
					<div class="form-label-group newOrderForm">
						<form:input path="order.billToUsername" id="inputBillToUsername"
							class="form-control newOrderForm" />
						<B><form:errors path="order.billToUsername" cssClass="error" /></B>
						<label for="inputBillToUsername" class="newOrderForm">Name</label>
					</div>
				</td>
				<td>
					<div class="form-label-group newOrderForm">
						<form:input path="order.shipToUsername" id="inputShipToUsername"
							class="form-control newOrderForm" />
						<B><form:errors path="order.shipToUsername" class="newOrderForm" cssClass="error" /></B>
						<label for="inputShipToUsername">Name</label>
					</div>
				</td>
			</tr>
			<tr class="orderInfo">
				<td>
					<div class="form-label-group newOrderForm">
						<form:input path="order.billAddr1" id="inputBillAddr1"
							class="form-control newOrderForm" />
						<B><form:errors path="order.billAddr1" class="newOrderForm" cssClass="error" /></B>
						<label for="inputBillAddr1">Address 1</label>
					</div>
				</td>
				<td>
					<div class="form-label-group newOrderForm">
						<form:input path="order.shipAddr1" id="inputShipAddr1"
							class="form-control newOrderForm" />
						<B><form:errors path="order.shipAddr1" class="newOrderForm" cssClass="error" /></B>
						<label for="inputShipAddr1">Address 1</label>
					</div>
				</td>
			</tr>
			<tr class="orderInfo">
				<td>
					<div class="form-label-group newOrderForm">
						<form:input path="order.billAddr2" id="inputBillAddr2"
							class="form-control newOrderForm" />
						<B><form:errors path="order.billAddr2" class="newOrderForm" cssClass="error" /></B>
						<label for="inputBillAddr2">Address 2</label>
					</div>
				</td>
				<td>
					<div class="form-label-group newOrderForm">
						<form:input path="order.shipAddr2" id="inputShipAddr2"
							class="form-control newOrderForm" />
						<B><form:errors path="order.shipAddr2" class="newOrderForm" cssClass="error" /></B>
						<label for="inputShipAddr2">Address 2</label>
					</div>
				</td>
			</tr>
			<tr class="orderInfo">
				<td>
					<div class="form-label-group newOrderForm">
						<form:input path="order.billCity" id="inputBillCity" class="form-control newOrderForm" />
						<B><form:errors path="order.billCity" class="newOrderForm" cssClass="error" /></B>
						<label for="inputBillCity">City</label>
					</div>
				</td>
				<td>
					<div class="form-label-group newOrderForm">
						<form:input path="order.shipCity" id="inputShipCity"
							class="form-control newOrderForm" />
						<B><form:errors path="order.shipCity" class="newOrderForm" cssClass="error" /></B>
						<label for="inputShipCity">City</label>
					</div>
				</td>
			</tr>
			<tr class="orderInfo">
				<td>
					<div class="form-label-group newOrderForm">
						<form:input path="order.billZip" id="inputBillZip" class="form-control newOrderForm" />
						<B><form:errors path="order.billZip" class="newOrderForm" cssClass="error" /></B>
						<label for="inputBillZip">ZipCode</label>
					</div>
				</td>
				<td>
					<div class="form-label-group newOrderForm">
						<form:input path="order.shipZip" id="inputShipZip"
							class="form-control newOrderForm" />
						<B><form:errors path="order.shipZip" class="newOrderForm" cssClass="error" /></B>
						<label for="inputShipZip">ZipCode</label>
					</div>
				</td>
			</tr>
			<tr class="orderInfo">
				<td>
					<div class="form-label-group newOrderForm">
						<form:input path="order.billCountry" id="inputBillCountry"
							class="form-control newOrderForm" />
						<B><form:errors path="order.billCountry" class="newOrderForm" cssClass="error" /></B>
						<label for="inputBillCountry">Country</label>
					</div>
				</td>
				<td>
					<div class="form-label-group newOrderForm">
						<form:input path="order.shipCountry" id="inputShipCountry"
							class="form-control newOrderForm" />
						<B><form:errors path="order.shipCountry" class="newOrderForm" cssClass="error" /></B>
						<label for="inputShipCountry">Country</label>
					</div>
				</td>
			</tr>
		</table>
		<br>
		<p>
			<c:if test="${param.payFlag eq 'success'}">
					<button type="submit" class="btn btn-dark">주문하기</button>
			</c:if>
			<c:if test="${param.payFlag ne 'success'}">
					<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo">결제하기</button>
			</c:if>
		</p>
		
		<!-- Payment Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h2 class="modal-title" id="exampleModalLabel">
							<font color="#40bea7">
								Payment Details
							</font>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</h2>
					</div>
					<div class="modal-body">
						<h4 class="card-title">Card Type</h4>
						<div class="form-label-group newOrderForm">
							<B><form:errors path="order.cardType" cssClass="error" /></B>
							<form:select path="order.cardType" class="form-control" id="cardType">
								<option value="Card Type"></option>
								<form:options items="${creditCardTypes}" />
							</form:select>
						</div>
					</div>
					
					<div class="modal-body" id="card" style="display: none">	
						<font color="red" size="2">* Use a fake number!</font>
						<div class="form-label-group newOrderForm">
							<form:input path="order.creditCard" id="inputCardNumber"
								class="form-control newOrderForm" />
							<B><form:errors path="order.creditCard" cssClass="error" /></B>
							<label for="inputCardNumber"><font size="3">Card Number</font></label>
						</div>
						<div class="form-label-group newOrderForm">
							<form:input path="order.expiryDate" id="inputName" class="form-control newOrderForm" />
							<B><form:errors path="order.expiryDate" cssClass="error" /></B>
							<label for="inputName"><font size="3">Expiry Date (MM/YY)</font></label>
						</div>
					</div>
					
					<div class="modal-footer" id="modalButton">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
						<button type="submit" class="btn btn-dark">주문하기</button>
					</div>
					
					<div class="modal-body" id="kakaopay" style="display: none">
						<font color="red" size="2">* 아이콘을 눌러 결제를 진행해주세요 *</font>
						<div class="form-label-group newOrderForm">
							<a href="<c:url value="/shop/kakaoPay.do"/>">
			            		<img src="${pageContext.request.contextPath}/images/payment_icon_yellow_large.png" alt="kakaoPay로 결제하기">
			        		</a>  
						</div>
					</div>
				</div>
			</div>
		</div>
	</form:form>
</div>
