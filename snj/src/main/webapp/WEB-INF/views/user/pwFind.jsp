<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
<%@include file="../template/header.jsp"%>
<script type="text/javascript">
	$(document).ready(function(){
		//email입력후 엔터키를 누르면 retrieveUserPw() 함수 실행.
		$("#email").keydown(function (key){
			if(key.keyCode == 13){
				retrieveUserPw();
			}
		});
	});
	function retrieveUserPw(){
		// id와 email값을 받아서 json 타입으로 전송.
		var id = $("#id").val();
		var email = $("#email").val();
		var param = {};
		param["id"] = id;
		param["email"] = email;
		var access = $("#message");
		$.ajax({
			url:"${context}/user/retrieveUserPw",
			contentType:"application/json",
			dataType:"json",
			data:param,
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
			<h1><font color="black"><strong>PW찾기</strong>&nbsp;<span class="glyphicon glyphicon glyphicon-pencil"></span></font></h1>
		</div>
	</div>
	<div class="container">
		<div class="form-horizontal" style="margin-bottom: 20%;">
			<hr/>

			<div class="form-group" style="margin-top: 5%;">
				<label for="email" class="control-label col-md-2">아이디</label>
				<div class="col-md-4">
					<input class="form-control" type="text" name="id" id="id" autofocus="autofocus"/>
				</div>
			</div>

			<div class="form-group">
				<label for="email" class="control-label col-md-2">이메일</label>
				<div class="col-md-4">
					<input class="form-control" type="email" name="email" id="email"/>
					<button class="btn btn-default btn-xs" id="btnSubmit" onclick="retrieveUserPw()">확인</button>
				</div>
			</div>
			//결과값 출력.(패스워드 및 로그인화면으로 이동 링크)
			<div class="form-group" id="message"></div>
		</div>
	</div>
	<!-- content end -->
<%@include file="../template/footer.jsp"%>
