<%@page import="web.mail.MailSend"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메일 인증</title>
	<link href="../css/style.css" rel="stylesheet" type="text/css">
	<link href="../css/subpage.css" rel="stylesheet" type="text/css">

</head>
<body>
<div id="table_search" class="joinmail">

<%
String from = request.getParameter("email");
MailSend ms = new MailSend();
ms.mailSend(from); 
 
out.println("메일이 발송되었습니다");
%>

<form>
<br><input type="button" class="btn" value="네이버로 이동" onclick="location.href='https://www.naver.com'"/>
<br><br><input type="button" class="btn" value="닫기" onclick="window.close()" />
</form>
</div>
</body>


</html>

