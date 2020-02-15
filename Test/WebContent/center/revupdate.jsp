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
<title>Review</title>
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
	
	// DB객체 생성
	BoardDAO boardDao = new BoardDAO();
	BoardBean bean = boardDao.revgetBoard(num);
%>
<body>
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
					<a href="review.jsp">review</a>
				</li>
			</ul>
		</div>
	</div>

<!-- 게시판 -->
<article id="board">
<h1>Review</h1>
<form action="revupdatePro.jsp?pageNum=<%=pageNum %>" method="post" name="fr" enctype="multipart/form-data">
<input type="hidden" name="num" value="<%=num %>">
<table id="notice">
<tr><td>이름</td><td><input type="text" name="name" value="<%=bean.getName() %>"></td></tr>
<tr><td>비밀번호</td><td><input type="password" name="passwd"></td></tr>
<tr><td>제목</td><td><input type="text" name="subject" value="<%=bean.getSubject()%>"></td></tr>
<tr>
	<td>파일</td>
	<td>
		<input type="file" name="file">
		<%=bean.getFile() %>
		<input type="hidden" name="file2" value="<%=bean.getFile() %>">
	</td>
</tr>
<tr><td>내용</td><td><textarea name="content" rows="13" cols="40"><%=bean.getContent() %></textarea></td></tr>
</table>
<div id="table_search">
<input type="submit" value="글수정" class="btn">
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
</body>
</html>