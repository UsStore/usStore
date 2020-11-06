<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script>
    var reqUrl ="/usStore/rest/shop/getInquiry.do/" + ${sh.itemId};
 	$.ajax({        
	       type: "get",
	       url: reqUrl,
	       contentType: "application/json",
	       success: function(data){   

	       $("#inquiryList").append("<table>" +
	                  "<tr><td>제목</td>" + 
	                  "<td>작성자</td>" + 
	                  "<td>작성날짜</td></tr>");

			if(data.length == 0) {   // 응답 결과가 존재하지 않을 경우
				$("#inquiryList > table").append("<tr><td colspan='3'>제품 문의 사항이 없습니다.</td></tr></table>");   
			} else {
				for (var i in data) {
					$("#inquiryList > table").append("<tr><td>" + data[i].title 
							+ "</td><td>" + data[i].userId + "</td><td>" + "2020-11-06" + "</td></tr>");
				}
			}
			$("#inquiryList > table").append("<tr><td colspan='3'style='border-bottom:hidden; padding-top: 50px;'>" + 
						"<a href='<c:url value='/shop/goAddInquiry.do?itemId=" + ${sh.itemId} + 
						"'/>'> <span class='badge badge-pill badge-dark' id='badge'>제품 문의하기</span> </a></td></tr></table></div>");
		    }, error: function(request,status,error){
		            alert("code = "+ request.status + " message = " + request.responseText);
		    }
		    
   });

	 
</script>