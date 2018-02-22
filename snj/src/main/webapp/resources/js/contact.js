//////CONTACT FORM VALIDATION
jQuery(document).ready(function ($) {
	
	//submit 버튼 클릭시
	$('#mail').submit(function(event) {		
		//이벤트 초기화
		var $form = $(this);
		var $button = $form.find('button');
		
		//form 안의 데이터들 가져오기.
		var name = $('input[name=name]');
		var email = $('input[name=email]');
		var regx = /^([a-z0-9_\-\.])+\@([a-z0-9_\-\.])+\.([a-z]{2,4})$/i;
		var comment = $('textarea[name=comment]');
		var returnError = false;
		
		//값 검증 부분
		if (name.val()=='') {
			name.addClass('error');
			returnError = true;
		} else name.removeClass('error');
		
		if (email.val()=='') {
			email.addClass('error');
			returnError = true;
		} else email.removeClass('error');		
		
		if(!regx.test(email.val())){
          email.addClass('error');
          returnError = true;
		} else email.removeClass('error');
		
		
		if (comment.val()=='') {
			comment.addClass('error');
			returnError = true;
		} else comment.removeClass('error');
		
		// 필드값들이 모든 에러가 날 시 빠져나옴.
		if(returnError == true){
			return false;	
		}
		
		//데이터 정리
		
		var data = 'name=' + name.val() + '&email=' + email.val() + '&comment='  + encodeURIComponent(comment.val());

		//모든 텍스트 필드 비활성화
		$('.text').attr('disabled','true');
		
		$('.loading').show();
		
		//ajax 부분
		$.ajax({
			//url, type, data 값들은 home.jsp의 mail세션 부분에 구현. 
			url: $form.attr('action'),	
			type: $form.attr('method'),		
			data: $form.serialize() + '&delay=1',		
			//메일 보내기 전 submit 버튼 활성화.
			beforeSend: function(xhr,settings){
				//Button Disabled
				$button.attr('disabled',true);
			},
			//메일 보낸 후, submit 버튼 비활성화.
			complete: function(xhr,textStatus) {
				//Button Activing Allow for resend
				$button.attr('disabled', false);
			},
			//성공시 필드값 초기화
			success: function (result) {				
				$form[0].reset();
			},
			error: function(xhr,textStatus, error) {}
		});
		
	});	
});	
