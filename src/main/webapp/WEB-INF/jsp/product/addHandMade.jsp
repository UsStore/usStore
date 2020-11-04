<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="ItemHeader.jsp"%> 
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

                <span>HandMade > </span>

                <span>Add Item > </span>

				<span>Add HandMade > </span>
				
            </div>

        </div>

    </div>  

    <div class="short-description">

        <div class="container">

            <div class="row">

                <div class="col-md-10" style="padding: 50px;">
                
					<h2>수공예 상품 추가하기</h2>
					<hr><br><br>
					<spring:hasBindErrors name="handMadeForm" />
					<form:form modelAttribute="handMadeForm" method="post" enctype="multipart/form-data" action="step3.do?${_csrf.parameterName}=${_csrf.token}">
                    <!-- ListPrice -->
                    <div class="product-info">
                    	<span class="badge badge-pill badge-dark" id="badge">정가</span>
                    	<span>
                    	 	<form:input type="text" path="listPrice" value="${listPrice}" style="margin-left: 10px; width:380px; height:35px;"/>
					        <br><form:errors path="listPrice" style="margin-left:150px" /> 
						</span> <br><br>
                    </div>

                    <div class="product-info">
                    	<!-- Description -->
                        <span class="badge badge-pill badge-dark" id="badge">상품 사진 추가</span>
                        <br><br>
                        <span>
                        	<input type="file" name="file" style="margin-left: 10px;"/>
						</span><br><br>
					</div>
					
					<div align="right">
						<a href="<c:url value='/shop/handMade/gobackItem.do'>
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