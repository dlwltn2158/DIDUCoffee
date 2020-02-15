<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	// 한글처리
	request.setCharacterEncoding("UTF-8");

	// pageNum얻기
	String pageNum = request.getParameter("pageNum");
	
	// update.jsp페이지에서 요청한 수정할 글정보를 reauest영역에서 꺼내오기
	// BoardBean객체를 생성하여 요청한 수정할 글정보들을 각변수에 저장
%>	
	<jsp:useBean id="bBean" class="board.BoardBean"/>
	<jsp:setProperty property="*" name="bBean"/>
	
	<%-- UPDATE작업을 위한 BoardDAO객체 생성 --%>
	<jsp:useBean id="bdao" class="board.BoardDAO"/>
<%
	// UPDATE작업을 위해 메소드 호출시 BoardBean을 전달하여 UPDATE작업함
	int check = bdao.updateBoard(bBean);
	if(check == 1){ // 수정성공 -> notice.jsp로 이동
%> 
	<script type="text/javascript">
		window.alert("수정성공!");
		location.href="notice.jsp?pageNum=<%=pageNum %>";
	</script>
<%				
	}else{ // 수정실패 비밀번호틀림 -> 이전 페이지update.jsp로 되돌아 가게 하기
%>
	<script type="text/javascript">
		alert("비밀번호 틀림");
		history.back();
	</script>
<%		
	}
%>




%>