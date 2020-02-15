<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- Website template by freewebsitetemplates.com -->
<head>
	<title>DIDU Dessert Menu</title>
	<meta charset="utf-8">
	<link href="../css/style.css" rel="stylesheet" type="text/css">
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
					<a href="about.jsp">About</a>
				</li>
				<li>
					<a class="active" href="coffee.jsp">Menu</a>
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
	<div id="body">
		<div class="content">
			<div>
				<div>
					<h1>Dessert</h1>
					<ul>
						<li>
							<h2><a href="dessert.jsp">Cake</a></h2>
							<p>
								오늘 기분에 어울리는 달콤한 케이크가 여러분을 기다립니다.
							</p>
							<span class="price">5,0</span>
						</li>
						<li>
							<h2><a href="dessert.jsp">Bakery</a></h2>
							<p>
								오늘 기분에 어울리는 따뜻한 베이커리가 여러분을 기다립니다.
							</p>
							<span class="price">4,0</span>
						</li>
						<li>
							<h2><a href="dessert.jsp">Sandwich</a></h2>
							<p>
								화이트 식빵에 슬라이스 햄을 듬뿍 넣고 오이피클로 깔끔한 맛을 더한 햄치즈 샌드위치
							</p>
							<span class="price">5,0</span>
						</li>
						<li class="last	">
							<h2><a href="dessert.jsp">Cookie</a></h2>
							<p>
								초코칩이 들어있는 달콤한 쿠키
							</p>
							<span class="price">1,0</span>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="sidebar">
			<h1>Menu</h1>
			<ul class="navigation">
				<li class="first">
					<a href="coffee.jsp">COFFEE</a>
				</li>
				<li>
					<a href="noncoffee.jsp">NON-COFFEE</a>
				</li>
				<li>
					<a class="active" href="dessert.jsp">DESSERT</a>
				</li>
				<li>
					<a href="md.jsp">MD</a>
				</li>
			</ul>
			</div>
	</div>
						<!-- 푸터들어가는 곳 -->
						<jsp:include page="../inc/bottom.jsp"/>
						<!-- 푸터들어가는 곳 -->

</body>
</html>