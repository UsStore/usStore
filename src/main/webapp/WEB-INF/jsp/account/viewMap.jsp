<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>

<div id="map" style="width:500px;height:400px;"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	16f579279a1287e67ce21e5500798017&libraries=services,clusterer,drawing"></script>
<script>
 
	$.ajax({
		type:"get",
		url: "/usStore/rest/api/secondHand/map.do",
		contentType: "application/json",
		success: function(data){
			var map;
			var geocoder = new kakao.maps.services.Geocoder();

			if(data.length>0){ // 첫if문 시작 
				 if("${university}" != ""){ // 로그인 했을 때 
					 // 주소-좌표 변환 객체를 생성합니다
						geocoder.addressSearch("${university}", function(result, status) {
						// 정상적으로 검색이 완료됐으면 
						if (status === kakao.maps.services.Status.OK) {
					            // 1. 지도 생성 
					    		console.log(result[0].y);
					    		console.log(result[0].x);
								var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
								var options = { //지도를 생성할 때 필요한 기본 옵션
										center: new kakao.maps.LatLng(result[0].y, result[0].x), //지도의 중심좌표. 로그인 사용자의 위치 
										level: 7 //지도의 레벨(확대, 축소 정도)
								};
								map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
						    } 
						});     
				 }else{ //로그인 안했을 때 
					 var mapContainer = document.getElementById('map');
					 var mapOption = { 
					        center: new kakao.maps.LatLng(37, 127), // 지도의 중심좌표
					        level: 10// 지도의 확대 레벨
					 };
		     		 map = new kakao.maps.Map(mapContainer, mapOption);  
				 } 
				 
			// 2. 대학교별 마커 찍어주기     
			        data.forEach(function(univ) {

							console.log(univ.univName);
							console.log(univ.univAddr);
							console.log(univ.region);
							console.log(univ.countPerUniv);
				        
					        geocoder.addressSearch(univ.univAddr, function(result, status) {
								// 마커 이미지의 이미지 주소
								var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
							    var imageSize = new kakao.maps.Size(24, 35);
							    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);// 마커 이미지를 생성  
							    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
							    var marker = new kakao.maps.Marker({  // 결과값으로 받은 위치를 마커로 표시합니다
							            map: map,
							            position: coords,
							            image : markerImage // 마커 이미지 
							    });
		
								 // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
							     var iwContent = '<div style="padding:5px;">'
								        			+ '<a href="/usStore/shop/secondHand/listItem.do?productId=2&filterUniv='+univ.univName+'">'+univ.univName+'</a>'
								        			+ '</div>';
		
							     // 인포윈도우를 생성하고 지도에 표시합니다
							      var infowindow = new kakao.maps.InfoWindow({
								        map: map, 
								        position : coords, 
								        content : iwContent
							     });    
			        		}); // geocoder 끝 	
		          });  // data.forEach 끝 
	      	} // 첫if문 끝 
	      },
	     error: function(){
	        alert("ERROR", arguments);
	     }
	});
</script>
