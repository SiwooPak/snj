<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/sweetalert2@7.0.6/dist/sweetalert2.min.css"
	rel="stylesheet" type="text/css" />
<script src="${root}/resources/js/jquery-3.2.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@7.0.6/dist/sweetalert2.min.js"></script>

</head>
<body>
	<script type="text/javascript">
		function members() {
			swal({
				  title: '회원목록 페이지로 이동합니다.', 
				  timer: 1500,
				  onOpen: () => {
				    swal.showLoading(); 
				  }
				}).then((result) => {
				  if (result.dismiss === 'timer') {
				    console.log('I was closed by the timer')
				  }
				})
			setTimeout(function() {
				window.location.href = "${root}/user/list";}, 1500);	
		}
		
		function memberInfo() {
			swal({
				title: '회원정보 페이지로 이동합니다.', 
				  timer: 1500,
				  onOpen: () => {
				    swal.showLoading(); 
				  }
				}).then((result) => {
				  if (result.dismiss === 'timer') {
				    console.log('I was closed by the timer')
				  }
				})
			setTimeout(function() {
				window.location.href = "${root}/user/updateUser";}, 1500);	
		}
		function passFiled() {
			swal({
				  type: 'error',
				  title: '비밀번호가 맞지 않습니다.',
				  showConfirmButton: false,
				  timer: 3000
				})
			setTimeout(function() {
				window.location.href = "${root}/user/passChk";}, 3000);		
		}
	</script>
	<c:choose>
		<c:when test="${grade eq 'A'}">
			<script>
				members();
			</script>
		</c:when>
		<c:when test="${grade eq 'N' || grade eq 'M' }">
			<script>
				memberInfo();
			</script>
		</c:when>
		<c:otherwise>
			<script>
				passFiled();
			</script>
		</c:otherwise>
	</c:choose>
</body>
</html>