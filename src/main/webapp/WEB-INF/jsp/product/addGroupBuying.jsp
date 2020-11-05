<%@ include file="../ItemHeader.jsp"%> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar"%>

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
		min-width: 100px;
		background-color: #29403C;
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

                <span>Add Item > </span>

				<span>Add GroupBuying > </span>
				
            </div>

        </div>

    </div>  
	
    <div class="short-description">

        <div class="container">

            <div class="row">

                <div class="col-md-10" style="padding: 50px;">
                
					<h2>공동구매 상품 추가하기</h2>
					<hr><br><br>
					<spring:hasBindErrors name="GroupBuying" />
					<form:form modelAttribute="GroupBuying" method="post" enctype="multipart/form-data" action="step3.do?${_csrf.parameterName}=${_csrf.token}">
                    
                    <!-- ListPrice -->
                    <div class="product-info">
                    	<span class="badge badge-pill badge-dark" id="badge">판매가</span>
                    	<span>
                    	 	<form:input type="text" path="listPrice" value="${listPrice}" style="margin-left: 10px; width:380px; height:35px;"/>
					        <br><form:errors path="listPrice" style="margin-left:150px" /> 
						</span> <br><br>
                    </div>
                    
	                <!-- deadLine -->
                    <div class="product-info">
                    	<span class="badge badge-pill badge-dark" id="badge">마감 날짜</span>
                    	<span>
                    		<form:input type="date" path="date" style="margin-left: 10px; width:380px; height:35px;"/><br>
							<form:input type="time" path="time" style="margin-left: 150px; width:380px; height:35px;"/> 
							<br><form:errors path="deadLine" style="margin-left:150px"/> 	
						</span> <br><br>

                    </div>
                    
                    <!-- Description -->
                    <div class="product-info">
                        <span class="badge badge-pill badge-dark" id="badge">상품 사진 추가</span>
                        <br><br>
                        <span>
                        	<input type="file" name="file" style="margin-left: 10px;"/>
						</span><br><br>
					</div>
					
					<div align="right">
						<a href="<c:url value='/shop/groupBuying/gobackItem.do'>
						         <c:param name="productId" value="${productId}"/></c:url>" id="submitButton" class="badge">
						         이전 단계로</a>
					   <button type="submit" class="badge" id="submitButton">다음 단계로</button>
					</div>
					</form:form>
					 
                </div>
                
            </div>

        </div>

    </div> 

<%@ include file="../IndexBottom.jsp"%>