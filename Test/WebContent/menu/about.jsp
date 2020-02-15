<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- Website template by freewebsitetemplates.com -->
<head>
	<title>DIDU Coffee</title>
	<meta charset="utf-8">
	<link href="../css/style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6741fbd85762e90645bae5f43520fb13"></script>		

</head>
<body>
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- 헤더들어가는 곳 -->
	<div id="header">
		<div>
			<a href="../index.jsp"><img class="logo" src="../images/didu.png" width="513" height="84" alt="" title=""></a>
			<ul class="navigation">
				<li>
					<a href="../index.jsp">Home</a>
				</li>
				<li>
					<a class="active" href="about.jsp">About</a>
				</li>
				<li>
					<a href="coffee.jsp">Menu</a>
				</li>
				<li>
					<a href="../center/notice.jsp">Notice</a>
				</li>
				<li>
					<a href="../center/review.jsp">Review</a>
				</li>
			</ul>
		</div>
	</div>
	<article>
		<div id="about">
					<h1>About</h1>
					<div class="sidebar">
			<h1>Open Everyday</h1>
				<span>from 10AM until 11PM</span>
			<h1>Address</h1>
				<span>부산 부산진구 동천로 109 <br><br> 삼한골든게이트 7층</span>
			<h1>Phone Number</h1>
				<span>123-456-7890</span>
			<h1>CEO</h1>
				<span>Lee Jisu</span>
			</div>
			</div>
					<ul>					
		
<!-- ////////////////////// 카카오 지도 API E ///////////////////  -->
		<div class="mapWrap"> 
			<div id="map" style="width:500px;height:400px;"></div> 
		</div> 
						
<script type="text/javascript">
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = { 
		    center: new kakao.maps.LatLng(35.158636, 129.062039), // 지도의 중심좌표
		    level: 3 // 지도의 확대 레벨
		};
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		//지도를 클릭한 위치에 표출할 마커입니다
		var marker = new kakao.maps.Marker({ 
		 // 지도 중심좌표에 마커를 생성합니다 
		 position: map.getCenter() 
		}); 
		//지도에 마커를 표시합니다
		marker.setMap(map);
		
		//////////////////// // 카카오 지도 API E /////////////////// 
		</script>
						
						</ul>
						
					</article>
	
						<!-- 푸터들어가는 곳 -->
						<jsp:include page="../inc/bottom.jsp"/>
						<!-- 푸터들어가는 곳 -->
</body>
</html>