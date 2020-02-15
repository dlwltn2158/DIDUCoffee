<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

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
					<a class="active" href="../index.jsp">Home</a>
				</li>
				<li>
					<a href="../menu/about.jsp">About</a>
				</li>
				<li>
					<a href="../menu/coffee.jsp">Menu</a>
				</li>
				<li>
					<a href="notice.jsp">Notice</a>
				</li>
				<li>
					<a href="review.jsp">Review</a>
				</li>
			</ul>
		</div>
	</div>
		<!-- 본문들어가는 곳 -->
<%
	// session영역에 저장되어 있는 값 얻기
	// 얻는 이유 : 글쓰기 화면에 글작성자의 이름을  id로 출력하기위해
	String id = (String)session.getAttribute("id");
	// session영역에 값이 저장되어 있지 않으면
	if(id == null){ // 로그인 페이지로
		response.sendRedirect("../member/login.jsp");
	}

%>

		<!-- 게시판 -->
		<article id="board">
			<h1>Notice Write</h1>
			<form action="writePro.jsp" method="post">
			<table id="notice">
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%=id %>" readonly></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd"></td>
				</tr>
				<tr>
					<td>글제목</td>
					<td><input type="text" name="subject"></td>
				</tr>
				<tr>
				<td>글내용</td>
					<td><textarea rows="13" cols="40" name="content"></textarea></td>
				</tr> 
				
	
				
			</table>

			<div id="table_search">
				<input type="submit" value="글쓰기" class="btn"> 
				<input type="reset" value="다시작성" class="btn">
				<input type="button" value="글목록" class="btn" onclick="location.href='notice.jsp'">
			</div>
			</form>
			<div class="clear"></div>
			
		</article>
		<!-- 게시판 -->
		<!-- 본문들어가는 곳 -->
		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터들어가는 곳 -->
</body>
</html>