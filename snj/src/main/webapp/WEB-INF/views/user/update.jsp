<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />

<%@include file="../template/header.jsp"%>

<script type="text/javascript">

	$(document).ready(function(){
		fn_init();
		$( "#birth" ).datepicker({
	    	dateFormat: 'yy-mm-dd',
	    	changeMonth: true,
	        changeYear: true,
	        yearRange: "1980:2015"
	    });
		//U페이지 해당
		fn_setDetailInfo();
	});
	function fn_setDetailInfo(){
		$("#id").val('${userVO.id}');
		$("#pw").val('${dsUser.pw}');
		$("#email").val('${dsUser.email}');
		$("#name").val('${dsUser.name}');
		$("#birth").val('${dsUser.birth}');
		var phoneArr = '${dsUser.phoneNum}'.split("-");
		var postNum = '${dsUser.postNum}';
		var address1 = '${dsUser.address1}';
		var address2 = '${dsUser.address2}';
		var userImage = '${dsUser.userImage}';
		userImage = userImage.replace(/"/gi, "");
		$("#phone1").val(phoneArr[0]);
		$("#phone2").val(phoneArr[1]);
		$("#phoneCd").val('${dsUser.phoneCd}');
		$("#postNum").val('${dsUser.postNum}');
		$("#address1").val(address1);
		$("#address2").val(address2); 
		$("#pic").attr("src", '${context}/userImg/' + userImage);
		$("#userImage").val(userImage);
	}
	function fn_save(){
		if(!fn_validation()) return;
		if(confirm("수정하시겠습니까?")){
			$("#phoneNum").val($("#phone1").val() + "-" + $("#phone2").val());
	 		$("#joinFrm").submit();
		}
	}
	function fn_upload(){
		$("#ajaxform").ajaxSubmit({
	        type: "POST",
	        dataType: 'text',
	        url: $("#ajaxform").attr("action"),
	        data: $("#ajaxform").serialize(),
	        success: function (data) {
	        	data2 = data.replace(/"/gi, "");
	        	var imageUrl = "${context}/userImg/" + data2;
	        	$("#pic").attr("src", imageUrl);
	        	$("#userImage").val(data2);
	        },
	        error: function (xhr, status, error) {
	            alert(error);
	        }
	    });
	}
</script>

<!-- daum zipcode api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
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
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
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
</head>
<body>
<!-- content start -->
	<div class="container">
		<div class="jumbotron jumbotron-info" style="background-color: lightgray;">
			<h1><font color="black"><strong>정보수정</strong>&nbsp;<span class="glyphicon glyphicon glyphicon-pencil"></span></font></h1>
		</div>
	</div>
	<div class="container">
	<form id="joinFrm" method="post" action="${context}/user/updateUser" role="form">
		<div class="form-horizontal">
			<hr/>
			<div class="form-group" style="margin-top: 5%;">
				<label for="id" class="control-label col-md-2"><b>아이디</b></label>
				<div class="col-md-4">
					<input class="form-control" type="text" name="id" id="id" required="required" autofocus="autofocus" onkeyup="idCheck();" readonly/>
				</div>
				<p id="message"></p>
			</div>

			<div class="form-group">
				<label for="pw" class="control-label col-md-2"><b>비밀번호</b></label>
				<div class="col-md-4">
					<input class="form-control" type="password" name="pw" id="pw" required="required" readOnly/>
				</div>
			</div>

			<div class="form-group">
				<label for="email" class="control-label col-md-2"><b>이메일</b></label>
				<div class="col-md-4">
					<input class="form-control" type="email" name="email" id="email" required="required"/>
				</div>
			</div>
			<div class="form-group">
				<label for="name" class="control-label col-md-2"><b>성명</b></label>
				<div class="col-md-6">
					<input class="form-control" type="text" id="name" name="name" autofocus="autofocus" required="required"/>
				</div>
			</div>

			<div class="form-group">
				<label for="birth" class="control-label col-md-2"><b>생년월일</b></label>
				<div class="col-md-6">
					<input class="form-control" type="text" id="birth" name="birth" required="required" maxlength="10"/>
				</div>
			</div>

			<div class="form-group">
				<label for="phoneCd" class="control-label col-md-2"><b>연락처</b></label>
				<div class="col-md-2">
		        	<select class="form-control" id="phoneCd" name="phoneCd" required="required">
						<c:forEach items="${dsCode1}" var="code1">
							<option value="${code1.commCd}">${code1.commCdNm}</option>
						</c:forEach>
		     		</select>
	     		</div>
				<div class="col-md-2">
					<input class="form-control" type="text" id="phone1" maxlength="4" required="required" onkeydown="return fn_showKeyCode(event)"/>
				</div>
				<div class="col-md-2">
					<input class="form-control" type="text" id="phone2" maxlength="4" required="required" onkeydown="return fn_showKeyCode(event)"/>
				</div>
				<input type="hidden" id="phoneNum" name="phoneNum">
			</div>

			<div class="form-group">
				<label for="postNum" class="control-label col-md-2"><b>주소</b></label>
				<div class="col-md-2">
					<input class="form-control" type="text" id="sample6_postcode" name="postNum" required="required" readonly/>
	     		</div>
				<span class="col-md-1">
					<button type="button" class="btn btn-info" data-toggle="modal" data-target="#searchPost" onclick="sample6_execDaumPostcode()"><b>주소검색</b></button>
				</span>
			</div>

			<div class="form-group">
				<label for="address1" class="control-label col-md-2"><b>상세주소</b></label>
				<div class="col-md-6">
					<input class="form-control" type="text" id="sample6_address" name="address1" required="required" readonly/>
				</div>
			</div>

			<div class="form-group">
				<label for="address2" class="control-label col-md-2"></label>
				<div class="col-md-6">
					<input class="form-control" type="text" id="sample6_address2" name="address2"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-md-2"><b>사진</b></label>
				<img id="pic" style="margin-left: 15px;" height="180px" width="150px" src="${context}/backgroundImage/defaultpic.png"><br/>
				<div class="col-md-6">
					<input type="hidden" id="userImage" name="userImage" required="required">
				</div>
			</div>
			<input type="hidden" id="flag" name="flag" value="false">
		</div>
	</form>
		<form id="ajaxform" action="${context}/product/saveFile" method="post" enctype="multipart/form-data" role="form">
		<div class="form-group">
		<label class="control-label col-md-2"></label>
			<div class="col-md-6">
				<input class="form-control" type="file" id="imageFile" name="imageFile" onchange="fn_upload()"/>
				<input type="hidden" id="imageFolder" name="imageFolder" value="userImg">
			</div>
		</div>
		<br><br><br>
		<div class="form-group">
			<div class="col-md-offset-6 col-md-1">
				<button type="button" class="btn btn-success" onclick="fn_back()">뒤로가기</button>
			</div>
			<div class="col-md-1">
				<button class="btn btn-primary" type="button" name="btnSubmit" id="btnSubmit" onclick="fn_save()">등록하기</button>
			</div>
		</div>
	</form>
	</div>

</body>
</html>