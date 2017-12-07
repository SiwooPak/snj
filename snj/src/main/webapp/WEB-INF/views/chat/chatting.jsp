<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>SNJ Chatting</title>
<link rel="stylesheet"
	href="<c:url value='/resources/css/bootstrap.min.css'/>"
	type="text/css">
<link
	href="https://cdn.jsdelivr.net/npm/sweetalert2@7.0.6/dist/sweetalert2.min.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="<c:url value='/resources/js/jquery-3.2.1.min.js'/>"></script>
<script type="text/javascript"
	src='https://cdn.jsdelivr.net/npm/sweetalert2@7.0.6/dist/sweetalert2.min.js'></script>
<script type="text/javascript">
	/* $('#inputs').hide(); */
	function connect() {
		var ws = new WebSocket("ws://localhost:8070/chat-ws");
		ws.onopen = function() {
			$('#chatStatus').text('채팅서버에 연결중!');

			$('input[name=chatInput]').on('keydown', function(evt) {
				if (evt.keyCode == 13) {
					var userList = [];
					$('.receiver').each(function(idx) {
						userList[idx] = $(this).val();
					});

					var msg = $('input[name=chatInput]').val();
					var obj = {};
					obj.receiver = userList;
					obj.msg = msg;
					var str = JSON.stringify(obj);

					ws.send(str);
					$('input[name=chatInput]').val('');
				}
			});
			swal({
				type : 'success',
				title : '채팅 서버에 연결되었습니다.',
				showConfirmButton : false,
				timer : 1800
			})
		};
		ws.onmessage = function(event) {
			var obj = eval('(' + event.data + ')');
			if ('userList' in obj) {
				chatList(obj.userList);
			} else {
				$('#chatting').eq(0).prepend(obj.msg + '\n');
			}
		};
		ws.onclose = function(event) {
			$('#chatStatus').text('Info: connection closed.');
		};
	};

	function chatList(userList) {
		$('#userList').empty();
		for (var i = 0; i < userList.length; i++) {
			var cb = $("<input type='hidden' class='receiver' value='"+userList[i]+"' >");
			$('#userList').append(cb).append('<br>');
		}
	}
</script>
</head>
<body>
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal">×</button>
		<h3 class="smaller lighter blue no-margin modal-title">SNJ
			Chatting</h3>
	</div>

	<div class="modal-body">
		<div id='chatStatus'></div>
		<textarea id="chatting" name="chatMsg" rows="5" cols="40"></textarea>
		<br>
		<div id="inputs">
			<c:out value="${login.uname}" />
			:<input class="form-class" type="text" name="chatInput">
		</div>
		<div id="userList"></div>
	</div>

	<div class="modal-footer">
		<button class="btn btn-success btn-sm pull-right" onclick="connect();">서버
			접속</button>
	</div>

</body>
</html>