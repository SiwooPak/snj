<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="root" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SiwooNJapan</title>
<!-- Bootstrap Core CSS -->
<link rel="stylesheet" href="${root}/resources/css/bootstrap.min.css"
	type="text/css">
<!-- Custom Fonts -->
<link
	href='https://fonts.googleapis.com/css?family=Mrs+Sheppards%7CDosis:300,400,700%7COpen+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800;'
	rel='stylesheet' type='text/css'>
<link href="https://fonts.googleapis.com/css?family=Indie+Flower"
	rel="stylesheet">
<link rel="stylesheet"
	href="${root}/resources/font-awesome/css/font-awesome.min.css"
	type="text/css">
<!-- Plugin CSS -->
<link rel="stylesheet" href="${root}/resources/css/animate.min.css"
	type="text/css">
<!-- Custom CSS -->
<link rel="stylesheet" href="${root}/resources/css/style.css"
	type="text/css">
<style type="text/css">
body {
	margin: 0;
	padding: 0;
	background: url(img.jpg) center center fixed no-repeat;
}

video {
	position: fixed;
	top: 0;
	left: 0;
	min-width: 100%;
	min-height: 100%;
	width: auto;
	height: auto;
	z-index: -1;
}
</style>

</head>
<c:set var="noticeUrl">${root}/board/list?category=${categoryList[0].categorycd}</c:set>
<c:set var="horrorUrl">${root}/board/list?category=${categoryList[1].categorycd}</c:set>
<c:set var="movieUrl">${root}/board/list?category=${categoryList[2].categorycd}</c:set>
<c:set var="attractionUrl">${root}/board/list?category=${categoryList[3].categorycd}</c:set>
<c:set var="liveUrl">${root}/board/list?category=${categoryList[4].categorycd}</c:set>
<body>
	<video autoplay loop poster="img.jpg">
		<c:choose>
			<c:when test="${now%2==0}">
				<source id="#video-1"
					src="http://siwoo1620.cafe24.com/down/bgm(rap).mp4"
					type="video/mp4">
			</c:when>
			<c:when test="${now%2==1}">
				<source id="#video-2"
					src="http://siwoo1620.cafe24.com/down/C-ute.mp4" type="video/mp4">
			</c:when>
		</c:choose>
	</video>
<body id="page-top">

	<nav id="mainNav" class="navbar-default navbar-fixed-top">
		<div class="nav-container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand page-scroll" href="/">
					<h2 class="bottombrand wow flipInX">SiwooNJapan</h2>
				</a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li><a class="page-scroll" href="#page-top">Home</a></li>
					<li><a class="page-scroll" href="#Menu" id="Menu">Menu</a></li>
					<c:if test="${empty login }">
						<li><a class="page-scroll" href="/user/login">Log_In</a></li>
						<li><a class="page-scroll" href="/user/createUser">Membership</a></li>
					</c:if>
					<c:if test="${not empty login}">
						<li><a class="page-scroll" href="#chat" id="chat">Chatting</a></li>
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
		</div>
		<!-- /.container -->
	</nav>

	<!-- Section Intro Slider
