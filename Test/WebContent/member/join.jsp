<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 	<script type="text/javascript">
 
 	/* ID중복검사 */
			function fn_process(){	
				var id = $("#id").val();
				
				if(id == ''){
					alert("ID를 입력하세요.");
					return;
				} else {
				$.ajax({
					type:"post",
					async:false,
					url:"http://localhost:8090/Test/didu.do",
					data:{"id":id},
					dataType:"text", 
					success:function(data,textStatus){
						if(data=='usable'){
						$("#message").text(" √ 사용할수 있는 ID입니다.");
						//사용할수 있는 ID이면 버튼을 비활성화 시킴
						$("#btn_duplicate").prop("disabled",true);
					}else{
						$("#message").text(" √ 사용할수 없는 ID입니다.");
					}
					}
				});		
	 		}
		}
			

 		
 		 /* 비밀번호 유효성 검사 메서드*/
 	    function checkPwd(){
 	    	var pwd1 = $("#passwd").val();
 	    	var checkSpan = $("#passPwd1");
 	    	var reg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;
 	    	
 	     	if(!reg.test(pwd1)){
 	     		checkSpan.html("<font color='red'><b> √ 비밀번호는 숫자, 알파벳, 특수문자 조합으로 8자리 이상 입력해야 합니다.</b></font>");
 	     	}else{
 	     		checkSpan.html("<font color='green'><b> √ </b></font>");
 	     		result_pwd = true;
 	     	}
 	    }
 	    
 	    /* 비밀번호 재입력 일치 검사 메서드 */
 	    function checkPwd2(){
 	    	var pwd1 = document.getElementById("passwd").value;
 	    	var pwd2 = document.getElementById("passwd2").value;
 	    	var checkSpan = document.getElementById("checkPwd2");
 	    	if(pwd2 != ""){
 		    	if(pwd2 == pwd1){
 		    		checkSpan.innerHTML = "<font color='green'><b> √ 비밀번호가 일치합니다.</b></font>";
 		    	}else{
 		    		checkSpan.innerHTML = "<font color='red'><b> √ 비밀번호가 일치하지 않습니다.</b></font>";
 		    	}
 	    	}
 	    }
 		

 	
 		function send_mail() {
				var email = document.getElementById("mail").value;
			var address =  "../mail/test_mail.jsp?email="+email;
			window.open(address,"","width=370, height=360, resizable=no, status=no");
		}

    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
		
</head>
<body>
<%
	String mail = request.getParameter("mail"); 
	if(mail==null){ mail="";
	}else{
%>
	<script type="text/javascript">
		alert("이메일 인증 완료!");
	</script>
<%
	}
%>


	<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- 헤더들어가는 곳 -->
<div class="clear"></div>
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
			<h1>Join Us</h1>
			<!-- DB에 새로 추가할 회원 내용을 입력하고 회원가입 전송 버튼 클릿기
				  입력한 모든 내용은 request내장객체 메모리 영역에 저장하여 유지 된 상태로
				 joinPro.jsp를 요청함 -->
			<form action="joinPro.jsp" id="join" method="post" name="fr">
				<fieldset>
					<legend>Basic Info</legend>
				 	<label>User ID</label>
					<input type="text" id="id" name="id" class="id" />
					<input type="button" id="btn_duplicate" value="ID중복체크하기" onclick="fn_process();"><div id="message"></div>
					<label>Password</label> <input type="password" name="passwd" id="passwd" onblur="checkPwd();"><span id="passPwd1" ></span> <br>
					<label>Retype Password </label> <input type="password" name="passwd2" id="passwd2" onblur="checkPwd2();" ><span id="checkPwd2"></span><br>
					<label>Name</label> <input type="text" name="name"><br>
					<label>E-Mail</label> <input type="email" name="email" id="mail" value="<%=mail %>" readonly="readonly">
					<input type="button" class="mail" value="이메일인증" onclick="send_mail();"><br>
				</fieldset>

				<fieldset>
					<legend>Optional</legend>
					<!-- 우편번호 검색 http://postcode.map.daum.net/guide#sample-->
					<label>Address</label>
					<input type="text" id="sample4_postcode" placeholder="우편번호">
					<input type="button" class="post" onclick="sample4_execDaumPostcode();" value="우편번호 찾기"><br>
					<input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="address1">
					<input type="text" id="sample4_jibunAddress" placeholder="지번주소" name="address2">
					<span id="guide" style="color:#999;display:none"></span>
					<input type="text" id="sample4_detailAddress" placeholder="상세주소" name="address3">
					<input type="text" id="sample4_extraAddress" placeholder="참고항목">

<br>
					<!-- 우편번호 검색 -->
					
					
					<label>Number</label> <input type="text" name="tel"><br>
					<label>Mobile Phone Number</label> <input type="text" name="mtel"><br>
				</fieldset>
				<div class="clear"></div>
				<div id="buttons">
					<input type="submit" value="회원가입" class="submit">
					<input type="reset" value="Cancel" class="cancel">
				</div>
			</form>
		</article>
		<!-- 본문내용 -->

		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터들어가는 곳 -->

</body>
</html>