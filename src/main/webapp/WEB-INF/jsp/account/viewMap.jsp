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
			
			if(data.length>0){
			    // 주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();

				geocoder.addressSearch("${university}", function(result, status) {
				    // 정상적으로 검색이 완료됐으면 
				     if (status === kakao.maps.services.Status.OK) {
				     	// 1. 지도 생성 
						var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
						var options = { //지도를 생성할 때 필요한 기본 옵션
								center: new kakao.maps.LatLng(result[0].y, result[0].x), //지도의 중심좌표. 동덕여자대학교 디폴트 판매자의 위치 
								level: 7 //지도의 레벨(확대, 축소 정도)
						};
						map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
				    } 
				});     

			// 2. 대학교별 마커 찍어주기
		        for(var i in data){
			        var $univName = data[i].univName;
			        var $univAddr = data[i].univAddr; 
			        var $region = data[i].region;
			        var $countPerUniv = data[i].countPerUniv;
			          
			        console.log($univName);
			        console.log($univAddr);
			        console.log($region);
			        console.log($countPerUniv);
	
					// 하나의 대학에대해 먼저 지도에 마커 보여주기
			        geocoder.addressSearch($univAddr, function(result, status) {
						// 마커 이미지의 이미지 주소
						var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
					    var imageSize = new kakao.maps.Size(24, 35);
					    
					 	// 마커 이미지를 생성  
					    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
	  
					    // 정상적으로 검색이 완료됐으면 
					     if (status === kakao.maps.services.Status.OK) {
					        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

					        // 결과값으로 받은 위치를 마커로 표시합니다
					        var marker = new kakao.maps.Marker({
					            map: map,
					            position: coords,
					            image : markerImage // 마커 이미지 
					        });

					       // 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
					       // 이거 대학교 이름 클릭하면 컨트롤러로 연결해서 그 해당 대학교만 의 판매 게시글 보여줌 
					       /*  var content = '<div class="customoverlay">' +
					            '  <a href="https://map.kakao.com/link/map/11394059" target="_blank">' +
					             $univName + '</a>' + '</div>'; */
							var content = '<div class ="label"><span class="left"></span><span class="center">'
								+ $univName + '</span><span class="right"></span></div>';

					        // 커스텀 오버레이를 생성합니다
					        var customOverlay = new kakao.maps.CustomOverlay({
					            map: map,
					            position: coords,
					            content: content,
					        });
					    } 
					});     
		          }        
	      	}
	      },
	     error: function(){
	        alert("ERROR", arguments);
	     }
	});
	
</script>
