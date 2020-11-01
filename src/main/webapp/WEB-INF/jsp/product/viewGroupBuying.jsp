<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="itemTop.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script>
function getReview(itemId) {   //매개변수 전달 시도 
    var reqUrl = "/usStore/rest/shop/getReview.do/" + itemId;
     $.ajax({         /* Ajax 호출을 위해  JQuery 이용 */
       type: "get",
       url: reqUrl,
       processData: false,
       success: function(responseJson){   // responseJson: JS object parsed from JSON text
       $("#result").html("<div>");
          // var index = 1;
          var obj = responseJson;
          $("#result > div").append("<table>" +
                  "<tr><th style='border-bottom: none; text-align: left;'>평점"+
                  "</th><th style='border-bottom: none; text-align: left;'>구매자</th>" + 
                  "<th style='border-bottom: none; text-align: left;'>리뷰</th></tr><hr width = 100% align='left'></table>");

      	$("#result > div").append("<table>");
			if(obj.length == 0) {   $("#result > div").append("<tr><td>작성된 리뷰가 없습니다.</td></tr>");   }   //리뷰가 존재하지 않을 경우
			else {
				for (var i in obj) {
					$("#result > div").append("<tr><td style='text-align: left;'>" + obj[i].rating + 
											"점</td><td style='text-align: left;'>익명<td style='text-align: left; width: 80%'>" + 
						                     obj[i].description + "</td></tr>");
					}
			}
			$("#result > div").append("<tr><td colspan='2' style='border-bottom: hidden; text-align: left;'>" + 
						"<a href='<c:url value='/shop/AllReviewList.do?itemId=" + itemId + "'/>'> [모든 리뷰 보기] </a>&nbsp;&nbsp;" + 
						
						"<a href='<c:url value='/shop/goAddReview.do?itemId=" + itemId + 
						"'/>'> [리뷰 작성하기] </a></td></tr><br></table></div>");
	         },
	         error: function(request,status,error){
	            alert("code = "+ request.status + " message = " + request.responseText);
	         }
    });
 };
</script>
<html>
<head>
<title>공동구매 상세페이지</title>
</head>
<style type="text/css"> 
   a { text-decoration:none } 
</style> 
<style>
   table#detail {
      border: none;
      text-align: center;
      font-size: medium;
      padding: 15px;
   }
   
   span#blue {
      width:10%; 
      height: 10px; 
      border: 1px solid blue;
      border-radius: 2em;
      font-size: small;
      text-align: center;
      padding: 5px;
   }
   
   span#gray {
      width:10%; 
      height: 10px; 
      border: 1px solid gray;
      border-radius: 2em;
      font-size: small;
      text-align: center;
      padding: 5px;
   }
   
   span#red {
      width:10%; 
      height: 10px; 
      border: 1px solid red;
      border-radius: 2em;
      font-size: small;
      text-align: center;
      padding: 5px;
   }
   
    th, td {
            border-bottom: 1px solid black;
             border-collapse: collapse;
             text-align: center;
             font-size: medium;
             padding: 15px;
   }
   
