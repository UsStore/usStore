<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../ItemHeader.jsp"%> 
<%@ page import="com.example.usStore.controller.item.ItemForm" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
 
<style>

	.short-description, span {
		font-size: 20px;
	}
	
	.product-info {
		font-size: 15px;
		padding-bottom: 10px;
		align-items: center;
	
	}
	
	#badge {
		padding: 10px 15px 10px 15px;
		margin-right: 30px;
		font-size: 20px;
		min-width: 150px;
		background-color: #29403C;
	}
	
	#tag {
		padding: 10px 15px 10px 15px;
		margin-right: 30px;
		font-size: 20px;
		min-width: 100px;
		background-color: #81CABD;
	}
	
	#submitButton {
		padding: 10px 15px 10px 15px;
		margin-right: 30px;
		font-size: 25px;
		min-width: 100px;
		background-color: #308C7B;
	}
	
	hr {
		background-color: #308C7B;
		height: 7px;
	}
	
</style>

    <div class="breadcumbs">

        <div class="container">

            <div class="row">

                <span>Home > </span>

                <span>Category > </span>

                <span>GroupBuying > </span>

                <span>Check Item</span>

            </div>

        </div>

    </div>  

    <div class="short-description">

        <div class="container">

            <div class="row">

                <div class="col-md-10" style="padding: 50px;">

					<h2>공동 구매 제품 확인하기</h2>
					<h4>다음 정보로 작성하시겠습니까?</h4>
					<hr><br><br>
					<spring:hasBindErrors name="item" />
					<form:form modelAttribute="GroupBuying" action="detailItem.do">
                    <!-- Title -->
                    <div class="product-info">
                    	<span class="badge badge-pill badge-dark" id="badge">제품명</span>
                    	<span>
	                    	${itemForm.title}
						</span> <br><br>
                    </div>

                    <div class="product-info">
                    	<!-- Description -->
                        <span class="badge badge-pill badge-dark" id="badge">제품 설명</span>
                        <span>
							${itemForm.description}
						</span>
					</div>
					<br>         
					<div class="product-info">
						<!-- Quantity -->
                        <span class="product-avilability">
                        	<span class="badge badge-pill badge-dark" id="badge">개수</span>
                        	<span>
								${itemForm.qty} 개
							</span>
						</span>
                    </div>
					<br>
					
 					<div class="product-info">
                    	<!-- unitCost -->
                        <span class="badge badge-pill badge-dark" id="badge">원가</span>
                        <span>      
                        	${itemForm.unitCost} 원       
						</span>
					</div>
					<br>
					
 					<div class="product-info">
                    	<!-- listPrice -->
                        <span class="badge badge-pill badge-dark" id="badge">판매가</span>
                        <span>      
                        	${GroupBuying.listPrice} 원           
						</span>
					</div>
					<br>
					
 					<div class="product-info">
                    	<!-- discount -->
                        <span class="badge badge-pill badge-dark" id="badge">할인율</span>
                        <span>      
                        	${GroupBuying.discount} %           
						</span>
					</div>
					<br>
					
 					<div class="product-info">
                    	<!-- deadLine -->
                        <span class="badge badge-pill badge-dark" id="badge">마감 기한</span>
                        <span>  
							${GroupBuying.deadLine}               
						</span>
					</div>
					<br>					

                    <div class="product-info">
                    	<!-- Product Image -->
                        <span class="badge badge-pill badge-dark" id="badge">상품 사진</span>
                        <span>
                        	${imgName}
						</span><br><br>
					</div>
											
					<!-- Tags -->
                    <div class="product-info">
                    	<span class="badge badge-pill" id="badge">태그</span>
                    	<br><br>
                    	<span>
							<c:forEach var="tag" items="${tags}"> 
							    <c:if test="${not empty tag.tagName}">	                    
									<span class="badge badge-pill" id="tag"> # ${tag.tagName} </span>             
								</c:if>	              
							</c:forEach>
						</span>
					</div>
					
					<br><br><br>
					<div align="right">
						<a href="<c:url value='/shop/groupBuying/addItem2.do'>
						         <c:param name="productId" value="${itemForm.productId}"/></c:url>" id="submitButton" class="badge">
						         이전 단계로</a>
					   <button type="submit" class="badge" id="submitButton">확인</button>
					</div>
					</form:form>										 
                </div>
                
            </div>

        </div>

    </div>

<%@ include file="../IndexBottom.jsp"%>