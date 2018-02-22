<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<%@include file="../template/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="description" content="idFind.jsp">

<title>Insert title here</title>
<script type="text/javascript">
	$(document).ready(function(){
		//이메일 값을 입력후 enter키를 누르면 retrieveUserId()실행
		$("#email").keydown(function (key){
			if(key.keyCode == 13){ //13 enter
				retrieveUserId();
			}
		});
	});
	function retrieveUserId(){
		var param = {};
		var email = $("#email").val();
		param["email"] = email;
		var access = $("#message");
		$.ajax({
			url:"${context}/user/retrieveUserId",
			contentType:"application/json",
			dataType:"json",
			data:param,
			//성공시 ID와 로그인화면으로 이동하는 링크와 패스워드 찾는 링크를 담은 메시지 출력.
			success:function(result){
				access.html(result["checkMsg"]);
			}
		});
	}
</script>
</head>
<body>
	<!-- content start -->
	<div class="container">
		<div class="jumbotron jumbotron-info" style="background-color: lightgray;">
			<h1><font color="black"><strong>ID찾기</strong>&nbsp;<span class="glyphicon glyphicon glyphicon-pencil"></span></font></h1>
		</div>
	</div>
	<div class="container">
		<div class="form-horizontal" style="margin-bottom: 30%;">
			<hr/>

			<div class="form-group" style="margin-top: 5%;">
				<label for="email" class="control-label col-md-2">이메일</label>
				<div class="col-md-4">
					<input class="form-control" type="email" name="email" id="email" autofocus="autofocus"/>
					<button class="btn btn-default" id="btnSubmit" onclick="retrieveUserId()">확인</button>
				</div>
			</div>
			//결과 출력 부분.
			<div class="form-group" id="message">

			</div>
		</div>
	</div>
	<!-- content end -->
	<%@include file="../template/footer.jsp"%>
</body>
</html>
