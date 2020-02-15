<%@page import="java.sql.Timestamp"%>
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
<title>Notice</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

</head>
<%	
	String id = (String)session.getAttribute("id");

	// 세션값이 없으면 login.jsp로 이동
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}
		
	// content.jsp페이지에서 답글쓰기 버튼을 클릭해서 요청받아 넘어온 num, pageNum 한글처리
	request.setCharacterEncoding("UTF-8");

	// content.jsp페이지에서 답글쓰기 버튼을 클릭해서 요청받아 넘어온 데이터 전달받기
	int num =  Integer.parseInt(request.getParameter("num")); // 주글번호
	int re_ref =  Integer.parseInt(request.getParameter("re_ref")); // 주글그룹값
	int re_lev =  Integer.parseInt(request.getParameter("re_lev")); // 주글 들여쓰기 정도값
	int re_seq =  Integer.parseInt(request.getParameter("re_seq")); // 주글 순서
	
	
%>
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


		<!-- 게시판 -->
		<article id="board">
			<h1>Notice Update</h1>
			
			<%-- 주글에 대한 정보 --%>
			<form action="reWritePro.jsp" method="post">
			<input type="hidden" name="num" value="<%=num %>">
			<input type="hidden" name="re_ref" value="<%=re_ref %>">
			<input type="hidden" name="re_lev" value="<%=re_lev %>">
			<input type="hidden" name="re_seq" value="<%=re_seq %>">
			
			<%-- 답글에 대한 정보 --%>
			<table id="notice">
				<tr>
					<td>이름</td>
					<td><input type="text" name="name"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd"></td>
				</tr>
				<tr>
					<td>글제목</td>
					<td><input type="text" name="subject" value="[답글]"></td>
				</tr>
				<tr>
					<td>글내용</td>
					<td>
						<textarea name="content" rows="13" cols="40">
						</textarea>
					</td>
				</tr>
			</table>
			
		<div id="table_search">
			<input type="submit" value="답글작성" class="btn"> <!-- submit버튼은 form태그로 묶어줘야함 -->
			<input type="reset" value="다시작성" class="btn">
			<input type="button" value="글목록" class="btn" onclick="location.href='notice.jsp'">
		</div>
		</form>
		<div class="clear"></div>
		<div id="page_control"></div>
			
			
		</article>
		<!-- 게시판 -->
		
		
		
			
		<!-- 본문들어가는 곳 -->
		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		
		
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터들어가는 곳 -->
	</div>
</body>
</html>