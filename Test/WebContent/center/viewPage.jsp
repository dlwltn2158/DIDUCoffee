<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Cos Blog</title>
<!-- Bootstrap core CSS -->
<link href="<%=request.getContextPath()%>/css/bootstrap.css"
	rel="stylesheet">
<!-- Custom styles for this template -->
<link href="<%=request.getContextPath()%>/css/blog-home.css"
	rel="stylesheet">
<!-- Bootstrap core JavaScript -->
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script> 
<script src="<%=request.getContextPath()%>/js/bootstrap.bundle.min.js"></script>
</head>

<body>
	<!-- Navigation -->
	<jsp:include page="../inc/top.jsp" />

	<!-- Page Content -->
	<div class="container">
		<div class="row">

			<div class="col-md-12">
				<div class="card mb-4">
					<!--<img class="card-img-top" src="http://placehold.it/750x300" alt="Card image cap"> -->
					<!-- Post Content Column -->
					<div class="card-body main">
						<!-- Title -->
						<h1 class="mt-4">${board.title}</h1>
						<!-- Author -->
						<p class="lead">
							by <a href="#">${board.id}</a>
						</p>
						<hr>
						<c:if test="${board.id eq sessionScope.id}">
							<a class="btn btn-warning"
								href="<%=request.getContextPath()%>/board?cmd=board_update&num=${board.num}">수정</a>
							<a class="btn btn-danger"
								href="<%=request.getContextPath()%>/board?cmd=board_delete&num=${board.num}">삭제</a>
							<hr>
						</c:if>
						<!-- Date/Time -->
						<p>Posted on ${board.writedate}</p>
						<hr>
						<!-- Post Content -->
						<div id="viewContent">${board.content}</div>
						<hr>
						
						<!-- Comments Form -->
						<div class="card my-4">
							<!-- 댓글달기 -->
							<!-- ------------------------------------------------------------- -->
							<h5 class="card-header">Leave a Comment:</h5>
							<div class="card-body">
								<div class="form-group">
									<textarea class="form-control" id="replyData" rows="3"></textarea>
								</div>

								<c:choose>
									<c:when test="${empty sessionScope.id}">
										<input type="button" class="btn btn-primary"
											onclick="alert('로그인 후 이용가능합니다.')" value="Submit">
									</c:when>
									<c:otherwise>
										<input type="button" class="btn btn-primary" onclick="sendReply()"
											value="Submit">
									</c:otherwise>
								</c:choose>

							</div>
						</div>

						<div id="reply">
							<!-- Comment  -->
							<div class="media mb-4">
								<img class="d-flex mr-3 rounded-circle"
									src="<%=request.getContextPath()%>/img/reply.png">
								<div class="media-body">
									<h5 class="mt-0">ssar</h5>
									0
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
		<!-- /.row -->

	</div>
	
	<!-- /.container -->
	<script>
	
		function sendReply(){
			var replyData = document.getElementById("replyData");
			var recontent = replyData.value; // textarea의 적히는글이 여기에 뜬다.
			if(recontent == ''){
				alert('글을 입력하세요');
				return false;
			}
			//json 처럼 생긴 String
			var jsonData = { //key : value 의 형식으로 들어감.
					"recontent" : recontent,
					"id" : "${sessionScope.id}",
					"num" : "${board.num}"
			};
			//json 타입으로 변경하기.
			
			//json 타입의 객체로 생성시에 parse를 사용한다.(.으로 처리가 가능하다)
			// var mydata = JSON.parse(jsonData); 
			//데이터를 보내기만 할꺼기 때문에 string으로 바뀐다. (그냥 string을 사용하는게 편하다.)
			//생긴거만 json으로 만들고 text(문자)로 보내는게 더 편하다.(통신의 경우에만)
			//json 타입의 String 파일로 변경한다는 뜻.
			var result = JSON.stringify(jsonData);
			
			replyData.value = '';
			
			$.ajax({
				type : "POST",
				url : "board?cmd=reboard_reply",
				// text로 보내는 이유? -->
				dataType : "text",
				contentType : "application/text:charset=utf-8",
				data : result,
				success : function(data){ //익명의 함수추가
					// .해서 호출하기 위해서 사용 ex) result. 이런식으로
					var result = JSON.parse(data);
					alert(result.renum + result.num + result.id + result.recontent)
				},
				error : function(jqXHR, textStatus, errorThrown){
					console.log("에러발생 !! \n"+ textStatus + ":" + errorThrown);
				}
				
			});
		}
	
	</script>
	
</body>
</html>