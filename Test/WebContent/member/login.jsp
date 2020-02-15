<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	    <%-- JSTL라이브러리 중에 core라이브러리에 속한 태그 사용을 위한 선언 --%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
    <%-- <c:set>태그를 이용해 pageContext내장객체의
    	 request속성에 저장되어 있는 HttpServlet객체의 contextPath속성값을 얻어 변수에 저장--%>
    <c:set var="contextPath" value="${pageContext.request.contextPath}"  />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
					<a class="active" href="../menu/index.jsp">Home</a>
				</li>
				<li>
					<a href="../menu/about.jsp">About</a>
				</li>
				<li>
					<a href="../menu/coffee.jsp">Menu</a>
				</li>
				<li>
					<a href="../center/notice.jsp">Notice</a>
				</li>
				<li>
					<a href="../center/review.jsp">Review</a>
				</li>
			</ul>
		</div>
	</div>
		<!-- 본문내용 -->
		<article id="board">
			<h1>Login</h1>
			<form action="loginPro.jsp" id="join" method="post">
				<fieldset>
					<legend>Login Info</legend>
					<label>ID</label> <input type="text" name="id" placeholder="이메일형식으로 입력"><br>
					<label>Password</label> <input type="password" name="passwd"><br>
				</fieldset>
				<div class="clear"></div>
				<div id="buttons">
					<input type="submit" value="로그인" class="submit">
					<input type="reset" value="다시입력" class="cancel">
				</div>
			</form>
			<br><label>회원이 아니신가요?</label>
			<a href="${contextPath}/member/join_Mailcheck.jsp"> >> 회원등록하기 </a>
			
		</article>
		<!-- 본문내용 -->
		<!-- 본문들어가는 곳 -->
		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터들어가는 곳 -->

</body>
</html>