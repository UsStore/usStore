<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="itemTop.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<title>중고거래 게시물 목록</title>
<style>
			th, td {
			    text-align: center;
			    height:70px;
			    padding-left:50px;
			    padding-right:50px;
			}
</style>
</head>
<body>
   <!-- db에서 select 결과 보여주는 페이지 -->
   <form name = "pform" action="" style="position:absolute; left:45%; margin:0 0 0 -420px;">
      <div class="container" >
         <div class="row"  style="display:inline">
            <div style="display:inline;float:left;">
               <div style="font-size:15px">
                  <h2>
                     SecondHand List
                  </h2>
                    <p style="text-align:right;">
	                   	<a href="<c:url value='/shop/item/addItem.do'>
	                       <c:param name="productId" value="${productId}"/></c:url>">중고거래 물품 판매하기
	                  	</a>
					</p>		
	                <div>    
	         
	                  	<p style="text-align:right;">
					      <label>지역별 게시물</label> 
					      <select id="region" name="region" onchange="location.href=this.value">
					      	<option value="선택하세요">선택하세요</option>
					      	<option value="/usStore/shop/secondHand/region/서울특별시">서울특별시</option>
					      	<option value="부산광역시">부산광역시</option> 
					      	<option value="인천광역시">인천광역시</option>
					      	<option value="대전광역시">대전광역시</option>
					      	<option value="대구광역시">대구광역시</option>
					      	<option value="울산광역시">울산광역시</option>
					      	<option value="광주광역시">광주광역시</option>
					      	<option value="경기도">경기도</option>
					      	<option value="강원도">강원도</option>
					      	<option value="충청북도">충청북도</option>
					      	<option value="충청남도">충청남도</option>
					        <option value="전라북도">전라북도</option>
					        <option value="전라남도">전라남도</option>
					      	<option value="경상북도">경상북도</option>
					      	<option value="경상남도">경상남도</option>	      	
					      	<option value="제주특별자치도">제주도</option>
					      </select>
						</p>	
 
			  	   </div>	
                  <hr>                                
				<table>
   				<tr>
   					<th>제목</th>
   					<th>흥정 가능 여부</th>
   					<th>정가</th>
   					<th>판매가</th>
   					<th>&nbsp;</th>
   				</tr>
  				<tbody> 
	    			<c:forEach var="item" items="${secondHandList.pageList}">
		      			<tr style="height:70px;">
		         		<td>
                                <a href="<c:url value='/shop/secondHand/viewItem.do'>
                                    <c:param name="itemId" value="${item.itemId}"/>
                                    <c:param name="productId" value="${productId}"/>
                                         </c:url>">
                                      <font style="padding-left:30px"><c:out value="${item.title}"/></font>
                                </a>
                   		</td>
		         		<c:choose>
	   					 	<c:when test="${item.discount eq 1}">
							        <td style="padding-left:120px"><c:out value="에눌 가능" /></td> 
							</c:when>
							<c:otherwise>
							 		<td style="padding-left:120px"> <c:out value="에눌 불가능" /></td> 
						    </c:otherwise>
						</c:choose>
				 		<td><fmt:formatNumber value="${item.listPrice}" pattern="###,###원" /></td>              
						<td><fmt:formatNumber value="${item.unitCost}" pattern="###,###원" /></td>
		      			<td><a href='<c:url value="/shop/addItemToCart.do">
					            				<c:param name="workingItemId" value="${item.itemId}"/>
					            				<c:param name="productId" value="${item.productId}"/></c:url>'>
					              		<img width="40" height="40" src="${pageContext.request.contextPath}/images/cart_img.png" alt="" /></a></td>
						</tr>
	     			</c:forEach></tbody>
	     			
	     			 <tr>
      					<td style="text-align: left;">
        					<c:if test="${!secondHandList.firstPage}">
          					<a href='<c:url value="/shop/secondHand/listItem2.do">
	           								<c:param name="pageName" value="previous"/>
	           								<c:param name="productId" value="${productId}"/>
	           								</c:url>'> 
	           					<font color="black"><B>&lt;&lt; Prev</B></font>
        					</a>
        					</c:if></td><td/><td/>
        						<td style="text-align: right;">
								<c:if test="${!secondHandList.lastPage}">
									<a href='<c:url value="/shop/secondHand/listItem2.do">/>
	            							 	<c:param name="pageName" value="next"/>
	            							 	<c:param name="productId" value="${productId}"/>
	            							 </c:url>'>
										<font color="black"><B>Next &gt;&gt;</B></font>
									</a>
								</c:if>
							</td>
    				</tr>
                </tbody>
                  </table>
               </div>
            </div>
         </div>
      </div>
   </form>
</body>
</html>