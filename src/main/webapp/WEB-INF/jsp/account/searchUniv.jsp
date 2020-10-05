<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대학교 찾기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script type="text/javascript">
	function check() {
		alert("체크 메소드진입 ");
	    alert(window.location.href);
	    
	    UrlPathHelper urlPathHelper = new UrlPathHelper(); 
	    String originalURL = urlPathHelper.getOriginatingRequestUri(request); 
	    alert("OriginalURL ==>" + originalURL);
	}

	$(document).ready(function () {
	  	// 라디오버튼 클릭시 이벤트 발생
	  	$("input:radio[name=univName]").click(function(){
	  	    	 var radioVal = $('input[name="univName"]:checked').val();
	  	    	 var answer = confirm(radioVal + "을(를) 자신의 대학교로 선택하기 ");
				 if(answer == true){  // 새로운 요청 보내서 에딧트던 회원가입이던 그 페이지에 대학이름 삽입하기 
					 alert(answer);
				 }else{ window.go(-1);}
	  	});
	});
</script>
</head>
<body>
	<form action="http://localhost:8080/usStore/api/university.do" method="post">
	    <div>
	      <label>지역</label> 
	      <select id="region" name="region">
	      	<option value="선택하세요">선택하세요</option>
	      	<option value="서울특별시">서울특별시</option>
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
	    </div>
	    <div>
	      <label>학교명</label>
	      <input name="univName" type="text" /><button type="submit" onclick="check();">검색 </button>
	    </div>
	      
	     <div>
	     <br>
	     <c:if test="${fn:length(results) ne 0}">
				 <table>
				 <tr>
	                  <th style="padding-left:20px">검색 결과</th>
	             </tr>
	             <tbody>   
	                  <c:forEach var="result" items="${results}">         
		                  <tr style="height:20px;">
			                  <td style="padding-left:20px">
			                      ${result}&nbsp; <input type="radio" name="univName" value=${result}>
			                   </td>
		                  </tr>
	                  </c:forEach>
	            </tbody>
	        	</table>
				<!-- <input type="button" name="confirm" id="radioButton" value="확인"/>  -->
        </c:if>
	    </div>
	</form>

	<input type="button" name="exit" onClick="window.close();" value="닫기"/>
</body>
</html>