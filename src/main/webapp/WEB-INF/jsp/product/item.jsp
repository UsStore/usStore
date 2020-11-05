<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="ItemHeader.jsp"%> 
<style>

	* {
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

                <span>Add Item</span>

            </div>

        </div>

    </div>  

    <div class="short-description">

        <div class="container">

            <div class="row">

                <div class="col-md-10" style="padding: 50px;">

					<h2>상품 추가하기</h2>
					<hr><br><br>
					<spring:hasBindErrors name="item" />
					<form:form modelAttribute="item" method="post" action="addItem2.do?productId=${productId}">
					
                    <!-- Title -->
                    <div class="product-info">
                    	<span class="badge badge-pill badge-dark" id="badge">제품명</span>
                    	<span>
	                    	<form:input type="text" path="title" style="margin-left: 10px; width:380px; height:35px;" value="${title}"/>
							<br><form:errors path="title" style="margin-left:150px"/>
						</span> <br><br>
                    </div>
                    
					<div class="product-info">
						<!-- Quantity -->
                        <span class="product-avilability">
                        	<span class="badge badge-pill badge-dark" id="badge">개수</span>
                        	<span>
								<form:input type="text" path="qty" style="margin-left:10px; width:380px; height:35px;" value="${qty}"/>
								<br><form:errors path="qty" style="margin-left:150px"/>
							</span><br><br>
						</span>
                    </div>

                    <div class="product-info">
                    	<!-- Description -->
                        <span class="badge badge-pill badge-dark" id="badge">제품 설명</span>
                        <span>
							<form:textarea path="description" style="margin-left:150px" cols="60" rows="5" value="${description}"/>
							<br><form:errors path="description" style="margin-left:150px"/>
						</span><br><br>
					</div>
					
					<c:set var="pId" value="${productId}"/>
					<c:if test="${pId == 1}">
					</c:if>
					<c:if test="${pId != 1}">
	                    <div class="product-info">
							<!-- unitCost  -->
	                        <span>
								<span class="badge badge-pill badge-dark" id="badge">원가</span>
								<span>
									<form:input type="text" path="unitCost" value="${unitCost}" style="margin-left:10px" />
									<br><form:errors path="unitCost" style="margin-left:150px"/>
								</span><br><br>		
	                        </span>
	                    </div>
                    </c:if>

					<!-- Tags -->
                    <div class="product-info">
                    	<span class="badge badge-pill" id="badge">태그</span>
                    	<br><br>
                    	<span>
	                        <c:forEach var="i" begin="0" end="4" step="1">
									<font style="margin-left:150px;">
										tag ${i+1} : <form:input path="tags[${i}].tagName" placeholder="태그를 입력해주세요." style="width:200px; height:35px;"/>
									</font><br><br>
							</c:forEach>
						</span>
					</div>
					
					<div align="right">
						<button type="submit" class="badge" id="submitButton">다음 단계로</button>
					</div>
					</form:form>
					 
                </div>
                
            </div>

        </div>

    </div> 
    
<%@ include file="../IndexBottom.jsp"%>