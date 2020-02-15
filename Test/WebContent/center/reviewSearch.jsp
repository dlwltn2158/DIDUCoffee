<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

</head>
<%
//한글처리
request.setCharacterEncoding("utf-8");
//search 가져오기
String search=request.getParameter("search");

//DB작업 객체생성 
BoardDAO boardDAO = new BoardDAO();

//게시판 글개수 가져오기  int count = 메서드호출 getCount()
int count=boardDAO.revgetCount(search);

//하나의 화면 마다 보여줄 글개수 10
int pageSize = 10;

//---------------------------------------------
//현제보여질(선택한) 페이지번호 가져오기. 
String pageNum = request.getParameter("pageNum");
//현제보여질(선택한) 페이지번호가 없으면 1페이지 처리
if(pageNum == null){
    pageNum = "1";
}
/*현제 보여질(선택한) 페이지 번호*/
//현제보여질(선택한) 페이지번호  "1" 을 -> 기본정수 1로 변경
int currentPage = Integer.parseInt(pageNum);
//-------------------------------------------------

/*각페이지 마다 맨위에 첫번째로 보여질 시작 글번호 구하기*/
//(현제 보여질 페이지번호 - 1 ) * 한페이지당 보여줄 글개수 15
int startRow = (currentPage-1)*pageSize;


//게시판 글객체(BoardBean)를 저장하기 위한 용도
List<BoardBean> list = null;

//만약 게시판에 글이 있다면..
if(count > 0){
    //글목록 가져오기
    //getBoardList(각페이지 마다 맨위에 첫번째로 보여질 시작 글번호, 한페이지당 보여줄 글개수,검색어)
    list = boardDAO.revgetBoardList(startRow, pageSize,search);
}
//날짜 포멧
SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
%>
<body>
<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
			<div id="header">
		<div>
			<a href="../index.jsp"><img class="logo" src="../images/didu.png" width="513" height="84" alt="" title=""></a>
			
			<ul class="navigation">
				<li>
					<a class="active" href="../index.jsp">Home</a>
				</li>
				<li>
					<a href="../menu/about.jsp">About</a>
				</li>
				<li>
					<a href="../menu/coffee.jsp">Menu</a>
				</li>
				<li>
					<a href="notice.jsp">Notice</a>
				</li>
				<li>
					<a href="review.jsp">Review</a>
				</li>
			</ul>
		</div>
	</div>


<!-- 게시판 -->
<article id="board">
<h1>Review</h1>
[전체글개수: <%=count %>]
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">Read</th></tr>
<%
	//만약 게시판글개수가 존재하고(게시판에 글이 있다면)
	if(count > 0){
	    for(int i=0; i<list.size(); i++){
	        BoardBean bean = list.get(i);
		%>
		<tr onclick="location.href='review.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>'">
			<td><%=bean.getNum() %></td>
     		<td class="left">
       			<%
				int wid = 0; //답변글에 대한 들여쓰기 값 저장
				
				//답변글에 대한 들여쓰기 값이 0보다 크다면?
				if(bean.getRe_lev() > 0){
					//들여쓰기 값 처리
					wid = bean.getRe_lev() * 10; 
				%>
				<img src="../images/level.gif" width="<%=wid%>" height="15">
				<img src="../images/re.gif">
				<%
				}
				%>
     			<%=bean.getSubject() %></td>
			<td><%=bean.getName() %></td>
			<td><%=sdf.format(bean.getDate())%></td>
			<td><%=bean.getReadcount() %></td>
		</tr>		
		<%	        
	    }//for 끝    
	}else { //게시판이 글개수가 존재 하지 않으면(글이없다는뜻)
	    %>
	    <tr>
	    	<td colspan="5">게시판 글 없음</td>
	    </tr>	    
	    <%
	}//if ~ else 끝	
%>    
</table>

<%
//순서1. 추가----------------------------------- 
//각각 페이지에서..로그인후 이동해 올떄...세션 id 전달 받기
String id=(String)session.getAttribute("id");
//세션값이 있으면  글쓰기 버튼 보이게 설정
if(id!=null){
	%>
<div id="table_search">
<input type="button" value="글쓰기" class="btn" onclick="location.href='revwrite.jsp'">
</div>	
	<%
}
//순서1 추가 끝-----------------------------------
%>


<div id="table_search">
<form action="reviewSearch.jsp">
<input type="text" name="search" class="input_box">
<input type="submit" value="search" class="btn">
</form>
</div>
<div class="clear"></div>
<div id="page_control">
<%
if(count>0){
	//전체 페이지수 구하기  글 20개 한페이지 보여줄 글수 10개 => 2페이지
	//             글 25개 한페이지 보여줄 글수 10개 => 3페이지
	//             조건(삼항)연산자   조건?참:거짓
	//전 체페이지수 = 전체글 / 한페이지에 보여줄 글수  + (전체글수를 한페이지에 보여줄 글수로 나눈 나머지값)        
	int pageCount=count/pageSize+(count%pageSize==0?0:1);
	//한화면(한블럭) 에 보여줄 페이지수 설정
	int pageBlock=1;
	
	/*시작페이지 번호 구하기*/
	// 1~10 => 1  11~20 => 11  21~30 => 21
	//((현제 보여질(선택한) 페이지 번호/한화면(한블럭) 에 보여줄 페이지수)   -
	//(현제 보여질(선택한) 페이지 번호를 한화면에 보여줄 페이지수로 나눈 나머지값 ))   *
	//한화면(한블럭)에 보여줄 페이지수 +1
	int startPage=((currentPage/pageBlock)-(currentPage%pageBlock==0?1:0))*pageBlock+1;
	
	//끝페이지 번호 구하기 1~10 => 10  11~20 => 20  21~30 => 30
	int endPage=startPage+pageBlock-1; //시작페이지번호 + 현재블럭에 보여줄 페이지수 -1
	//끝페이지번호가 전체페이지수보다 클때... 
	if(endPage > pageCount){ 
	   // 끝페이지번호를 전체페이지수로 저장
		endPage = pageCount;
	}
	//[이전] 시작페이지 번호가 한화면에 보여줄 페이지수 보다 클때...
	if(startPage > pageBlock){
		%><a href="reviewSearch.jsp?pageNum=<%=startPage-pageBlock%>&search=<%=search %>">[이전]</a><%
	}
	// [1][2][3][4]..[10]
	for(int i=startPage;i<=endPage;i++){
		%><a href="reviewSearch.jsp?pageNum=<%=i%>&search=<%=search%>">[<%=i %>]</a><%
	} 
	//[다음] 끝페이지 번호가 전체페이지수 보다 작을때..
	if(endPage < pageCount){
		%><a href="reviewSearch.jsp?pageNum=<%=startPage+pageBlock%>&search=<%=search%>">[다음]</a><%
	}
}
%>
</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터들어가는 곳 -->
</body>
</html>