<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../ItemHeader.jsp"%> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script>
   function getJson(productId) {   //매개변수 전달 시도 
      var reqUrl = "../rest/shop/getData.do/" + productId;
       $.ajax({         /* Ajax 호출을 위해  JQuery 이용 */
         type: "get",
         url: reqUrl,
         processData: false,
         success: function(responseJson){   // responseJson: JS object parsed from JSON text
            $("#result").html("<div><div>");
               var index = 1;
               var obj = responseJson;

               for (var i in obj) { 
                  $("#result > div").append("<tr><th>" + index + "위 </th><th><a href='<c:url value='/shop/rank/viewItem.do?itemId=" + obj[i].itemId + 
                          "&productId=" + productId + "'/>'>" + obj[i].title + "</a></th><th>누적 조회수   ( " + obj[i].viewCount + " 회 )</th></tr>"); 
               index++;
              }
              $("#result > div").append("</table><br></div></div>");   
          },
         error: function(){
            alert("ERROR", arguments);
         }
      });
   };
</script>
<html>
<head>
<title>랭킹 페이지</title>
<style>
	th, td {
	   text-align: center;
	   height: 70px;
	   padding-left: 43px;
	   padding-right: 43px;
	}

	#badge {
		padding: 10px 15px 10px 15px;
		margin-right: 30px;
		font-size: 20px;
		min-width: 150px;
		background-color: #29403C;
	}
	
	hr {
		background-color: #308C7B;
		height: 7px;
		margin : 40px;
	}
</style>
</head>

<body>    
   <form name="pform" action="" style="min-height:100%;">
       <div class="container" align="center">
         <div class="row" style="display: inline">
            <div style="display: inline;">
               <div style="font-size: 15px; padding-top: 20px">
                  <h2>조회수 랭킹</h2>
				  <hr>
                  <table>
                     <tr>
                        <td><span class="badge badge-pill" id="badge" onclick="getJson(3);">수공예 판매</span></td>
                        <td><span class="badge badge-pill" id="badge" onclick="getJson(2);">중고 거래</span></td>
                        <td><span class="badge badge-pill" id="badge" onclick="getJson(1);">경매</span></td>
                        <td><span class="badge badge-pill" id="badge" onclick="getJson(0);">공동 구매</span></td>
                     </tr>
                     <br>
                  </table>
                  <br>
                  <div id="result" style="padding: 50px; font-size: 20px;"></div>
               </div>
            </div>
         </div>
      </div>
   </form>
  

<%@ include file="../IndexBottom.jsp" %>