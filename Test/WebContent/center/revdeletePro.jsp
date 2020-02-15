<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 세션값 가져오기
	String id = (String) session.getAttribute("id");
	// 세션값 없으면 login.jsp 이동
	if (id == null) {
		response.sendRedirect("../member/login.jsp");
	}
	
	// int num    String passwd    String pageNum
	int num = Integer.parseInt(request.getParameter("num"));
	String passwd = request.getParameter("passwd");
	String pageNum = request.getParameter("pageNum");
	
	// DB객체 생성 
	BoardDAO boardDao = new BoardDAO();
	// File API   파일삭제
	
	// int check = 메소드호출  revdeleteBoard(num, passwd)
	int check = boardDao.revdeleteBoard(num, passwd);
	// check==1  이면   삭제성공  fnotice.jsp?pageNum=
	// check==0  이면   "비밀번호틀림"  뒤로이동
	if (check == 1) {
		response.sendRedirect("review.jsp?pageNum=" + pageNum);
	} else {
		%>
		<script>
			alert('비밀번호틀림');
			history.back();
		</script>
		<%
	}
%>


