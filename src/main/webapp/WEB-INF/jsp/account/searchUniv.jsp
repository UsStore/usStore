<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대학교 찾기</title>
</head>
<body>
	<form action="api/university.do" method="post">
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
	      <label>대학교 찾기</label>
	      <input name="univName" type="text" />
	    </div>
	     <div>
	      <label>찾기 결과</label>
	      <input name="result" type="text" value="${result}"/>
	    </div>
	    
	    <button type="submit">찾기</button>
	    
	    <input type="button" name="confirm" value="확인"/> 
	    <!-- 
	    	univName으로 컨트롤러에서 대학교를 찾아준 다음에 그 결과를 
	    	다시 result 박스안에다가  보여주고 제대로 result값이 들어올 때만 확인 버튼을누를수있게 보여준다. 
	        요청 : region과 univName -> 응답 : result에다가 대학 이름보여준다 
	     -->
	</form>

</body>
</html>