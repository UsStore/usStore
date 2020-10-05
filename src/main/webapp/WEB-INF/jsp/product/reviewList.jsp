<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="itemTop.jsp" %>

<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록</title>
</head>
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
        <c:if test="${empty reviews}"> <tr><td style="text-align: center;"> 아직 리뷰가 없습니다. </td></tr></c:if>
        
         <c:forEach var="review" items="${reviewList.pageList}">
            <!-- 평점 기준 별표시 출력 -->
            <tr>
                <td>
                	<c:forEach var="rating" items="${ ratingOptions }" varStatus="status" begin="1" end="${ review.rating }">★</c:forEach>
                	<c:forEach var="rating" items="${ ratingOptions }" varStatus="status" begin="${ review.rating }" end="4">☆</c:forEach>
                &nbsp;&nbsp;${ review.rating }점
                </td>
                <td>익명</td>
                <td>${review.description}</td>
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
		</tbody>
</table>
</body>
</html>