<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../template/header.jsp"%>
<script type="text/javascript" charset="utf-8"
	src="${root}/resources/js/jquery.cookie.js"></script>

<body class="login-page" style="background-image: url(http://siwoo1620.cdn3.cafe24.com/loginBG.gif);
	background-size: cover;">
	<div class="login-box">
		<div class="login-logo">
			<a href="${root}/"><b>Siwoo</b>N<b>Japan</b></a>
		</div>
		<!-- /.login-logo -->
		<div class="login-box-body">
			<p class="login-box-msg">로그인 해 주세요.</p>
			<form action="./loginProc" method="post">
				<div class="form-group has-feedback">
					<input type="text" id="uid" name="u_id" class="form-control"
						placeholder="USER ID" /> <span
						class="glyphicon glyphicon-envelope form-control-feedback"></span>
				</div>
				<div class="form-group has-feedback">
					<input type="password" id="pass" name="upw" class="form-control"
						placeholder="Password" /> <span
						class="glyphicon glyphicon-lock form-control-feedback"></span>
				</div>

				<div class="checkbox icheck">
					<label> <input type="checkbox" name="useCookie"> ID
						저장
					</label>
				</div>

				<!-- /.col -->
				<div class="text-right">
					<button class="btn btn-lg btn-success btn-block">로그인</button>
				</div>
			</form>
			<a href="${root}/user/idFind">아이디를 잊어버리신 경우</a><br> <a
				href="${root}/user/pwFind">비밀번호를 잊어버리신 경우</a><br> <a
				href="${root}/user/createUser" class="text-center"> 회원가입</a>

		</div>
		<!-- /.login-box-body -->
	</div>
	<!-- /.login-box -->

	<!-- iCheck -->
	<script src="${root}/resources/js/icheck.min.js" type="text/javascript"></script>
	<script>
		$(function() {
			$('input').iCheck({
				checkboxClass : 'icheckbox_square-blue',
				radioClass : 'iradio_square-blue',
				increaseArea : '20%' // optional
			});
		});
	</script>

	<%@include file="../template/footer.jsp"%>