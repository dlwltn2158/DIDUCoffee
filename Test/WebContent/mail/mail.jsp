<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
	<title>Mail - Coffee Menu</title>
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
					<a href="coffee.jsp">Menu</a>
				</li>
				<li>
					<a class="active" href="board.jsp">Notice</a>
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
					<h1>Send Mail</h1>
					<form action="sendMail.jsp" method="post">
						<label for="name"> <span class="text">From</span>
							<input type="text" name="from" id="name" value="dl_wltn2158@naver.com" readonly="readonly">
						</label>
						<label for="DIDU"> <span>Name</span>
							<input type="text" name="DIDU" id="DIDU" value="DIDU Coffee" readonly="readonly">
						</label>
						<label for="email"> <span>To</span>
							<input type="text" name="to" id="email">
						</label>
						<label for="subject"> <span>Subject</span>
							<input type="text" name="subject" id="subject">
						</label>
						<label for="message"> <span>Message</span>
							<textarea name="content" id="message" value="DIDU Coffee>"></textarea>
						</label>
						<input type="submit" value="">
					</form>
				</div>
			</div>
		</div>
		</div>
		
		
		
		
						<!-- 푸터들어가는 곳 -->
						<jsp:include page="../inc/bottom.jsp"/>
						<!-- 푸터들어가는 곳 -->

</body>
</html>