<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../product/itemTop.jsp" %>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src='https://fullcalendar.io/releases/fullcalendar/3.9.0/lib/moment.min.js'></script>
<link href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.css'rel='stylesheet'/>
<link href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.print.css' rel='stylesheet' media='print'/>
<script src='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.js'></script>

<script type="text/javascript">
$(document).ready(function() {
	fn_get_events();
});

function fn_set_calendar(events){
	$('#calendar').fullCalendar({
		events: events, 	
		eventColor: '#40BEA7',
		header: {
			 right: 'custom2 prevYear,prev,next,nextYear'
		},
		 customButtons: {
			 custom2: {
			      text: '출석체크하기',
			      click: function() {	
			        $.ajax({
			    		url: '/usStore/rest/shop/checkAttend.do', 
			    		type: "POST",
			    		dataType: "text",
			    		success: function(check) {
				    		if(check == 'y'){
				    			alert('이미 출석 했습니다!');
				    		}
				    		else {
				    			alert('출석 완료!');
				    			location.reload();
					    		}
				    		$(".fc-custom2-button").prop('disabled', true);
							$(".fc-custom2-button").html('출석완료');
			    		}
			    	});
			      }
			    }
			  }
	});
//	fn_get_events();
}
	
function fn_get_events()
{
	$.ajax({
		url: '/usStore/rest/shop/checkAttend.do', 
		dataType: 'json', 
		success: function(data) {
			fn_set_calendar(data);
		}
	}); 
}
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