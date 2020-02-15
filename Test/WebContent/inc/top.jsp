<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<link href="css/style.css" rel="stylesheet" type="text/css">
<header>

	<%
			// 각 상단 메뉴에서 공통적으로 사용된 소스
			// 세션 영역에 저장된 값 얻기
			String id = (String)session.getAttribute("id");
			
			if(id == null){ // 세션값이 존재하지않을때
%>				
			<div id="login">
				<a href="../member/login.jsp">login</a> |
				<a href="../member/join_Mailcheck.jsp">join</a>
			</div>
<%				
			}else{ // 세션값이 존재할때
				if(id.equals("admin")){
%>				
			<div id="login">
				<%=id %>님 <a href="../mail/mail.jsp">mail</a> |
				<a href="../member/logout.jsp">logout</a>						
			</div>
<%
				}else{
%>			
			<div id="login">
				<%=id %>님 <a href="../member/modify.jsp">modify</a> |
				<a href="../member/logout.jsp">logout</a>						
			</div>
<%				
			}
		}
	
	%>

</header>
<div class="clear"></div>