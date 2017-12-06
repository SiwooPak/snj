<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../template/header.jsp"%>


<style>
.fileDrop {
	width: 80%;
	height: 100px;
	border: 1px dotted gray;
	background-color: lightslategrey;
	margin: auto;
}
</style>
<script>
	var categoryCd;
	var imageFolder;
	function fn_setProductCategoryCd() {
		categoryCd = $("#categoryCd").val();
		if (categoryCd == 'H') {
			imageFolder = "${root}/resources/img/horror";
		} else if (categoryCd == 'M') {
			imageFolder = "${root}/resources/img/horror";
		} else if (categoryCd == 'I') {
			imageFolder = "${root}/resources/img/info";
		} else if (categoryCd == 'A') {
			imageFolder = "${root}/resources/img/attraction";
		}
		$("#imageFolder").val(imageFolder);
	}
</script>

<!-- Main content -->
<section class="content">
	<div class="row">
		<!-- left column -->
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">MODIFY BOARD</h3>
				</div>
				<!-- /.box-header -->

				<form role="form" action="modifyPage" method="post">

					<input type='hidden' name='page' value="${cri.page}"> 
					<input type='hidden' name='perPageNum' value="${cri.perPageNum}">
					<input type='hidden' name='searchType' value="${cri.searchType}">
					<input type='hidden' name='keyword' value="${cri.keyword}">
					<input type='hidden' name='category' value="${cri.category}">
					<div class="box-body">

						<!-- 카테고리 -->
						<div class="form-group">
							<label for="exampleInputEmail1">Category</label> 
							<select
								class="form-control" id="productCategoryCd" name="categorycd"
								required onchange="fn_setProductCategoryCd()">
								<option>카테고리를 지정해주세요.</option>
								<c:forEach items="${dsCode1}" var="code1">
									<c:choose>
										<c:when test="${code1.commCd eq cri.category }">
											<option value="${code1.commCd}" selected>${code1.commCdNm}</option>
										</c:when>
										<c:otherwise>
											<option value="${code1.commCd}">${code1.commCdNm}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<input type="hidden" name='bno' class="form-control"
								value="${boardVO.bno}" readonly="readonly">
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Title</label> <input type="text"
								name='title' class="form-control" value="${boardVO.title}">
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Writer</label> <input type="text"
								name="writer" class="form-control" value="${boardVO.writer}"
								readonly="readonly">
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">Content</label>
							<textarea class="form-control" name="content" id="content1">${boardVO.content}</textarea>
						</div>
						<c:choose>
							<c:when test="${cri.category eq 'I'}">
								<div class="form-group">
									<label for="exampleInputEmail1">타이틀 이미지 변경</label>
									<div class="fileDrop"></div>
								</div>
							</c:when>
							<c:when test="${cri.category eq 'N'}">
								<div class="form-group">
									<label for="exampleInputEmail1">파일 변경</label>
									<div class="fileDrop"></div>
								</div>
							</c:when>
						</c:choose>
					</div>
					<!-- /.box-body -->

					<div class="box-footer">
						<div>
							<hr>
						</div>
						<c:choose>
							<c:when test="${cri.category eq 'I'}">
								원본 타이틀 이미지
								<ul class="mailbox-attachments clearfix uploadedList"></ul>
							</c:when>
							<c:when test="${cri.category eq 'N'}">
								원본 파일
								<ul class="mailbox-attachments clearfix uploadedList"></ul>
							</c:when>
						</c:choose>
						<button type="button" class="btn btn-warning pull-right">CANCEL</button>
						<button type="submit" class="btn btn-primary pull-right">SAVE</button>
					</div>
				</form>

<script type="text/javascript" src="/resources/js/upload.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<script id="template" type="text/x-handlebars-template">
<li>
  <span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}"></span>
  <div class="mailbox-attachment-info">
	<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
	<a href="{{fullName}}" 
     class="btn-default btn-xs pull-right delbtn"><i class="fa fa-fw fa-remove"></i></a>
	</span>
  </div>
</li>                
</script>

<script>
	$(document).ready(function() {
		var formObj = $("form[role='form']");
		formObj.submit(function(event) {
			event.preventDefault();
			var that = $(this);
			var str = "";
			$(".uploadedList .delbtn").each(function(index) {
				str += "<input type='hidden' name='files["+ index
				+ "]' value='"+ $(this).attr("href")+ "'> ";
			});

			that.append(str);
			console.log(str);

			that.get(0).submit();
		});

		$(".btn-warning").on("click",function() {
			self.location = "/board/list?page=${cri.page}&perPageNum=${cri.perPageNum}"
							+ "&searchType=${cri.searchType}&keyword=${cri.keyword}&category=${cri.category}";
		});

	});
	var template = Handlebars.compile($("#template").html());
	$(".fileDrop").on("dragenter dragover", function(event) {
						event.preventDefault();
	});
	$(".fileDrop").on("drop", function(event) {
		event.preventDefault();
		var files = event.originalEvent.dataTransfer.files;
		var file = files[0];
		//console.log(file);
		var formData = new FormData();
		formData.append("file", file);

		$.ajax({
			url : '/uploadAjax',
			data : formData,
			dataType : 'text',
			processData : false,
			contentType : false,
			type : 'POST',
			success : function(data) {	
				var fileInfo = getFileInfo(data);
				var html = template(fileInfo);
				$(".uploadedList").append(html);
			}
		});
	});
	
	$(".uploadedList").on("click", ".delbtn", function(event) {
		event.preventDefault();
		var that = $(this);
		
		$.ajax({
			url : "/deleteFile",
			type : "post",
			data : {
				fileName : $(this).attr("href")
				},
				dataType : "text",
				success : function(result) {
					if (result == 'deleted') {
						that.closest("li").remove();
						}
					}
				});
		});
	
	var bno = ${boardVO.bno};
	var template = Handlebars.compile($("#template").html());
	$.getJSON("/board/getAttach/" + bno, function(list) {
		$(list).each(function() {
			var fileInfo = getFileInfo(this);
			var html = template(fileInfo);
			$(".uploadedList").append(html);
			});
		});
	$(".uploadedList").on("click",".mailbox-attachment-info a", function(event) {
		var fileLink = $(this).attr("href");
		if (checkImageType(fileLink)) {
			event.preventDefault();
			var imgTag = $("#popup_img");
			imgTag.attr("src", fileLink);
			//console.log(imgTag.attr("src"));
			
			$(".popup").show('slow');
			imgTag.addClass("show");
			}
		});
	
	$("#popup_img").on("click", function() {
		$(".popup").hide('slow');
		});
</script>
<script type="text/javascript" src="${root}/ckeditor/ckeditor.js"></script>
<script type="text/JavaScript">
	window.onload = function() {
		CKEDITOR.replace('content1', {
			skin : 'moono-dark'
			});
		}
</script>




			</div>
			<!-- /.box -->
		</div>
		<!--/.col (left) -->

	</div>
	<!-- /.row -->
</section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->

<%@include file="../template/footer.jsp"%>