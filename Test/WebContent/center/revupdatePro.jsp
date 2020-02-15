<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 파일업로드
	String realPath = application.getRealPath("/upload");
	int maxSize = 1024 * 1024 * 5; // 5MB
	
	MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
	
	// 자바빈 객체생성
	BoardBean bean = new BoardBean();
	// 업로드된 정보 자바빈 저장
	bean.setName(multi.getParameter("name"));
	bean.setPasswd(multi.getParameter("passwd"));
	bean.setNum(Integer.parseInt(multi.getParameter("num")));
	bean.setSubject(multi.getParameter("subject"));
	bean.setContent(multi.getParameter("content"));
	
	if (multi.getFilesystemName("file") != null) {
		// 새롭게 수정할 파일 있음
		bean.setFile(multi.getFilesystemName("file"));
	} else {
		// 기존 파일이름
		bean.setFile(multi.getParameter("file2"));
	}
	
	// DB객체 생성
	BoardDAO boardDao = new BoardDAO();
	// int check = 메소드호출  updateBoard(bean)
	int check = boardDao.revupdateBoard(bean);
	// check==1  수정성공  fnotice.jsp?pageNum=
	// check==0  "비밀번호틀림"  뒤로이동
	String pageNum = multi.getParameter("pageNum");
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




