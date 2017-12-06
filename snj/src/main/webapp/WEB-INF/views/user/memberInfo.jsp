<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<c:set var="root" value="${pageContext.request.contextPath }" />

<%@include file="../template/header.jsp"%>

<script type="text/javascript">
	var imageFolder;
	$(function() {
		//fn_init();
		imageFolder = "${root}/resources/img/user/";
		$("#birth").datepicker({
			dateFormat : 'yy-mm-dd',
			changeMonth : true,
			changeYear : true,
			yearRange : "1940:2017"
		});
		fn_setDetailInfo();
	});

	function fn_setDetailInfo() {
		$("#id").val('${user.u_id}');
		$("#pw").val('${user.upw}');
		$("#e_mail").val('${user.email}');
		$("#name").val('${user.uname}');
		$("#birth").val('${user.birth}');
		var phoneArr = '${user.phoneNum}'.split("-");
		var postNum = '${user.postNum}';
		var address1 = '${user.address1}';
		var address2 = '${user.address2}';
		var userImage = '${user.userImage}';
		userImage = userImage.replace(/"/gi, "");
		$("#phone1").val(phoneArr[0]);
		$("#phone2").val(phoneArr[1]);
		$("#phoneCd").val('${user.phoneCd}');
		$("#sample6_postcode").val(postNum);
		$("#sample6_address").val(address1);
		$("#sample6_address2").val(address2);
		$("#pic").attr("src", '${root}/resources/img/user/' + userImage);
		$("#userImg").val(userImage);
		console.log(userImage);
		$("#point").text("${user.upoint} point");
	}

	function mailCheck() {
		var email = $("#e_mail").val();
		var access = $("#message2");
		$.ajax({
			url : "${root}/user/emailCheck?email=" + email,
			success : function(result) {
				result3 = result.replace(/"/gi, "");
				var splResult = result3.split("@");
				access.html(splResult[0]);
				$("#flag1").val(splResult[1]);
			}
		});
	}

	function fn_save() {
		//if(!fn_validation()) return;
		/* 
		if(confirm("수정하시겠습니까?")){
			$("#phoneNum").val($("#phone1").val() + "-" + $("#phone2").val());
			$("#joinFrm").submit();
		}
		 */
		var user_name = '${user.uname}';
		swal({
			text : user_name + " 님의 정보를 수정하시겠습니까?",
			type : "info",
			showCancelButton : true,
			cancelButtonText : "취소",
			confirmButtonText : "수정",
			animation : false
		}).then((result) => {
				$("#phoneNum").val($("#phone1").val() + "-" + $("#phone2").val());
				$("#joinFrm").submit();
				swal({
					type : 'success',
					title : user_name + ' 님의 정보가 수정되었습니다.',
					showConfirmButton : false,
				})
			})
	}

	function fn_upload() {
		$("#ajaxform").ajaxSubmit({
			type : "POST",
			dataType : 'text',
			url : $("#ajaxform").attr("action"),
			data : $("#ajaxform").serialize(),
			success : function(data) {
				data2 = data.replace(/"/gi, "");
				var imageUrl = "${root}/resources/img/user/" + data2;
				//console.log(data2);
				//console.log(imageUrl);
				$("#pic").attr("src", imageUrl);
				$("#userImg").val(data2);
			},
			error : function(xhr, status, error) {
				swal("사진 업로드에 실패했습니다.");
			}
		});
	}
</script>


<!-- daum zipcode api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var fullAddr = ''; // 최종 주소 변수
						var extraAddr = ''; // 조합형 주소 변수
						// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							fullAddr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							fullAddr = data.jibunAddress;
						}
						// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
						if (data.userSelectedType === 'R') {
							//법정동명이 있을 경우 추가한다.
							if (data.bname !== '') {
								extraAddr += data.bname;
							}
							// 건물명이 있을 경우 추가한다.
							if (data.buildingName !== '') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
							fullAddr += (extraAddr !== '' ? ' (' + extraAddr
									+ ')' : '');
						}
						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
						document.getElementById('sample6_address').value = fullAddr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById('sample6_address2').focus();
					}
				}).open();
	}
</script>
<!-- content start -->
<div id="jumbotron" class="container-fluid">
	<div class="jumbotron jumbotron-info"
		style="background: url(${root}/resources/img/demo/index04.jpg); background-size: cover;">
		<h1 class="bottombrand wow flipInX"
			style="font-family: Mrs Sheppards;">
			회원정보 및 수정&nbsp;<span class="glyphicon glyphicon glyphicon-pencil"></span>
		</h1>
	</div>
