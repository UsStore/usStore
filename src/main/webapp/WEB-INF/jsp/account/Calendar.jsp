<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../product/itemTop.jsp" %>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src='https://fullcalendar.io/releases/fullcalendar/3.9.0/lib/moment.min.js'></script>
<link href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.css'rel='stylesheet'/>
<link href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.print.css' rel='stylesheet' media='print'/>
<script src='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.js'></script>

<script type="text/javascript">
$(document).ready(function(){
	  $('#calendar').fullCalendar({
	    header: {
	      right: 'custom2 prevYear,prev,next,nextYear'
	    },
        // 출석체크를 위한 버튼 생성
	    customButtons: { 
	        custom2: {
	          text: '출석체크하기',
	          id: 'check',
	          click: function() {	
                    // ajax 통신으로 출석 정보 저장하기 
                    // POST "/users/attendances" -> { status: "success", date:"2018-07-01"}
                    // 통신 성공시 버튼 바꾸고, property disabled 만들기 
                    $.ajax({
	                    url: "/usStore/rest/shop/checkAttend.do",
						type: "POST",
					//	data : {userId: userSession.account.userId},
						dataType: "text",
						success: function (date) {
							$(".fc-custom2-button").prop('disabled', true);
							$(".fc-custom2-button").html('출석완료');
						}
					})
				}
	        }
	    },
       // 달력 정보 가져오기 
	    eventSources: [
	    	$.ajax({
				// ajax 통신으로 달력 정보 가져오기 
                // GET "/users/attendances" -> {dateList:[ date: "2016-03-21", ... ]}
                
                	url: '/usStore/rest/shop/checkAttend.do',
                	type: 'GET',
        	       	dataType: "TEXT",
                	success: function (data) { },
                	error:function(request,status,error){   
                    	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); }

                	})
		//		color: 'purple',   
		//	 	textColor: 'white' 
	    ]
	  }); 
});
</script>
<html>
<head>
<meta charset="UTF-8">
<title>출석체크 달력</title>
</head>
<body>
	<div class="container calendar-container">
		<div id="calendar" style="max-width:900px; margin:40px auto;"></div>
	</div>
</body>
</html>