================================================== -->
	<div id="carousel-example-generic" class="carousel intro slide"
		data-wow-delay="0.2s">
		<!-- Indicators -->

		<ol class="carousel-indicators">
			<li data-target="#carousel-example-generic" data-slide-to="0"
				class="active"></li>
			<li data-target="#carousel-example-generic" data-slide-to="1"></li>
			<li data-target="#carousel-example-generic" data-slide-to="2"></li>
		</ol>
		<!-- Wrapper for slides -->
		<div class="carousel-inner" role="listbox">
			<!-- First slide -->
			<div class="item active"
				style="background-image: url(http://siwoo1620.cdn3.cafe24.com/horror.jpg);">
				<div class="carousel-caption">
					<h2 data-animation="animated bounceInDown">Siwoo n Japan</h2>
					<h1 data-animation="animated bounceInUp">Japan n Horror</h1>
					<a href="${movieUrl}" class="btn btn-warning btn-lg"
						data-animation="animated fadeInLeft">Horror Video</a> <a
						href="${horrorUrl}" class="btn btn-primary btn-lg"
						data-animation="animated fadeInRight">Horror BBS</a>
				</div>
			</div>
			<!-- /.item -->
			<!-- Second slide -->
			<div class="item"
				style="background-image: url(http://siwoo1620.cdn3.cafe24.com/attraction.png)">
				<div class="carousel-caption">
					<h2 data-animation="animated zoomInLeft">Siwoo n Japan</h2>
					<h1 data-animation="animated zoomInRight">Attraction</h1>
					<a href="${attractionUrl}" class="btn btn-warning btn-lg"
						data-animation="animated bounceIn">Start Tour</a> <a
						href="${liveUrl}" class="btn btn-primary btn-lg"
						data-animation="animated bounceIn">Japan Info</a>
				</div>
			</div>
			<!-- /.item -->
			<!-- Third slide -->
			<div class="item"
				style="background-image: url(http://siwoo1620.cdn3.cafe24.com/guest.jpg)">
				<div class="carousel-caption">
					<h2 data-animation="animated bounceInLeft">Siwoo n Japan</h2>
					<h1 data-animation="animated bounceInRight">Notice n GuestBook</h1>
					<a href="${noticeUrl}" class="btn btn-warning btn-lg"
						data-animation="animated zoomInRight">Notice</a> <a
						href="${root}/guestBooks/" class="btn btn-primary btn-lg"
						data-animation="animated zoomInRight">GuestBook</a>
				</div>
			</div>
			<!-- /.item -->
		</div>
		<!-- /.carousel-inner -->
		<!-- Controls (currently displayed none from style.css)-->
		<a class="left carousel-control" href="#carousel-example-generic"
			role="button" data-slide="prev"> <span
			class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="right carousel-control" href="#carousel-example-generic"
			role="button" data-slide="next"> <span
			class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			<span class="sr-only">Next</span>
		</a>
	</div>
	<div class="clearfix"></div>

	<!-- Section Testimonials
================================================== -->
	<section id="testimonials">
		<div class="container">
			<div class="row">
				<div class="col-md-12" data-wow-delay="0.2s">
					<div class="carousel slide" data-ride="carousel"
						id="quote-carousel">
						<!-- Bottom Carousel Indicators -->
						<ol class="carousel-indicators">
							<li data-target="#quote-carousel" data-slide-to="0"
								class="active"><img class="img-responsive "
								src="http://siwoo1620.cdn3.cafe24.com/siwoo27.jpg" alt=""></li>
							<li data-target="#quote-carousel" data-slide-to="1"><img
								class="img-responsive"
								src="http://siwoo1620.cdn3.cafe24.com/siwoo24.jpg" alt=""></li>
						</ol>
						<!-- Carousel Slides / Quotes -->
						<div class="carousel-inner text-center">
							<!-- Quote 1 -->
							<div class="item active">
								<blockquote>
									<div class="row">
										<div class="col-sm-8 col-sm-offset-2">
											<p>한참 모델한다고 다이어트 했던 그 때의 나, 지금 생각해 보면&nbsp;&nbsp;'더 노력했으면
												어땠을까'&nbsp;&nbsp;라는 생각을 가끔 해 본다. 지금 IT계열로 가는 것에 대한 후회는 별로
												없다. 일본으로 IT취업을 했을 당시에도 좀 더 외국에서 일하는 한국 사람의 자세로 임했다면 하는 아쉬움도
												있지만, 그러한 경험들이 하나씩 쌓여 지금의 내가 되었고, 그만큼의 인연들도 생겼기에 멍하니 멈춰 서 있지
												않고, 하나씩 나아가고 있다. 頑張れ、シウーくん！</p>
											<small>27살의 나</small>
										</div>
									</div>
								</blockquote>
							</div>
							<!-- Quote 2 -->
							<div class="item">
								<blockquote>
									<div class="row">
										<div class="col-sm-8 col-sm-offset-2">
											<p>ようこそーシウーと日本のブログに〜別に見る事はありませんですけど、
												訪問してくれてありがとうございます。私は昼より夜がもっと好きで そんな理由は夜空に浮かんでいる月を見るのが好きだかです。
												その以外ものは日本の文化を好き、猫も好き、音楽を聞き事も好きです。
												まあ〜ホラーもとっても好きだから、その部分もあのブログに色々な情報が
												ありますから、ちゃんとご覧でください。日本の名所もドンドンアップ するつもりです。とぞ、よろしく！</p>

											<small>24歳の僕</small>
										</div>
									</div>
								</blockquote>
							</div>
							<!-- End Quote 2 -->
						</div>
						<!-- Carousel Buttons Next/Prev -->
						<a data-slide="prev" href="#quote-carousel"
							class="left carousel-control"><i class="fa fa-chevron-left"></i></a>
						<a data-slide="next" href="#quote-carousel"
							class="right carousel-control"><i class="fa fa-chevron-right"></i></a>
					</div>
				</div>
			</div>
		</div>
	</section>
	<div class="clearfix"></div>

	<!-- Section Contact
