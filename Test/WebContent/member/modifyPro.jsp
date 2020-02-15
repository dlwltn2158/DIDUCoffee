<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 1. 회원가입을 위해 join.jsp에서 입력한 회원정보들은 request내장객체 영역에
	//	    저장 되어 있다.
	//	  request내장객체 영역에 저장된 데이터중 한글이 존재하면 한글 깨짐 방지를 위해
	//	    문자셋 방식을 UTF-8로 설정함
	request.setCharacterEncoding("UTF-8");

	// 2. join.jsp에서 입력한 새회원 정보(요청정보)를
	//	  requert내장객체 영역에서 꺼내어 얻기
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
 	/* String email = request.getParameter("email"); */ 
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String address3 = request.getParameter("address3");
	String tel = request.getParameter("tel");
	String mtel = request.getParameter("mtel");
	// 현재 회원 가입 하는 날짜 생성
	Timestamp time = new Timestamp(System.currentTimeMillis()); // 현재 날짜&시간 정보를 long타입으로 반환해줌

	// 3. join.jsp에서 입력한 DB에 추가할 정보를 MemberBean(VO역할)의 각 변수에 저장
	MemberBean memberbean = new MemberBean();
	// MemberBean의 setter메소드를 호출하여 각변수에 요청값을 저장
	memberbean.setId(id);
	memberbean.setPasswd(passwd);
	memberbean.setName(name);
 	/* memberbean.setEmail(email); */
	memberbean.setAddress1(address1);
	memberbean.setAddress2(address2);
	memberbean.setAddress3(address3);
	memberbean.setTel(tel);
	memberbean.setMtel(mtel);
	memberbean.setReg_date(time);
	
	// 4. 입력한 회원정보 즉! MemberBean의 정보를 DB에 update하기 위해
	// MemberDAO객체 생성
	MemberDAO memberdao = new MemberDAO();
	
	// MemberBean의 정보를 DB에 update하기 위해 updateMember(MemberBean bean)메소드 호출시
	// 메소드의 인자로 MemberBean객체를 전달 함.
	memberdao.updatemember(memberbean, id);
	
	//5. 회원 수정에 성공 했다면..login.jsp로 이동 하기 위해 포워딩(재요청)
	response.sendRedirect("../index.jsp");
	
	
	
	
	
	
	
	

%>
    
    
    