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
	// int num   String pageNum
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	// DB객체 생성
	BoardDAO boardDao = new BoardDAO();
	// 조회수 1 증가  updateReadcount()
	boardDao.revupdateReadCount(num);
	// BoardBean bean = getBoard(num) 메소드호출
	BoardBean bean = boardDao.revgetBoard(num);
	// 내용 엔터 \r\n -> <br> 바꾸기
	String content = "";
	if (bean.getContent() != null) {
		content = bean.getContent().replace("\r\n", "<br>");
	}
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
					<a href="review.jsp">Review</a>
				</li>
			</ul>
		</div>
	</div>
<!-- 게시판 -->
<article id="board">
<h1>Review</h1>
<table id="notice">
<tr>
	<td>글번호</td><td><%=bean.getNum() %></td>
	<td>조회수</td><td><%=bean.getReadcount() %></td>
</tr>
<tr>
	<td>작성자</td><td><%=bean.getName() %></td>
	<td>작성일</td><td><%=bean.getDate() %></td>
</tr>
<tr>
	<td>글제목</td><td colspan="3"><%=bean.getSubject() %></td>
</tr>
<tr>
	<td>다운로드</td>
	<td colspan="3">
		<% System.out.println(bean.getFile()); %>
		<a href="download.jsp?path=upload&name=<%=bean.getFile() %>"><%=bean.getFile() %></a>
		<img src="../upload/<%=bean.getFile() %>" width="100px" height="100px">
	</td>
</tr>
<tr>
	<td>글내용</td><td colspan="3"><%=content %></td>
</tr>
</table>
<div id="table_search">
<%
	// 세션값 가져오기
	String id = (String) session.getAttribute("id");
	// 세션값 있으면 수정,삭제,답글쓰기 버튼 보이게 설정
	if (id != null) {
		%>
		<input type="button" value="글수정" class="btn" 
		onclick="location.href='revupdate.jsp?num=<%=bean.getNum() %>&pageNum=<%=pageNum %>'">
		<input type="button" value="글삭제" class="btn"
		onclick="location.href='revdelete.jsp?num=<%=bean.getNum() %>&pageNum=<%=pageNum %>'">
		<input type="button" value="답글쓰기" class="btn"
		onclick="location.href='revreWrite.jsp?re_ref=<%=bean.getRe_ref() %>&re_lev=<%=bean.getRe_lev() %>&re_seq=<%=bean.getRe_seq() %>&pageNum=<%=pageNum %>'">
		<%
	}
%>
<input type="button" value="목록보기" class="btn" onclick="location.href='review.jsp?pageNum=<%=pageNum %>'">
</div>

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