</style>
<script>
function gbJoint(itemId) {
	if(confirm("공동구매에 참여하시겠습니까?")){
	    document.location.href="/usStore/shop/groupBuying/goCart.do?workingItemId=" + itemId + "&productId=0";	//확인 클릭
	 }
}
function removeGb(itemId) {
	if(confirm("정말 공동구매를 삭제하시겠습니까?")){
	    document.location.href="/usStore/shop/groupBuying/delete.do?itemId=" + itemId;	//확인 클릭
	 }
}
function editGb(itemId) {
	if(confirm("공동구매를 수정하시겠습니까?")){
	    document.location.href="/usStore/shop/groupBuying/edit.do?itemId=" + itemId;	//확인 클릭
	 }
}
function getTime() { 
   var time = "${gb.deadLine}";
   var year = time.substring(0, 4);
   var month = time.substring(5, 7) - 1;
   var day = time.substring(8, 10);
   var hour = time.substring(11, 13);
   var minute = time.substring(14, 16);
   var second = time.substring(17);
   
now = new Date(); 
dday = new Date(year, month, day, hour, minute, second); 
// 원하는 날짜, 시간 정확하게 초단위까지 기입.
days = (dday - now) / 1000 / 60 / 60 / 24; 
daysRound = Math.floor(days); 
hours = (dday - now) / 1000 / 60 / 60 - (24 * daysRound); 
hoursRound = Math.floor(hours); 
minutes = (dday - now) / 1000 /60 - (24 * 60 * daysRound) - (60 * hoursRound); 
minutesRound = Math.floor(minutes); 
seconds = (dday - now) / 1000 - (24 * 60 * 60 * daysRound) - (60 * 60 * hoursRound) - (60 * minutesRound); 
secondsRound = Math.round(seconds); 
document.getElementById("counter0").innerHTML = daysRound; 
document.getElementById("counter1").innerHTML = hoursRound; 
document.getElementById("counter2").innerHTML = minutesRound; 
document.getElementById("counter3").innerHTML = secondsRound; 
newtime = window.setTimeout("getTime();", 1000); 
} 
</script>
<body>
<h3>공동구매</h3>
<hr width = "927px" align="center"><br>
   <table id="detail" style="margin-left: auto; margin-right: auto;">
   <tr>
      <td style="text-align: left; padding: 0px; font-size: small; border-bottom: none;">
      ${gb.viewCount}<font color=gray>view</font>
      </td>
      <td style="text-align: right; padding: 0px; font-size: small; border-bottom: none;">
   
   </tr>
         <tr>
            <th style="border-right: 1px solid black; border-top: 1px solid black;">제목</th>
            <td style="border-top: 1px solid black;">${gb.title}
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <c:choose>
            <c:when test="${gb.state == 1}"><span id="gray">공동구매 마감</span></c:when>
            <c:otherwise><span id="red"><font color="red">공동구매 진행중</font></span></c:otherwise>
         </c:choose>
            
            </td>
         </tr>
         
         <tr>
            <th style="border-right: 1px solid black;">판매자</th>
            <td>${gb.userId}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;
            <c:if test="${gb.userId ne userSession.account.userId}">
                  <span id="blue">
                     <c:choose>
                           <c:when test="${! empty userSession.account.userId}">
                           <%@ include file="/WEB-INF/jsp/account/accuseFunction.jsp" %>
                        </c:when>
                        <c:otherwise>           
                           <a href="<c:url value='/addAccuseNoLogin.do'>
                                   <c:param name="itemId" value="${gb.itemId}"/>
                                     <c:param name="productId" value="${gb.productId}"/></c:url>">
                                          판매자 신고하기
                           </a>
                        </c:otherwise>
                     </c:choose>
                  </span>
              </c:if>
            </td>
         </tr>
         
         <tr><td colspan="2" style="padding: 15px;">${gb.description}<br></td></tr>
         
         <tr>
            <th style="border-right: 1px solid black;">제품 사진</th>
            <td>
            <img src="getImage.do?itemId=${gb.itemId}" width="350" height="230" onerror="this.style.display='none'" />
               <br/>
            </td>
         </tr>
         
         <tr>
            <th style="border-right: 1px solid black;"><font color=blue>#</font>관련태그</th>
            <td>
            <c:forEach var="tag" items="${tags}">        
               <a href='<c:url value="/shop/search/viewItem.do">
               <c:param name="tagName" value="${tag.tagName}"/></c:url>'>
               #${tag.tagName}
            </a>&nbsp;
         </c:forEach>
            </td>
         </tr>
         
         <tr>
            <th style="border-right: 1px solid black;"><font color=red>마감기한</font></th>
            <td width="400"><font color=red>
               ${gb.deadLine}
            </font>
            <c:set var="state" value="${gb.state}"/>
               <c:if test="${state eq 0}">
               	<br><br>공동구매 종료까지 "<font id=counter0></font>일 <font id=counter1></font>시간 <font id=counter2></font>분 <font id=counter3></font>초" 남았습니다
               </c:if>
            </td>
         </tr>
         
         <c:if test="${gb.state eq 0}">
            <script>getTime()</script>
         </c:if>
        
         <tr>
         <th style="border-right: 1px solid black;">할인율</th>
            <td>
               <p><del>정가 : ${gb.listPrice}원</del></p>
                     할인가 : ${gb.unitCost}원&nbsp;<font color=red>&nbsp;&nbsp;&nbsp;${gb.discount}% 할인</font> <br>
            </td>
         </tr>
         
         <tr>
         <th style="border-right: 1px solid black;">수량 </th> 
         <td>${gb.qty} 개 남았습니다.</td>
         </tr>
         
         
            
         <c:if test="${gb.state == 0 && gb.userId ne userSession.account.userId}"> <!-- 공동구매 진행중 && 작성자와 본인 아이디가 다르면 공동구매 참여 가능 -->
               <tr>
                  <td colspan="2" style="border-bottom: none;">
               <span id="blue">
                  <a href="javascript:gbJoint(${gb.itemId})">공동구매 참여하기</a>
                 
               </span>
                </td>
               </tr>
            </c:if>
            <c:if test="${gb.state == 1}">   <!-- 공동구매 마감 -->
               <tr>
                  <td colspan="2" style="border-bottom: none;">
               <span id="gray">
                     공동구매가 마감되었습니다.
               </span>
                </td>
               </tr>
            </c:if>
            
         <c:if test="${gb.userId eq userSession.account.userId}"> <!-- ë¡ ê·¸ì ¸ì   ì ¤í   -->
            <tr>
               <td colspan="2" style="text-align: right; padding: 0px; font-size: small; border-bottom: none; border-top: 1px solid black;">
               <a href="javascript:editGb(${gb.itemId})">[게시물 수정하기]</a>
               <a href="javascript:removeGb(${gb.itemId})">[게시물 삭제하기]</a>
            </td>
          </tr>
      </c:if>
    
      <!--* 현재 로그인 user가 글 작성자 일때만 수정/삭제 버튼이 보임 
   * 작성자 정보는 controller에서 model(db에서 suppId찾아옴)로 넘겨줌
   * model로 넘어온 suppId와 세션의 로그인Id를 비교함 
   * 세션에 로그인 정보가 없으면, 즉 null이어도 수정/삭제 안보여줌-->
      </table>
      <br>

	<form name="pform" action="">
		<div style="font-size: 15px">
			<script>getReview(${gb.itemId});</script>
			<div id="result"></div>
		</div>
	</form>
	<br>
	<br>
</body>
</html>