<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 세션값 가져오기
	String id = (String) session.getAttribute("id"); 	
	// 세션값 없으면 login.jsp 이동
	if (id == null) {
		response.sendRedirect("../member/login.jsp");
	}
	
	// 업로드
	// 1 request
	// 2 upload 폴더 (물리적 경로)
	String realPath = application.getRealPath("/upload");
	System.out.println(realPath);
	// 3 파일업로드 최대크기
	int maxSize = 1024 * 1024 * 5;  // 5MB
	// 4  파일명 한글처리  "utf-8"
	// 5  파일이름이 동일한경우 => 파일이름 변경
	MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
	
	BoardBean bean = new BoardBean();
	// 폼정보 => 자바빈 저장
	bean.setContent(multi.getParameter("content"));
	bean.setName(multi.getParameter("name"));
	bean.setPasswd(multi.getParameter("passwd"));
	bean.setSubject(multi.getParameter("subject"));
	
	bean.setFile(multi.getFilesystemName("file"));
	
	// set  날짜   ip 값 저장
	bean.setDate(new Timestamp(System.currentTimeMillis()));
	bean.setIp(request.getRemoteAddr());
	
	// DB객체 생성
	BoardDAO boardDao  = new BoardDAO();
	// 메소드호출  insertBoard(bean)
	boardDao.revinsertBoard(bean);
	// 이동  fnotice.jsp
	response.sendRedirect("review.jsp");
%>






