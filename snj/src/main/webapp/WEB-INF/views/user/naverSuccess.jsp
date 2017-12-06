<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>네이버 로그인 성공시</title>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<style type="text/css">
html, div, body, h3 {
	margin: 0;
	padding: 0;
}

h3 {
	display: inline-block;
	padding: 0.6em;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		var name = ${result}.response.name;
		var email = ${result}.response.email;
		var birth = ${result}.response.birthday;
		var userId1 = ${result}.response.id;
		var userId2 = ${result}.response.enc_id;
		$("#name").html("환영합니다. "+name+"님");
		$("#email").html(email);
		$("#birth").html(birth);
		$("#id1").html(userId1);
		$("#id2").html(userId2);
	  });
</script>
</head>
<body>
	<div
		style="background-color: #15a181; width: 100%; height: 50px; text-align: center; color: white;">
		<h3>SIST Naver_Login Success</h3>
	</div>
	<br>
	<h2 style="text-align: center" id="name"></h2>
	<h4 style="text-align: center" id="email"></h4>
	<h4 style="text-align: center" id="birth"></h4>
	<h4 style="text-align: center" id="id1"></h4>
	<h4 style="text-align: center" id="id2"></h4>
</body>
</html>