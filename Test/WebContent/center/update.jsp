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
	/*글수정을 위한 하나의 글정보를 검색해서 가져와서 화면에 출력하는 페이지*/
	
	String id = (String)session.getAttribute("id");

	// 세션값이 없으면 login.jsp로 이동
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}
		
	// content.jsp페이지에서 글수정버튼을 클릭해서 요청받아 넘어온 num,pageNum 한글처리
	request.setCharacterEncoding("UTF-8");

	// content.jsp페이지에서 글수정버튼을 클릭해서 요청받아 넘어온 num,pageNum 얻기
	int num =  Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	// 글수정을 위한 하나의 글정보 검색 DB작업을 위한 객체 생성
	BoardDAO dao = new BoardDAO();
	
	//DB로부터 하나의 글정보를 검색해서 얻기
	BoardBean boardBean = dao.getBoard(num);
	 
	//DB로 부터 하나의 글정보를 검색해서 가져온 BoardBean객체의 getter메소드를 호출 하여 리턴 받기
	int DBnum = boardBean.getNum();//검색한 글번호 
	int DBReadcount = boardBean.getReadcount();//검색한 글의 조회수 
	String DBName = boardBean.getName();//검색한 글을 작성한 사람의 이름 
	Timestamp DBDate = boardBean.getDate();//검색한 글을 작성한 날짜 및 시간 
	String DBSubject = boardBean.getSubject();//검색한 글의 글제목
	String DBContent = ""; //검색한 글내용을 저장할 용도의 변수
	
	//검색한 글의 내용이 있다면... 내용들 엔터키 처리 
	if(boardBean.getContent() != null){
		DBContent = boardBean.getContent().replace("<br>", "\r\n");
	}
		
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
			
			<form action="updatePro.jsp?pageNum=<%=pageNum %>" method="post">
			<input type="hidden" name="num" value="<%=num %>">
			<table id="notice">
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%=DBName %>"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd"></td>
				</tr>
				<tr>
					<td>글제목</td>
					<td><input type="text" name="subject" value="<%=DBSubject %>"></td>
				</tr>
				<tr>
					<td>글내용</td>
					<td>
						<textarea name="content" rows="13" cols="40">
						<%=DBContent %>
						</textarea>
					</td>
				</tr>
			</table>
			
		<div id="table_search">
			<input type="submit" value="글수정" class="btn"> <!-- submit버튼은 form태그로 묶어줘야함 -->
			<input type="reset" value="다시작성" class="btn">
			<input type="button" value="글목록" class="btn" onclick="location.href='notice.jsp?pageNum=<%=pageNum %>'">
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