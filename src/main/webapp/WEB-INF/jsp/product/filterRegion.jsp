<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	   	<c:choose>
	   	      <c:when test="${productId == 0}">
                   <div>    
	          		<p style="text-align:right;">
					<label><font size="3">List By Location &nbsp;</font></label> 
					<select id="region" name="region" onchange="location.href=this.value">
					      	<option value="선택하세요">선택하세요</option>
					      	<option value="/usStore/shop/groupBuying/listItem.do?productId=0&region=서울특별시">서울특별시</option>
					      	<option value="/usStore/shop/groupBuying/listItem.do?productId=0&region=부산광역시">부산광역시</option> 
					      	<option value="/usStore/shop/groupBuying/listItem.do?productId=0&region=인천광역시">인천광역시</option>
					      	<option value="/usStore/shop/groupBuying/listItem.do?productId=0&region=대전광역시">대전광역시</option>
					      	<option value="/usStore/shop/groupBuying/listItem.do?productId=0&region=대구광역시">대구광역시</option>
					      	<option value="/usStore/shop/groupBuying/listItem.do?productId=0&region=울산광역시">울산광역시</option>
					      	<option value="/usStore/shop/groupBuying/listItem.do?productId=0&region=광주광역시">광주광역시</option>
					      	<option value="/usStore/shop/groupBuying/listItem.do?productId=0&region=경기도">경기도</option>
					      	<option value="/usStore/shop/groupBuying/listItem.do?productId=0&region=강원도">강원도</option>
					      	<option value="/usStore/shop/groupBuying/listItem.do?productId=0&region=충청북도">충청북도</option>
					      	<option value="/usStore/shop/groupBuying/listItem.do?productId=0&region=충청남도">충청남도</option>
					        <option value="/usStore/shop/groupBuying/listItem.do?productId=0&region=전라북도">전라북도</option>
					        <option value="/usStore/shop/groupBuying/listItem.do?productId=0&region=전라남도">전라남도</option>
					      	<option value="/usStore/shop/groupBuying/listItem.do?productId=0&region=경상북도">경상북도</option>
					      	<option value="/usStore/shop/groupBuying/listItem.do?productId=0&region=경상남도">경상남도</option>	      	
					      	<option value="/usStore/shop/groupBuying/listItem.do?productId=0&region=제주특별자치도">제주도</option>
					 </select>	      
					</p>	
					</div>
               </c:when>
               <c:when test="${productId == 1}">
                   <div>    
	          		<p style="text-align:right;">
					<label><font size="3">List By Location &nbsp;</font></label> 
					<select id="region" name="region" onchange="location.href=this.value">
					      	<option value="선택하세요">선택하세요</option>
					      	<option value="/usStore/shop/auction/listItem.do?productId=1&region=서울특별시">서울특별시</option>
					      	<option value="/usStore/shop/auction/listItem.do?productId=1&region=부산광역시">부산광역시</option> 
					      	<option value="/usStore/shop/auction/listItem.do?productId=1&region=인천광역시">인천광역시</option>
					      	<option value="/usStore/shop/auction/listItem.do?productId=1&region=대전광역시">대전광역시</option>
					      	<option value="/usStore/shop/auction/listItem.do?productId=1&region=대구광역시">대구광역시</option>
					      	<option value="/usStore/shop/auction/listItem.do?productId=1&region=울산광역시">울산광역시</option>
					      	<option value="/usStore/shop/auction/listItem.do?productId=1&region=광주광역시">광주광역시</option>
					      	<option value="/usStore/shop/auction/listItem.do?productId=1&region=경기도">경기도</option>
					      	<option value="/usStore/shop/auction/listItem.do?productId=1&region=강원도">강원도</option>
					      	<option value="/usStore/shop/auction/listItem.do?productId=1&region=충청북도">충청북도</option>
					      	<option value="/usStore/shop/auction/listItem.do?productId=1&region=충청남도">충청남도</option>
					        <option value="/usStore/shop/auction/listItem.do?productId=1&region=전라북도">전라북도</option>
					        <option value="/usStore/shop/auction/listItem.do?productId=1&region=전라남도">전라남도</option>
					      	<option value="/usStore/shop/auction/listItem.do?productId=1&region=경상북도">경상북도</option>
					      	<option value="/usStore/shop/auction/listItem.do?productId=1&region=경상남도">경상남도</option>	      	
					      	<option value="/usStore/shop/auction/listItem.do?productId=1&region=제주특별자치도">제주도</option>
					 </select>	      
					</p>	
					</div>
               </c:when>
               <c:when test="${productId == 2}">
                   <div>    
	          		<p style="text-align:right;">
					<label><font size="3">List By Location &nbsp;</font></label> 
					<select id="region" name="region" onchange="location.href=this.value">
					      	<option value="선택하세요">선택하세요</option>
					      	<option value="/usStore/shop/secondHand/listItem.do?productId=2&region=서울특별시">서울특별시</option>
					      	<option value="/usStore/shop/secondHand/listItem.do?productId=2&region=부산광역시">부산광역시</option> 
					      	<option value="/usStore/shop/secondHand/listItem.do?productId=2&region=인천광역시">인천광역시</option>
					      	<option value="/usStore/shop/secondHand/listItem.do?productId=2&region=대전광역시">대전광역시</option>
					      	<option value="/usStore/shop/secondHand/listItem.do?productId=2&region=대구광역시">대구광역시</option>
					      	<option value="/usStore/shop/secondHand/listItem.do?productId=2&region=울산광역시">울산광역시</option>
					      	<option value="/usStore/shop/secondHand/listItem.do?productId=2&region=광주광역시">광주광역시</option>
					      	<option value="/usStore/shop/secondHand/listItem.do?productId=2&region=경기도">경기도</option>
					      	<option value="/usStore/shop/secondHand/listItem.do?productId=2&region=강원도">강원도</option>
					      	<option value="/usStore/shop/secondHand/listItem.do?productId=2&region=충청북도">충청북도</option>
					      	<option value="/usStore/shop/secondHand/listItem.do?productId=2&region=충청남도">충청남도</option>
					        <option value="/usStore/shop/secondHand/listItem.do?productId=2&region=전라북도">전라북도</option>
					        <option value="/usStore/shop/secondHand/listItem.do?productId=2&region=전라남도">전라남도</option>
					      	<option value="/usStore/shop/secondHand/listItem.do?productId=2&region=경상북도">경상북도</option>
					      	<option value="/usStore/shop/secondHand/listItem.do?productId=2&region=경상남도">경상남도</option>	      	
					      	<option value="/usStore/shop/secondHand/listItem.do?productId=2&region=제주특별자치도">제주도</option>
					 </select>	      
					</p>	
					</div>
               </c:when>
               <c:when test="${productId == 3}">
                   <div>    
	          		<p style="text-align:right;">
					<label><font size="3">List By Location &nbsp;</font></label> 
					<select id="region" name="region" onchange="location.href=this.value">
					      	<option value="선택하세요">선택하세요</option>
					      	<option value="/usStore/shop/handMade/listItem.do?productId=3&region=서울특별시">서울특별시</option>
					      	<option value="/usStore/shop/handMade/listItem.do?productId=3&region=부산광역시">부산광역시</option> 
					      	<option value="/usStore/shop/handMade/listItem.do?productId=3&region=인천광역시">인천광역시</option>
					      	<option value="/usStore/shop/handMade/listItem.do?productId=3&region=대전광역시">대전광역시</option>
					      	<option value="/usStore/shop/handMade/listItem.do?productId=3&region=대구광역시">대구광역시</option>
					      	<option value="/usStore/shop/handMade/listItem.do?productId=3&region=울산광역시">울산광역시</option>
					      	<option value="/usStore/shop/handMade/listItem.do?productId=3&region=광주광역시">광주광역시</option>
					      	<option value="/usStore/shop/handMade/listItem.do?productId=3&region=경기도">경기도</option>
					      	<option value="/usStore/shop/handMade/listItem.do?productId=3&region=강원도">강원도</option>
					      	<option value="/usStore/shop/handMade/listItem.do?productId=3&region=충청북도">충청북도</option>
					      	<option value="/usStore/shop/handMade/listItem.do?productId=3&region=충청남도">충청남도</option>
					        <option value="/usStore/shop/handMade/listItem.do?productId=3&region=전라북도">전라북도</option>
					        <option value="/usStore/shop/handMade/listItem.do?productId=3&region=전라남도">전라남도</option>
					      	<option value="/usStore/shop/handMade/listItem.do?productId=3&region=경상북도">경상북도</option>
					      	<option value="/usStore/shop/handMade/listItem.do?productId=3&region=경상남도">경상남도</option>	      	
					      	<option value="/usStore/shop/handMade/listItem.do?productId=3&region=제주특별자치도">제주도</option>
					 </select>	      
					</p>	
					</div>
               </c:when>
               
		</c:choose>
		