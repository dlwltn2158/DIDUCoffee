<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// session값 얻기
	String id = (String)session.getAttribute("id");

	// session값이 저장되어 있지 않다면 login.jsp로 이동
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}

	// 1. 문자셋 방식 지정 (한글처리)
	request.setCharacterEncoding("UTF-8");
	
	/* // 1-1. write.jsp페이지 (글작성 페이지)에서 입력한 요청값을 request메모리에서 꺼내오기
	String name = request.getParameter("name");
	String passwd = request.getParameter("passwd");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	
	// 1-2. 얻는 요청값들을 BoardBean객체의 각변수에 저장
	BoardBean bBean = new BoardBean();
	
	bBean.setName(name);
	bBean.setPasswd(passwd);
	bBean.setSubject(subject);
	bBean.setContent(content); */
	
	// 1-1 + 1-2. 요청값을 request영역에서 얻어 BoardBean객체의 각변수에 저장
	// BoardBean b = new BoardBean();

//	액션 태그란? jsp페이지 내에서 자바코드와 html디자인이 섞여있으므로 복잡하다
//			   자바코드 대신 JSP문법중에서 액션태그를 사용하면 디자인 소스 화면을 구분하기 쉽다.

// useBean액션태그 -> 객체 생성 용도
// <jsp:useBean id="" class="생성할 객체에 대한 클래스 경로(패키지명 포함)" />

// setProperty액션태그 -> setter메소드 호출하여 변수에 값 초기화
// <jsp:setProperty property="속성명(* : 모든변수)" name="참조변수명"/>

%>	
	<jsp:useBean id="bBean" class="board.BoardBean" />
	<%-- request객체에서 꺼내온 모든값을 BoardBean객체의 모든 setter메소드 호출하여 모든 변수에 저장 --%>
	<jsp:setProperty property="*" name="bBean"/>
	<%-- <jsp:setProperty property="num" name="bBean" value="1"/> 1을 setNum변수를 호출하여 num변수에 저장
	<jsp:setProperty property="num" name="bBean" value="1"/>
	<jsp:setProperty property="name" name="bBean" value="홍길동"/>--%>
	
	<%-- 
		setProperty액션태그를 사용하여
		request에서 꺼내온 값을 한꺼번에 BoardBean에 저장하기위한 조건
		-> BoardBean클래스의 각변수이름과 write.jsp페이지의 각 <input>태그의 name속성값이 동일 해야함
	 --%>
	 
<%	
	// 1-2-1. 현재 글쓴 날짜, 시간정보를 추가로 BoardBean에 저장
	bBean.setDate(new Timestamp(System.currentTimeMillis())); // 현재시간을 long타입으로 반환
	
	// 1-2-2. 글쓴사람의 ip주소를 추가로 BoardBean에 저장
	bBean.setIp(request.getRemoteAddr());
	
	// 2. jspbeginner데이터베이스의 board테이블에 우리가 입력한 새글 정보를 INSERT
	BoardDAO bdao = new BoardDAO(); // DB작업
	
	// DB의 board테이블에 새글 정보를 INSERT하기 위해 insertBoard(BoardBean bean)메소드 호출시
	// 매개변수 인자로 BoardBean객체 전달
	bdao.insertBoard(bBean);

	// notice.jsp를 재요청(포워딩)해 이동
	response.sendRedirect("notice.jsp"); // 웹브라우저 거쳐서
	
	
%>



