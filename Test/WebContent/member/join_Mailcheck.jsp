<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메일 인증</title>
	<link href="../css/style.css" rel="stylesheet" type="text/css">
	<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script type="text/javascript">


function send_mail() {
	var email = document.getElementById("mail").value;
	var address =  "../mail/test_mail.jsp?email="+email;
	window.open(address,"","width=370, height=360, resizable=no, status=no");
}

</script>
</head>
<body>
<%
	String mail = request.getParameter("mail"); 
	
	if(mail==null){ 
		mail="";		
	}else{
%>
	<script type="text/javascript">
		alert("이메일 인증 완료!");
	</script>
<%
	}
%>
<div id="table_search" class="joinmail">
<h1>JOIN</h1>
<label>E-Mail</label> <input type="email" name="email" id="mail" value="<%=mail %>">
<input type="button" class="btn" value="이메일인증" onclick="send_mail()"><br>
<br><input type="button" class="btn" value="닫기" onclick="history.back();" >
</div>
</body>
</html>