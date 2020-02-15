<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

</head>
<%
	// 세션값 가져오기
	String id = (String) session.getAttribute("id");
	// 세션값 없으면 login.jsp 이동
	if (id == null) {
		response.sendRedirect("../member/login.jsp");
	}
	
	// int num   String pageNum
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
%>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->
		<!-- 본문들어가는 곳 -->
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

<!-- 게시판 -->
<article>
<h1>Review Delete</h1>
<form action="revdeletePro.jsp?pageNum=<%=pageNum %>" method="post" name="fr">
<input type="hidden" name="num" value="<%=num %>">
<table id="notice">
<tr><td>비밀번호</td><td><input type="password" name="passwd"></td></tr>
</table>
<div id="table_search">
<input type="submit" value="글삭제" class="btn">
<input type="reset" value="다시작성" class="btn">
<input type="button" value="목록보기" class="btn" onclick="location.href='review.jsp?pageNum=<%=pageNum%>'">
</div>
</form>
<div class="clear"></div>
<div id="page_control"></div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<%@include file="../inc/bottom.jsp" %>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>