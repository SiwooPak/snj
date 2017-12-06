<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@7.0.6/dist/sweetalert2.min.css" rel="stylesheet"
	type="text/css" />	
<script src="${root}/resources/js/jquery-3.2.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.0.6/dist/sweetalert2.min.js"></script>

</head>
<body>
	<script type="text/javascript">
		function failed() {
			swal({
				  type: 'error',
				  title: '아이디 혹은 비밀번호가 맞지 않습니다.',
				  showConfirmButton: false,
				  timer: 1500
				})
			setTimeout(function() {
				window.location.href = "${root}/user/login";}, 1500);	
		}
	</script>
		<c:if test="${empty vo}">
			<script>
				failed();
			</script>
		</c:if>

</body>
</html>