==================================================================================================== -->
	<section id="contact">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-offset-2 text-center">
					<h2 class="section-heading">
						CONTACT <b>ME</b>
					</h2>
					<hr class="primary">
					<p>일본에 궁금한 것이 있으면 무엇이든 물어보세요.</p>
					<div class="regularform">
						<div class="done">
							<div class="alert alert-success">
								<button type="button" class="close" data-dismiss="alert">×</button>
								메일이 발송되었습니다, 감사합니다!
							</div>
						</div>
						<form method="post" action="/sendMail" id="mail" class="text-left">
							<input name="name" type="text" class="col-md-6 norightborder"
								placeholder="Your Name *" required="required" id="focus">
							<input name="email" type="email" class="col-md-6"
								placeholder="E-mail address *">
							<textarea name="comment" class="col-md-12"
								placeholder="Message *"></textarea>
							<div class="modal-footer">
								<button class="contact submit btn btn-primary btn-xl"
									data-animation="animated bounceInUp">Send Mail</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	<div class="clearfix"></div>


	<!-- Section Menu(Modal)
====================================================================================================================================================== -->

	<div class="modal fade" id="menu">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					Menu
					<button type="button" class="close" data-dismiss="modal">×</button>
				</div>
				<div class="modal-body">
					<div class="container-fluid">
						<div class="row no-gutter">
							<div class="col-lg-4 col-sm-6">
								<a href="${noticeUrl}" class="portfolio-box"> <img
									src="http://siwoo1620.cdn3.cafe24.com/notice(moon).png"
									class="img-responsive img-rounded" alt="공지사항">
									<div class="portfolio-box-caption">
										<div class="portfolio-box-caption-content">
											<div class="project-category text-faded">Notice</div>
											<div class="project-name">공지사항</div>
										</div>
									</div>
								</a>
							</div>

							<div class="col-lg-4 col-sm-6">
								<a href="${horrorUrl}" class="portfolio-box"> <img
									src="http://siwoo1620.cdn3.cafe24.com/horror2.gif"
									class="img-responsive img-rounded" alt="공포게시판(일반)">
									<div class="portfolio-box-caption">
										<div class="portfolio-box-caption-content">
											<div class="project-category text-faded">Horror BBS</div>
											<div class="project-name">공포게시판(일반)</div>
										</div>
									</div>
								</a>
							</div>
							<div class="col-lg-4 col-sm-6">
								<a href="${movieUrl}" class="portfolio-box"> <img
									src="http://siwoo1620.cdn3.cafe24.com/horror.jpg"
									class="img-responsive img-rounded" alt="공포게시판(영상)">
									<div class="portfolio-box-caption">
										<div class="portfolio-box-caption-content">
											<div class="project-category text-faded">Horror Video</div>
											<div class="project-name">공포게시판(영상)</div>
										</div>
									</div>
								</a>
							</div>
							<div class="col-lg-4 col-sm-6">
								<a href="${attractionUrl}" class="portfolio-box"> <img
									src="http://siwoo1620.cdn3.cafe24.com/attraction.png"
									class="img-responsive img-rounded" alt="일본의 이곳저곳">
									<div class="portfolio-box-caption">
										<div class="portfolio-box-caption-content">
											<div class="project-category text-faded">Japan's
												Attraction</div>
											<div class="project-name">일본의 이곳저곳</div>
										</div>
									</div>
								</a>
							</div>
							<div class="col-lg-4 col-sm-6">
								<a href="${liveUrl}" class="portfolio-box"> <img
									src="http://siwoo1620.cdn3.cafe24.com/livejapan.jpg"
									class="img-responsive img-rounded" alt="생생 일본통">
									<div class="portfolio-box-caption">
										<div class="portfolio-box-caption-content">
											<div class="project-category text-faded">Japan's Live</div>
											<div class="project-name">생생 일본통</div>
										</div>
									</div>
								</a>
							</div>
							<div class="col-lg-4 col-sm-6">
								<a href="/guestBooks/" class="portfolio-box"> <img
									src="http://siwoo1620.cdn3.cafe24.com/guest.jpg"
									class="img-responsive img-rounded" alt="Guest_Book">
									<div class="portfolio-box-caption">
										<div class="portfolio-box-caption-content">
											<div class="project-category text-faded">Guest_Book</div>
											<div class="project-name">방명록</div>
										</div>
									</div>
								</a>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	
	<div class="modal fade" id="modal-chat">
		<div class="modal-dialog">
			<div class="modal-content"></div>
		</div>
	</div>

	<!-- Section Footer
