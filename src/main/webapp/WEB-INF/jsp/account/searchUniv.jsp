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

	var radioVal = null;

	function setDisplay(){   // 라디오 버튼클릭하면 확인 버튼 보이게 하기 
		var obj = $('input:radio[name="univName"]');
		
	    if(obj.is(':checked')){
		  
	        $('#confirmDiv').show();
	        radioVal = $('input[name="univName"]:checked').val(); 
	        obj.eq(radioVal).attr('checked', false);
	        
	    }else{
	        $('#confirmDiv').hide();
	    }
	}
 
	// [확인버튼]을 누르면 -> radioVal를 컨트롤러로 보내서 -> jsp로 넘겨주기     
	function setConfirm(name, link, addr){
		if(name != null){ // 확인버튼을 누르면 이 창이 닫히고 대학네임을 넘겨줘야함 
			window.opener.location.href="http://localhost:8080/usStore/shop/editAccount.do?" 
				+ "univName=" + name
				+ "&univLink=" + link
				+ "&univAddr=" + addr;
			window.close();
		}else{ // 라디오 버튼(대학) 선택안했으면 리다이렉트? 
			window.location.href="http://localhost:8080/usStore/shop/searchUniv.do";
		}
	}
	  
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
	      <input name="univName" type="text" /><button type="submit">검색 </button>
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
			                      ${result.univName}&nbsp; 
			                      <!-- <input type="radio" onchange="setDisplay();" value=${result.univName} name="univName" /> -->
			                   </td> 
			                   <td>
			                     <input type="button" name="confirm" id="confirmButton" value="선택" 
		                   			onclick="setConfirm('${result.univName}', '${result.univLink}','${result.univAddr}');"/>
			                   </td>
		                  </tr>
	                  </c:forEach>
	            </tbody>
	        	</table>
	        	<!-- <div id="confirmDiv" >
					<input type="button" name="confirm" id="confirmButton" value="확인" onclick="setConfirm();"/> 
				</div> -->
        </c:if>
	    </div>
	</form>

	<input type="button" name="exit" onClick="window.close();" value="닫기"/>
</body>
</html>