</div>
<div class="container">
	<form id="joinFrm" method="post" action="./updateUser" role="form">
		<div class="form-horizontal">
			<hr />
			<div class="form-group" style="margin-top: 5%;">
				<label for="id" class="control-label col-md-2"><b>아이디</b></label>
				<div class="col-md-4">
					<input class="form-control" type="text" name="u_id" id="id"
						readonly="readonly" autofocus="autofocus" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-md-2"><b>포인트</b></label>
				<div class="col-md-4">
					<div id="point"></div>
				</div>
			</div>
			<div class="form-group">
				<label for="pw" class="control-label col-md-2"><b>비밀번호</b></label>
				<div class="col-md-4">
					<input class="form-control" type="password" name="upw" id="pw"
						required="required" />
				</div>
			</div>

			<div class="form-group">
				<label for="email" class="control-label col-md-2"><b>이메일</b></label>
				<div class="col-md-4">
					<input class="form-control" type="text" name="email" id="e_mail"
						required="required" autofocus="autofocus" onkeyup="mailCheck();" />
				</div>
				<p id="message2"></p>
			</div>
			<div class="form-group">
				<label for="name" class="control-label col-md-2"><b>성명</b></label>
				<div class="col-md-6">
					<input class="form-control" type="text" id="name" name="uname"
						autofocus="autofocus" readonly="readonly" />
				</div>
			</div>

			<div class="form-group">
				<label for="birth" class="control-label col-md-2"><b>생년월일</b></label>
				<div class="col-md-6">
					<input class="form-control" type="text" id="birth" name="birth"
						required="required" maxlength="10" />
				</div>
			</div>

			<div class="form-group">
				<label for="phoneCd" class="control-label col-md-2"><b>연락처</b></label>
				<div class="col-md-2">
					<select class="form-control" id="phoneCd" name="phoneCd"
						required="required">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
						<option value="018">018</option>
						<option value="019">019</option>
					</select>
				</div>
				<div class="col-md-2">
					<input class="form-control" type="text" id="phone1" maxlength="4"
						required="required" />
				</div>
				<div class="col-md-2">
					<input class="form-control" type="text" id="phone2" maxlength="4"
						required="required" />
				</div>
				<input type="hidden" id="phoneNum" name="phoneNum">
			</div>

			<div class="form-group">
				<label for="postnum1" class="control-label col-md-2"><b>주소</b></label>
				<div class="col-md-2">
					<input class="form-control" type="text" id="sample6_postcode"
						required="required" name="postNum" readonly maxlength="5" />
				</div>
				<span class="col-md-2">
					<button type="button" class="btn-sm btn-info" data-toggle="modal"
						data-target="#searchPost" onclick="sample6_execDaumPostcode()">주소검색
					</button>
				</span>
			</div>

			<div class="form-group">
				<label for="address1" class="control-label col-md-2"><b>상세주소</b></label>
				<div class="col-md-6">
					<input class="form-control" type="text" id="sample6_address"
						name="address1" required="required" readonly />
				</div>
			</div>

			<div class="form-group">
				<label for="address2" class="control-label col-md-2"></label>
				<div class="col-md-6">
					<input class="form-control" type="text" id="sample6_address2"
						name="address2" />
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-md-2"><b>사진</b></label> <img
					id="pic" style="margin-left: 15px;" height="180px" width="150px"
					src="${root}/resources/img/user/default.png"><br />
				<div class="col-md-6">
					<input type="hidden" id="userImg" name="userImage"
						required="required" value="123">

				</div>
			</div>

			<input type="hidden" id="flag" name="flag" value="false"> <input
				type="hidden" id="flag1" name="flag1" value="false">
		</div>
	</form>
	<form id="ajaxform" action="${root}/user/saveFile" method="post"
		enctype="multipart/form-data" role="form">
		<div class="form-group">
			<label class="control-label col-md-2"></label>
			<div class="col-md-6">
				<input class="form-control" type="file" id="imageFile"
					name="imageFile" onchange="fn_upload()" /> <input type="hidden"
					id="imageFolder" name="imageFolder" value="resources/img/user/">
				<p style="float: left;">한글 파일명은 업로드 할수 없습니다.</p>
			</div>
		</div>
		<br> <br> <br>
		<div class="modal-footer">
			<button class="btn btn-primary" type="button" name="btnSubmit"
				id="btnSubmit" onclick="fn_save()">수정</button>
			<button type="button" class="btn btn-success"
				onclick="history.go(-1)">뒤로가기</button>
		</div>
	</form>
</div>
<!-- content end -->
<%@include file="../template/footer.jsp"%>
