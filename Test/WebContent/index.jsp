<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
	<title>DIDU Coffee</title>
	<meta charset="utf-8">
	<link href="css/style.css" rel="stylesheet" type="text/css">
	<link href="css/subpage.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="js/swipe.js"></script>
	<script type="text/javascript" src="js/jquery.bxslider.min.js"></script>
	
<script type="text/javascript">

$(function(){
    var sliderImage = $('.imagebox').bxSlider({
        auto: true, //자동넘어가기
        autoControls: false, //play, stop
        pager: false,  //페이지
         nextSelector: '#slider-next',  //다음으로 넘길 객체
          prevSelector: '#slider-prev',  //이전으로 넘길 객체
       });
    
  //기타옵션
 // mode : 'fade',   //슬라이드 방식 default : 'horizontal', options: 'horizontal', 'vertical', 'fade' 
 // autoHover: true //마우스 오버시 정지 여부
 // controls: false    // 이전 다음 버튼 노출 여부
 //아래는 이미지버튼을 클릭했을 때 이미지를 넘어가게 하기 위한 이벤트다.
 
 $('#next').click(function(){  //다음이미지 클릭 시
     sliderImage.goToNextSlide();
     return false;
   });
    $('#prev').click(function(){ //이전 이미지 클릭 시
     sliderImage.goToPrevSlide();
     return false;
   });
 }); 


</script>

</head>
<body>
		

	<%
			// 각 상단 메뉴에서 공통적으로 사용된 소스
			// 세션 영역에 저장된 값 얻기
			String id = (String)session.getAttribute("id");
			
			if(id == null){ // 세션값이 존재하지않을때
%>				
			<div id="login">
				<a href="member/login.jsp">login</a> |
				<a href="member/join_Mailcheck.jsp">join</a>
			</div>
<%				
			}else{ // 세션값이 존재할때
				if(id.equals("admin")){
%>				
			<div id="login">
				<%=id %>님 <a href="mail/mail.jsp">mail</a> |
				<a href="member/logout.jsp">logout</a>						
			</div>
<%
				}else{
%>			
			<div id="login">
				<%=id %>님 <a href="member/modify.jsp">modify</a> |
				<a href="member/logout.jsp">logout</a>						
			</div>
<%				
			}
		}
	
	%>

	<div class="clear"></div>
	<div id="header">

		<div>
			<a href="index.jsp"><img class="logo" src="images/didu.png" width="513" height="84" alt="" title=""></a>
			
			<ul class="navigation">
				<li>
					<a class="active" href="index.jsp">Home</a>
				</li>
				<li>
					<a href="menu/about.jsp">About</a>
				</li>
				<li>
					<a href="menu/coffee.jsp">Menu</a>
				</li>
				<li>
					<a href="center/notice.jsp">Notice</a>
				</li>
				<li>
					<a href="center/review.jsp">Review</a>
				</li>
				
			</ul>
		</div>
	</div>

		
		  <!-- Wrapper for slides -->
		  <div featured>
		 <div class="slide">
      	<img id="prev" src="images/button1.png" alt="" width="50">
      	<ul class="imagebox">
        	<li><img src="images/coffee/2.jpg" alt="" width="1000" height="600"></li>
       		 <li><img src="images/coffee/3.jpg" alt="" width="1000" height="600"></li>
       		 <li><img src="images/coffee/brewed_coffee.jpg" alt="" width="1000" height="600"></li>
       		 <li><img src="images/coffee/6.jpg" alt="" width="1000" height="600"></li>
        	<li><img src="images/coffee/8.jpg" alt="" width="1000" height="600"></li>
     	 </ul>
      	<img id="next" src="images/button2.png" alt="" width="50">
    	</div>
    	
		 <!-- Wrapper for slides -->
		 
	<div id="sec_news">
<h3 class="orange">Hello</h3>
<dl>
<dt>DIDU Coffee</dt>
<dd>방문해주셔서 감사합니다♥</dd>
</dl>
<dl>
<dt>신뢰를 담은 커피,</dt>
<dd>DIDU Coffee에서 향기로운 시간을 즐기세요♥</dd>
</dl>
</div>

	
<div id="news_notice">
<h3 class="brown">Notice</h3>
<table>
<%
	// DB객체 생성
	BoardDAO boardDao = new BoardDAO();
	// int count = 전체글개수 메소드호출  getBoardCount()
	int count = boardDao.getBoardCount();
	List<BoardBean> list = null;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	
	if (count > 0) {
		list = boardDao.getBoardList(0, 5);
		BoardBean bean = null;
		for (int i=0; i<list.size(); i++) {
			bean = list.get(i);
			%>
			<tr>
				<td class="contxt">
				<%
					int wid = 0;
					if (bean.getRe_lev() > 0) {
						wid = bean.getRe_lev() * 10;
						%>
						<img src="images/mark.png" width="<%=wid %>" height="15">
						<%
					}
				%>
					<a href="center/content.jsp?num=<%=bean.getNum()%>&pageNum=1"><%=bean.getSubject() %></a>
				</td>
				<td><%=sdf.format(bean.getDate()) %></td>
			</tr>
			<%
		}
	} else {
		%>
		<tr><td class="contxt" colspan="2">게시판 글 없음</td></tr>
		<%
	}
%>
</table>
</div>

		
		    	<div id="footer">
		<div>
			<ul>
				<li class="first">
					<!-- <h2>Delivery Hotline</h2> -->
					<h2>Call 123-456-7890</h2>
					<ul>
						<li>
							<a href="https://www.facebook.com/" class="facebook"></a>
						</li>
						<li>
							<a href="https://twitter.com/" class="twitter"></a>
						</li>
						<li>
							<a href="https://www.google.com/" class="googleplus"></a>
						</li>
					</ul>
				</li>
				<li>
					<a href="index.jsp"><img class="logo" src="images/logo-footer.png" alt=""></a>
					<ul class="navigation">
						<li>
							<a href="index.jsp">Home</a>
						</li>
						<li>
							<a href="menu/about.jsp">About</a>
						</li>
						<li>
							<a href="menu/coffee.jsp">Menu</a>
						</li>
						<li>
							<a href="center/notice.jsp">Notice</a>
						</li>
					</ul>
					<span>&copy; 1993 DIDU Coffee.com</span>
				</li>
				
				<li class="last">		
					<h2>DIDU Coffee</h2>
					<h2>CEO : Lee Jisu</h2>
				</li>

		</div>
		
</body>
</html>