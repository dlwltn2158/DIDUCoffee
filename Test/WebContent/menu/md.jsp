<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- Website template by freewebsitetemplates.com -->
<head>
	<title>DIDU MD</title>
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
					<h1>MD</h1>
					<ul>
						<li>
							<h2><a href="md.jsp">Mug Cup</a></h2>
							<p>
								DIDU Coffee의 다양한 용품으로 언제 어디서나 DIDU Coffee와 함께 하세요.
							</p>
							<span class="price">10,0</span>
						</li>
						<li>
							<h2><a href="md.jsp">Tumbler</a></h2>
							<p>
								DIDU Coffee의 다양한 용품으로 언제 어디서나 DIDU Coffee와 함께 하세요.
							</p>
							<span class="price">20,0</span>
						</li>
						<li>
							<h2><a href="md.jsp">Diary</a></h2>
							<p>
								DIDU Coffee의 다양한 용품으로 언제 어디서나 DIDU Coffee와 함께 하세요.
							</p>
							<span class="price">15,0</span>
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
					<a href="dessert.jsp">DESSERT</a>
				</li>
				<li>
					<a class="active" href="md.jsp">MD</a>
				</li>
			</ul>
			</div>
	</div>
						<!-- 푸터들어가는 곳 -->
						<jsp:include page="../inc/bottom.jsp"/>
						<!-- 푸터들어가는 곳 -->

</body>
</html>