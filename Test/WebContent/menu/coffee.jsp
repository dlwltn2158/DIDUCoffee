	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- Website template by freewebsitetemplates.com -->
<head>
	<title>DIDU Coffee Menu</title>
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
					<h1>Coffee</h1>
					<ul>
						<li>
							<h2><a href="coffee.jsp">Americano</a></h2>
							<p>
								풍미가 진한 에스프레소에 물을 넣어 연하게 마시는 커피입니다.
							</p>
							<span class="price">2,0</span>
						</li>
						<li>
							<h2><a href="coffee.jsp">Cafe Latte</a></h2>
							<p>
								풍미가 진한 에스프레소와 고소한 우유가 조화를 이룬 부드러운 커피입니다.
							</p>
							<span class="price">3,0</span>
						</li>
						<li>
							<h2><a href="coffee.jsp">Cappuccino</a></h2>
							<p>
								풍미가 진한 에스프레소에 고소한 우유와 우유거품이 어우러진 부드러우면서도 진한 커피입니다.
							</p>
							<span class="price">3,5</span>
						</li>
						<li class="last	">
							<h2><a href="coffee.jsp">Caramel Macchiato</a></h2>
							<p>
								달콤한 카라멜과 우유 거품의 부드러운 맛이 에스프레소와 어우러진 커피입니다.
							</p>
							<span class="price">4,0</span>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="sidebar">
			<h1>Menu</h1>
			<ul class="navigation">
				<li class="first">
					<a class="active" href="coffee.jsp">COFFEE</a>
				</li>
				<li>
					<a href="noncoffee.jsp">NON-COFFEE</a>
				</li>
				<li>
					<a href="dessert.jsp">DESSERT</a>
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