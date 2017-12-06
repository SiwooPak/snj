<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>Siwoo N Japan</title>
<!-- Bootstrap Core CSS -->
<link rel="stylesheet" href="${root}/resources/css/bootstrap.min.css"
	type="text/css">
<!-- Custom Fonts -->
<link
	href='https://fonts.googleapis.com/css?family=Mrs+Sheppards%7CDosis:300,400,700%7COpen+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800;'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet"
	href="${root}/resources/font-awesome/css/font-awesome.min.css"
	type="text/css">
<!-- Plugin CSS -->
<link rel="stylesheet" href="${root}/resources/css/animate.min.css"
	type="text/css">
<!-- Custom CSS -->
<link rel="stylesheet" href="${root}/resources/css/style.css"
	type="text/css">
<link href="${root}/resources/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link href="${root}/resources/css/jquery-ui.min.css" rel="stylesheet">
<link href="${root}/resources/css/jquery-ui.theme.min.css" rel="stylesheet" type="text/css" />
<link href="${root}/resources/css/jquery-ui.structure.min.css" rel="stylesheet" type="text/css" />
<!-- Theme style -->
<link href="${root}/resources/css/AdminLTE.min.css" rel="stylesheet"
	type="text/css" />
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@7.0.6/dist/sweetalert2.min.css" rel="stylesheet"
	type="text/css" />	
	
<%-- <!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->
<link href="${root}/resources/css/_all-skins.min.css" rel="stylesheet"
	type="text/css" /> --%>


</head>
<body>
<body id="page-top">
	<nav id="mainNav" class="navbar navbar-default navbar-fixed-top">
		<div class="nav-container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand page-scroll" href="${root}/">
					<h2 class="bottombrand wow flipInX">SiwooNJapan</h2>
				</a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li><a class="page-scroll" href="${root}/">Home</a></li>
					<li><a class="dropdown-toggle" data-toggle="dropdown"
						id="dropMenu" aria-expanded="true">Menu</a>

						<ul class="dropdown-menu" role="menu" aria-labelledby="dropMenu">
							<li role="presentation"><a role="menuitem" tabindex=-1
								href="${root}/board/list?category=N">공지사항</a></li>
							<li role="presentation"><a role="menuitem" tabindex=-1
								href="${root}/board/list?category=H">공포게시판(일반)</a></li>
							<li role="presentation"><a role="menuitem" tabindex=-1
								href="${root}/board/list?category=M">공포게시판(영상)</a></li>
							<li role="presentation"><a role="menuitem" tabindex=-1
								href="${root}/board/list?category=A">일본의 이곳저곳</a></li>
							<li role="presentation"><a role="menuitem" tabindex=-1
								href="${root}/board/list?category=I">생생 일본통</a></li>
							<li role="presentation"><a role="menuitem" tabindex=-1
								href="${root}/guestBooks/">방명록</a></li>
						</ul></li>
					<c:if test="${empty login }">
						<li><a class="page-scroll" href="/user/login">Log_In</a></li>
						<li><a class="page-scroll" href="/user/createUser">Membership</a></li>
					</c:if>
					<c:choose>
						<c:when test="${not empty login && grade eq 'A'}">
							<li><a class="page-scroll" href="/user/passChk">Members</a></li>
						</c:when>
						<c:when test="${not empty login && grade ne 'A'}">
							<li><a class="page-scroll" href="/user/passChk">
									<h5 class="bottombrand wow flipInX">${login.uname}</h5>
							</a></li>
						</c:when>
					</c:choose>
					<c:if test="${not empty login}">
						<li><a class="page-scroll" href="/user/logout">Log_Out</a></li>
					</c:if>

				</ul>
			</div>
			<!-- /.navbar-collapse -->
			<div class="modal fade" id="loginModal">
				<div class="modal-dialog">
					<div class="modal-content">
						<!-- remote ajax call이 되는영역 -->
					</div>
				</div>
			</div>
		</div>
	</nav>
	<script src="${root}/resources/js/jquery-3.2.1.min.js"></script>
	<script src="${root}/resources/js/jquery.form.js"></script>
	<script src="${root}/resources/js/jquery-ui.min.js"></script>
	<script src="${root}/resources/js/bootstrap.min.js"></script>
	<script src="${root}/resources/js/parallax.js"></script>
	<script src="${root}/resources/js/countto.js"></script>
	<script src="${root}/resources/js/jquery.easing.min.js"></script>
	<script src="${root}/resources/js/wow.min.js"></script>
	<script src="${root}/resources/js/jquery.dataTables.js"></script>
	<script src="${root}/resources/js/dataTables.bootstrap.js"></script>
	<script src="${root}/resources/js/common.js"></script>	
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.0.6/dist/sweetalert2.min.js"></script>
	<script type="text/javascript" src="${root}/resources/js/upload.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>