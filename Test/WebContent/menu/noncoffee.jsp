<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- Website template by freewebsitetemplates.com -->
<head>
	<title>DIDU Non-Coffee Menu</title>
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
					<h1>Non-Coffee</h1>
					<ul>
						<li>
							<h2><a href="noncoffee.jsp">Tea</a></h2>
							<p>
								로얄 캐모마일, 루이보스 빌베리, 쿨민트, 얼그레이, 피치우롱
							</p>
							<span class="price">3,0</span>
						</li>
						<li>
							<h2><a href="noncoffee.jsp">Smoothie</a></h2>
							<p>
								딸기, 블루베리, 망고, 그린티, 초코칩, 쿠앤크
							</p>
							<span class="price">5,0</span>
						</li>
						<li>
							<h2><a href="noncoffee.jsp">Latte</a></h2>
							<p>
								딸기, 초코, 고구마
							</p>
							<span class="price">4,0</span>
						</li>
						<li class="last	">
							<h2><a href="noncoffee.jsp">Ade</a></h2>
							<p>
								레몬, 오렌지, 딸기, 자몽
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
					<a href="coffee.jsp">COFFEE</a>
				</li>
				<li>
					<a class="active" href="noncoffee.jsp">NON-COFFEE</a>
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