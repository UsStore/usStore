<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../ItemHeader.jsp"%> 
<script>
	 function rmReview(itemId) {
		if(confirm("정말 리뷰를 삭제하시겠습니까?")){
		    document.location.href="/usStore/shop/deleteReview.do?itemId=" + itemId;	//확인 클릭
		 }
	} 
</script>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록</title>
</head>
<style>
	td#red {
	      width:10%; 
	      height: 10px; 
	      border: 1px solid red;
	      border-radius: 2em;
	      font-size: small;
	      text-align: center;
	      padding: 5px;
	      background-color: white;
	      padding-top:14px;
	   }
</style>
<body>
<table class="table table-stripped" id="reviews">
    <thead>
        <tr>
            <th>평점</th> <!-- 평점 -->
            <th>구매자</th>
            <th>리뷰</th>
        </tr>
    </thead>
    <tbody>
        <c:if test="${empty reviews}"> <tr><td style="text-align: center;"> 작성된 리뷰가 없습니다. </td></tr></c:if>
        
         <c:forEach var="review" items="${reviewList.pageList}">
            <!-- 평점 기준 별표시 출력 -->
	            <c:choose>
		            <c:when test="${review.buyer eq userSession.account.userId}">	<!-- 작성자가 본인인 경우 -->
		            	<tr bgcolor="#e3f2fd">
		            </c:when>
		            
		           <c:otherwise> 
	            		<tr>
	            	</c:otherwise>
	            </c:choose>
            
                <td>
                	<c:forEach var="rating" items="${ ratingOptions }" varStatus="status" begin="1" end="${ review.rating }">★</c:forEach>
                	<c:forEach var="rating" items="${ ratingOptions }" varStatus="status" begin="${ review.rating }" end="4">☆</c:forEach>
                &nbsp;&nbsp;${ review.rating }점
                </td>
                
                <c:choose>
                	<c:when test="${review.buyer ne userSession.account.userId}">	
	                	<td>익명</td>
	                </c:when>
	                <c:otherwise>
	                	<td><font color="blue">${review.buyer}</font></td>		<!-- 작성자가 본인인 경우 -->
	                </c:otherwise>
	            </c:choose>
                <td>${review.description}</td>
                
                <c:if test="${review.buyer eq userSession.account.userId}">		<!-- 작성자가 본인인 경우 -->
                	<td>
						<button type="button" onclick="rmReview(${itemId})">리뷰 삭제</button>
                	</td>
                </c:if>
            </tr>
        </c:forEach>

			<tr>
				<td style="text-align: left;"><c:if test="${!reviewList.firstPage}">
						<a href='<c:url value="/shop/AllReviewList2.do">
                                         <c:param name="pageName" value="previous"/>
                                         <c:param name="itemId" value="${itemId}"/>
                                      </c:url>'>
							<font color="black"><B>&lt;&lt; Prev</B></font>
						</a>
					</c:if></td>
				<td />
				<td style="text-align: right;"><c:if test="${!reviewList.lastPage}">
						<a href='<c:url value="/shop/AllReviewList2.do">/>
                                        <c:param name="pageName" value="next"/>
                                        <c:param name="itemId" value="${itemId}"/>
                                     </c:url>'>
							<font color="black"><B>Next &gt;&gt;</B></font>
						</a>
					</c:if></td>
			</tr>
			
			<tr>
				<td colspan = "3">
					<a href='<c:url value="/shop/goViewItem.do">/>
                    	 		 <c:param name="itemId" value="${itemId}"/>
                             </c:url>'>
					>상품 상세보기로 가기</a>
				</td>
			</tr>
		</tbody>
</table>
</body>
</html>