<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div id="map" style="width:500px;height:400px;"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	16f579279a1287e67ce21e5500798017&libraries=services,clusterer,drawing"></script>
<script>
		var x1 = 127.0428;
		var y1 = 37.6065;
		
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng(y1, x1), //지도의 중심좌표. 동덕여자대학교 디폴트 판매자의 위치 
			level: 3 //지도의 레벨(확대, 축소 정도)
		};

		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		// univMapList 받아옴 
		var univMapList = "${univMapList}";

		//for (var i = 0; i < univMapList.length; i ++) {

		   
			// 로그인 유저의 대학교 도로명 주소-> main pin, 다른 게시물의 대학교 위치 pin clustring 
			// 주소로 좌표를 검색합니다
			
			var Addr = "${university}"; 
			geocoder.addressSearch(Addr, function(result, status) {

				// 마커 이미지의 이미지 주소입니다
				var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 

				// 마커 이미지의 이미지 크기 입니다
			    var imageSize = new kakao.maps.Size(24, 35); 

			 	// 마커 이미지를 생성합니다    
			    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 

			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {
			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			        });

			        // 인포윈도우로 장소에 대한 설명을 표시합니다
			        var infowindow = new kakao.maps.InfoWindow({
			            content: '<div style="width:150px;text-align:center;padding:6px 0;">나의 대학교 위치</div>'
			        });
			        infowindow.open(map, marker);

			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map.setCenter(coords);
			    } 
				    
			});     
		//} 
		
</script>