====================================================================================================-->
	<section id="social" class="parallax parallax-image"
		style="background-image: url(http://siwoo1620.cdn3.cafe24.com/moon.jpg);">
		<div class="overlay" style="background: #222; opacity: 0.5;"></div>
		<div class="wrapsection">
			<!-- <div class="container"> -->
			<div class="parallax-content">
				<div class="row wow fadeInLeft">
					<div class="col-md-3">
						<div class="funfacts text-center">
							<div class="icon">
								<a href="https://twitter.com/siwoo1620"><i
									class="fa fa-twitter"></i></a>
							</div>
							<h4>Twitter</h4>
						</div>
					</div>
					<div class="col-md-3">
						<div class="funfacts text-center">
							<div class="icon">
								<a href="https://www.facebook.com/siwoo1620?ref=bookmarks"><i
									class="fa fa-facebook"></i></a>
							</div>
							<h4>Facebook</h4>
						</div>
					</div>
					<div class="col-md-3">
						<div class="funfacts text-center">
							<div class="icon">
								<a href="https://www.instagram.com/siwoo1620"><i
									class="fa fa-instagram"></i></a>
							</div>
							<h4>Instagram</h4>
						</div>
					</div>
					<div class="col-md-3">
						<div class="funfacts text-center">
							<div class="icon">
								<a href="http://blog.naver.com/bogus1620"><i
									class="fa fa-bold"></i></a>
							</div>
							<h4>Naver Blog</h4>
						</div>
					</div>
				</div>
				<br>
				<div class="col-md-12 text-center">
					<h1 class="bottombrand wow flipInX">Siwoo n Japan</h1>
					<p>&copy; 2017 Bootstrap HTML Template by devTemplate.xyz</p>
				</div>
			</div>
		</div>
		<!-- </div> -->
	</section>

	<script src="${root}/resources/js/jquery-3.2.1.min.js"></script>
	<script src="${root}/resources/js/bootstrap.min.js"></script>
	<script src="${root}/resources/js/parallax.js"></script>
	<script src="${root}/resources/js/contact.js"></script>
	<script src="${root}/resources/js/jquery.easing.min.js"></script>
	<script src="${root}/resources/js/wow.min.js"></script>
	<script src="${root}/resources/js/common.js"></script>

	<script type="text/javascript">
		var result = '${msg}';
		if (result == 'SUCCESS') {
			$('.done').fadeIn('slow');
			$('#focus').focus();
		}

		$(function() {
			$("#Menu").click(function() {
				$('#menu').modal();
			})
			$("#chat").click(function() {
				$('#modal-chat').modal({
					remote : '/chat/form'
				});
			});
		});
	</script>

	<!-- jQuery -->

</body>
</html>