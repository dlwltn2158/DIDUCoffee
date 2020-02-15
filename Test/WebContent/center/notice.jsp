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
					<a class="active" href="notice.jsp">Notice</a>
				</li>
				<li>
					<a href="review.jsp">Review</a>
				</li>
			</ul>
		</div>
	</div>


		<!-- 게시판 -->
		<%
			// 게시판에 새글을 추가했다면 notice.jsp페이지에
			// DB에 저장된 새글 정보를 검색하여 가져와서 글리스트 목록을 아래에 출력해주어야함.
			BoardDAO boardDAO = new BoardDAO();
			
			// 게시판(board테이블)에 저장되어있는 전체 글개수 검색해서 얻기
			int count = boardDAO.getBoardCount(); 
		
			// 한페이지에 보여줄 글 개수 5개로 지정
			int pageSize = 5;
			
			// notice.jsp화면의 아래쪽 페이지번호를 클릭시 클릭한 페이지 번호 받아오기
			String pageNum = request.getParameter("pageNum");
			
			// notice.jsp화면 요청시 아래쪽의 페이지번호를 클릭하지않은 상태이다.
			// 이럴때는 현재 클릭한 페이지 번호가 없으면 g현재보여지는 페이지를 1페이지로 지정
			if(pageNum==null){
				pageNum="1";
			}
			
			// 위의 pageNum변수값을 정수로 변환해서 저장
			int currentPage = Integer.parseInt(pageNum);
			
			// --------------------------------------------------------------------
			
			// 각페이지마다 첫번째로 보여질 시작 글번호 구하기
			// (현재보여지는 페이지번호 -1) * 한페이지당 보여줄 글개수 5
			int startRow = (currentPage -1) * pageSize;
			
			// board테이블에서 검색한 글의 정보를 저장할 용도의 List인터페이스 타입의 변수 list선언
			List<BoardBean> list = null;
			
			// 만약에 board테이블에 글이 존재한다면
			if(count > 0){
				// board테이블에 모든 글 검색
				// (각페이지 마다 맨위에 첫번째로 보여질 시작 글번호, 한페이지당 보여줄 글개수)
				list = boardDAO.getBoardList(startRow,pageSize);
				
			}
			
			
		%>
		<article id="board">
			<h1>Notice</h1>
			[전체 글개수 : <%=count %>]
			<table id="notice">
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Writer</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>
		<%
					if(count > 0){ // 게시판에 글이 존재하면
						
						for(int i = 0; i<list.size(); i++){ // ArrayList사이즈만큼 반복 (BoardBean객체 개수 만큼)
							// ArrayList배열의 각 인데스 위치에 저장된 BoardBean객체 얻기
							BoardBean bean = list.get(i);
						// pageNum= 현재페이지의 번호
	%>
						<tr onclick="location.href='content.jsp?num=<%=bean.getNum() %>&pageNum=<%=pageNum %>'">
							<td><%=bean.getNum() %></td>
							<td class="left">
					<%
						int wid = 0;
						if (bean.getRe_lev() > 0) {
							wid = bean.getRe_lev() * 10;
							%>
							<img src="../images/mark.png" width="<%=wid %>" height="15">
							<%
						}
					%>
							<%=bean.getSubject() %></td>
							<td><%=bean.getName() %></td>
							<td><%=new SimpleDateFormat("yyyy/MM/dd").format(bean.getDate()) %></td>
							<td><%=bean.getReadcount() %></td>
						</tr>
	<%
						}
						
						
					}else{ // 게시판에 글이 존재하지않으면
			%>
						<tr>
							<td colspan="5">게시판 글 없음</td>
						</tr>
		<%
					}
				
				
				%>
			</table>
			
			<%
				String id = (String)session.getAttribute("id");
			if(id == null){
			%>
				
			<%
			}else if(id.equals("admin")){ //id.equals("admin")
%>
					<div id="table_search"> 
						<input type="button" value="글쓰기" class="btn" onclick="location.href='write.jsp'">
					</div>
				
<%
				} 
			
			%>
					<div id="table_search">
					<form action="noticeSearch.jsp">
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
			<a href="notice.jsp?pageNum=<%=startPage - pageBlock %>">Prev</a>
			<%
		}
		
		for (int i=startPage; i<=endPage; i++) {
			%>
			<a href="notice.jsp?pageNum=<%=i %>"><%=i %></a>
			<%
		}
		
		if (endPage < pageCount) {
			%>
			<a href="notice.jsp?pageNum=<%=startPage + pageBlock %>">Next</a>
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