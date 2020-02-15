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
	// DB작업 객체생성   패키지 board  클래스명 BoardDao
	BoardDAO boardDao = new BoardDAO();
	// 전체글개수
	int count = boardDao.revgetBoardCount();
	// 한화면당 보여줄 글개수  15
	int pageSize = 5;
	// 현제 페이지번호 가져오기. 없으면 1페이지.
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	
	// 시작행번호 구하기
	int startRow = (currentPage-1) * pageSize;
	
	List<BoardBean> list = null;
	// list = 메소드호출  getBoards(시작행인덱스번호, 글개수)
	if (count > 0) {
		list = boardDao.revgetBoardList(startRow, pageSize);
	}
	// 날짜 포맷
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
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
					<a href="../index.jsp">Home</a>
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
					<a class="active" href="review.jsp">Review</a>
				</li>
			</ul>
		</div>
	</div>

<!-- 게시판 -->
<article id="board">
<h1>Review</h1>
[전체글개수: <%=count %>]	
<div id="list_gallery">
<input type="button" value="List" class="btn" onclick="location.href='review.jsp'">
<input type="button" value="gallery" class="btn" onclick="location.href='gallery.jsp'">
</div>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">Read</th></tr>
<%
	if (count > 0) {
		for (int i=0; i<list.size(); i++) {
			BoardBean bean = list.get(i);
			%>
			<tr onclick="location.href='revcontent.jsp?num=<%=bean.getNum() %>&pageNum=<%=pageNum %>'">
				<td><%=bean.getNum() %></td>
				<td class="left">
					<%
						int wid = 0;
						if (bean.getRe_lev() > 0) {
							wid = bean.getRe_lev() * 10;
							%>
							<img src="../images/level.gif" width="<%=wid %>" height="15">
							<img src="../images/re.gif">
							<%
						}
					%>
					<%=bean.getSubject() %>
				</td>
				<td><%=bean.getName() %></td>
				<td><%=sdf.format(bean.getDate()) %></td>
				<td><%=bean.getReadcount() %></td>
			</tr>
			<%
		}
	} else {
		%>
		<tr><td colspan="5">게시판 글 없음</td></tr>
		<%
	}
%>

</table>
<%
	// 세션 가져오기
	String id = (String) session.getAttribute("id");
	// 세션값이 있으면 글쓰기 버튼이 보이게 설정
	if (id != null) {
		%>
		<div id="table_search">
		<input type="button" value="글쓰기" class="btn" onclick="location.href='revwrite.jsp'">
		</div>
		<%
	}
%>
<div id="table_search">
<form action="reviewSearch.jsp">
<input type="text" name="search" class="input_box">
<input type="submit" value="검색" class="btn">
</form>
</div>
<div class="clear"></div>
<div id="page_control">
<%

	if (count > 0) {
		// 전체 페이지수 구하기
		int pageCount = count / pageSize + (count%pageSize==0 ? 0 : 1);
		// 한화면에 보여줄 페이지수 설정
		int pageBlock = 10;
		// 시작 페이지번호 구하기
		int startPage = ((currentPage/pageBlock) - (currentPage%pageBlock==0 ? 1 : 0)) * pageBlock + 1;
		// 끝 페이지번호 구하기
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}
		
		if (startPage > pageBlock) {
			%>
			<a href="review.jsp?pageNum=<%=startPage - pageBlock %>">Prev</a>
			<%
		}
		
		for (int i=startPage; i<=endPage; i++) {
			%>
			<a href="review.jsp?pageNum=<%=i %>"><%=i %></a>
			<%
		}
		
		if (endPage < pageCount) {
			%>
			<a href="review.jsp?pageNum=<%=startPage + pageBlock %>">Next</a>
			<%
		}
	}
%>
</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터들어가는 곳 -->
</body>
</html>