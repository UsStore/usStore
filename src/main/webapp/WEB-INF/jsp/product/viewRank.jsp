<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="itemTop.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js">
</script>
<script>
   function getJson(productId) {   //매개변수 전달 시도 
      var reqUrl = "../rest/shop/getData.do/" + productId;
      //var reqUrl = "/shop/getData.do/" + productId;
       $.ajax({         /* Ajax 호출을 위해  JQuery 이용 */
         type: "get",
         url: reqUrl,
         processData: false,
         success: function(responseJson){   // responseJson: JS object parsed from JSON text
            $("#result").html("<div><div>");
               var index = 1;
               var obj = responseJson;
              $("#result > div").append("<table><tr><center>[ " + obj[0].category + " ]</center></tr><br><br>");
              for (var i in obj) { 
                  $("#result > div").append("<tr><th>" + index + "위 </th><th><a href='<c:url value='/shop/rank/viewItem.do?itemId=" + obj[i].itemId + 
                          "&productId=" + productId + "'/>'>" + obj[i].title + "</a></th><th>누적 조회수   ( " + obj[i].viewCount + " 회 )</th></tr>"); 
               index++;
              }
              $("#result > div").append("</table><br>");   
          },
         error: function(){
            alert("ERROR", arguments);
         }
      });
   };
</script>
<title>랭킹 페이지</title>
<style>
   th, td {
      text-align: center;
      height:70px;
      padding-left:43px;
      padding-right:43px;
   }
</style>
</head>
<body>    
<table id="main-menu">
  <tr>
    <td><a href='<c:url value="/shop/index.do"/>'>
        <b><font color="black" size="2">
          &lt;&lt; Go to Index</font></b></a>
    </td>
  </tr>
</table> 
   <form name = "pform" action="" style="position:absolute; left:53%; margin:0 0 0 -420px;">
      <div class="container" >
         <div class="row"  style="display:inline">
            <div style="display:inline;float:left;">
               <div style="font-size:15px">
                  <h3>조회수 랭킹</h3>
            
            <table>
            <tr><td><input type="button" id="button1" onclick="getJson(3);" value="수공예 판매" /></td>
            <td><input type="button" id="button2" onclick="getJson(2);" value="중고거래" /></td>
            <td><input type="button" id="button3" onclick="getJson(1);" value="경매" /></td>
            <td><input type="button" id="button4" onclick="getJson(0);" value="공동구매" /></td></tr><br>
            </table><br>
            <div id="result"></div>
         </div>
         </div>
         </div>
         </div>
      </form>
   </body>
</html>