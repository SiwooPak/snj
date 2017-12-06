<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
<%@include file="../template/header.jsp"%>

<style>
.fileDrop {
	width: 100%;
	height: 150px;
	border: 1px dotted gray;
	background-color: lightslategrey;
	margin: auto;
}
</style>

<script>
	var categorycd;
	var imageFolder;
	function fn_setProductCategoryCd() {
		categorycd = $("#categorycd").val();
		if (categorycd == 'H') {
			imageFolder = "${root}/resources/img/horror";
		} else if (categorycd == 'M') {
			imageFolder = "${root}/resources/img/horror";
		} else if (categorycd == 'I') {
			imageFolder = "${root}/resources/img/info";
		} else if (categorycd == 'A') {
			imageFolder = "${root}/resources/img/attraction";
		}
		$("#imageFolder").val(imageFolder);
	}
</script>
<!-- Main content -->
<section class="contact">
	<div class="row">
		<!-- left column -->
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box box-primary">
				<div class="box-header">
					<h4 class="box-title bottombrand">Register
						<c:choose>
							<c:when test="${category eq 'N'}">
								(Notice)
							</c:when>
							<c:when test="${category eq 'H'}">
								(Horror BBS)
							</c:when>
							<c:when test="${category eq 'M'}">
								(Horror Movies)
							</c:when>
							<c:when test="${category eq 'I'}">
								(Japan's Live)
							</c:when>
							<c:when test="${category eq 'A'}">
								(Japan's Attraction)
							</c:when>
						</c:choose>
					</h4>
				</div>
				<!-- /.box-header -->

				<form id='registerForm' role="form" method="post"
					onsubmit="inputCheck(this)">
					<input type="hidden" name="category" value="${category }">
					<div class="box-body">
						<!-- 카테고리 -->
						<div class="form-group">
							<label for="exampleInputEmail1">Category</label>
							<select
								class="form-control" id="productCategoryCd" name="categorycd"
								required onchange="fn_setProductCategoryCd()" readonly="readonly">
								<option>카테고리를 지정해주세요.</option>
								<c:forEach items="${dsCode1}" var="code1">
									<c:choose>
										<c:when test="${code1.commCd eq category }">
											<option value="${code1.commCd}"  selected>${code1.commCdNm}</option>
										</c:when>
										<c:otherwise>
											<option value="${code1.commCd}">${code1.commCdNm}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</div>
						<!-- 제목 -->
						<div class="form-group">
							<label for="exampleInputEmail1">Title</label> <input type="text"
								name='title' class="form-control" placeholder="Enter Title"
								required>
						</div>
						<!-- 이름 -->
						<div class="form-group">
							<label for="exampleInputEmail1">Writer</label> <input type="text"
								name="writer" class="form-control" value="${login.uname}"
								readonly>
						</div>
						<!-- 내용 -->

						<div class="form-group">
							<label for="exampleInputPassword1">Content</label>
							<textarea class="form-control" name="content" id="content1"
								rows='10' cols='60' placeholder="Enter ..." required>
							</textarea>
						</div>

						<!-- 파일 드래그& 드롭 -->
						<c:choose>
							<c:when test="${category eq 'I'}">
								<div class="form-group">
									<label for="exampleInputEmail1">Title Image(Drag & Drop)</label>
									<div class="fileDrop"></div>
								</div>
							</c:when>
							<c:when test="${category eq 'N'}">
								<div class="form-group">
									<label for="exampleInputEmail1">File(Drag & Drop)</label>
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
							<ul class="mailbox-attachments clearfix uploadedList">
						</ul>

						<button type="button" class="btn btn-warning pull-right">CANCEL</button>
						<button type="submit" class="btn btn-primary pull-right">Submit</button>
					</div>
				</form>


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

<script type="text/javascript" src="${root}/resources/js/upload.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<script id="template" type="text/x-handlebars-template">
<li>
  <span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
  <div class="mailbox-attachment-info">
	<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
	<a href="{{fullName}}" 
     class="btn-default btn-xs pull-right delbtn"><i class="fa fa-fw fa-remove"></i></a>
	</span>
  </div>
</li>                
</script>

<script>
	var template = Handlebars.compile($("#template").html());
	$(".fileDrop").on("dragenter dragover", function(event) {
		event.preventDefault();
	});
	$(".fileDrop").on("drop", function(event) {
		event.preventDefault();

		var files = event.originalEvent.dataTransfer.files;

		var file = files[0];
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
	$("#registerForm").submit(
			function(event) {
				//event.preventDefault();

				var that = $(this);

				var str = "";
				$(".uploadedList .delbtn").each(
						function(index) {
							str += "<input type='hidden' name='files[" + index
									+ "]' value='" + $(this).attr("href")
									+ "'> ";
						});

				that.append(str);
				that.get(0).submit();
			});
	$(".btn-warning").on("click", function() {
		self.location = "/board/list?category=${category}";
	});
</script>
<script type="text/javascript" src="${root}/ckeditor/ckeditor.js"></script>
<script type="text/JavaScript">
	window.onload = function() {
		CKEDITOR.replace('content1',{
			skin: 'moono-dark'
		});
	}
</script>
<%@include file="../template/footer.jsp"%>