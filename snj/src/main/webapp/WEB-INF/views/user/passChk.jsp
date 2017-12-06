<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../template/header.jsp"%>
<script type="text/javascript" charset="utf-8"
	src="${root}/resources/js/jquery.cookie.js"></script>

<body class="login-page">
	<div class="login-box">
		<div class="login-logo">
			<a href="${root}/"><b>Siwoo</b>N<b>Japan</b></a>
		</div>
		<!-- /.login-logo -->
		<div class="login-box-body">
			<p class="login-box-msg">비밀번호를 입력해 주세요.</p>

			<form action="/user/passChkProc" method="post">
				<div class="form-group has-feedback">
					<input type="password" name="upw" class="form-control"
						placeholder="Password" /> <span
						class="glyphicon glyphicon-lock form-control-feedback"></span>
				</div>

				<!-- /.col -->
				<div class="text-right">
					<button type="submit" class="btn btn-lg btn-success btn-block">확인</button>
				</div>

			</form>
			<a href="${root}/user/pwFind">비밀번호를 잊어버리신 경우</a><br> 

		</div>
		<!-- /.login-box-body -->
	</div>
	<!-- /.login-box -->

	<!-- iCheck -->
	<script src="${root}/resources/js/icheck.min.js" type="text/javascript"></script>

	<%@include file="../template/footer.jsp"%>