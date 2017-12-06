<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../template/header.jsp"%>

<!-- Main content -->
<style type="text/css">
.popup {
	position: absolute;
}

.back {
	background-color: gray;
	opacity: 0.5;
	width: 100%;
	height: 300%;
	overflow: hidden;
	z-index: 1101;
}

.front {
	z-index: 1110;
	opacity: 1;
	boarder: 1px;
	margin: auto;
}

.show {
	position: relative;
	max-width: 1200px;
	max-height: 800px;
	overflow: auto;
}
</style>
<div class='popup back' style="display: none;"></div>
<div id="popup_front" class='popup front' style="display: none;">
	<img id="popup_img">
</div>

<section class="content">
	<div class="row">
		<!-- left column -->
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box box-primary">
				<div class="box-header" style="margin-top:40px;">
					<h2 class="bottombrand wow flipInX">
					<c:choose>
						<c:when test="${cri.category eq 'N'}">
							공지사항
						</c:when>
						<c:when test="${cri.category eq 'H'}">
							공포게시판(일반)
						</c:when>
						<c:when test="${cri.category eq 'M'}">
							공포게시판(영상)
						</c:when>
						<c:when test="${cri.category eq 'I'}">
							생생 일본통
						</c:when>
						<c:when test="${cri.category eq 'A'}">
							일본의 명소
						</c:when>
					</c:choose>
					</h2>
				</div>
				<!-- /.box-header -->

				<form role="form" action="modifyPage" method="post">
					<input type='hidden' name='writer' value="${boardVO.writer}">
					<input type='hidden' name='bno' value="${boardVO.bno}"> 
					<input type='hidden' name='page' value="${cri.page}"> 
					<input type='hidden' name='perPageNum' value="${cri.perPageNum}">
					<input type='hidden' name='searchType' value="${cri.searchType}">
					<input type='hidden' name='keyword' value="${cri.keyword}">
					<input type='hidden' name='category' value="${cri.category}">
				</form>

				<div class="box-body" style="background:black;">
					<div class="form-group">
						<label for="exampleInputEmail1">제목</label> 
						<input type="text" name='title' class="form-control" value="${boardVO.title}"
							readonly="readonly" style="width: '50%';"> 
						<label for="exampleInputEmail1">작성자</label> 
						<input type="text" name="writer" class="form-control" value="${boardVO.writer}"
							readonly="readonly" />
					</div>

					<div class="form-group">
						<label for="exampleInputPassword1">내용</label>
						<pre
							style="overflow-y: auto; width: 100%; height: 550px; padding: 10px; white-space: pre-wrap;">${boardVO.content}</pre>
					</div>

				</div>
				<!-- /.box-body -->
				<c:if test="${cri.category eq 'N'}">
					<ul class="mailbox-attachments clearfix uploadedList"></ul>
				</c:if>
				<div class="box-footer">
					<c:if test="${boardVO.writer == login.uname}">
						<button type="submit" class="btn btn-warning" id="modifyBtn">수정</button>
						<button type="submit" class="btn btn-danger" id="removeBtn">삭제</button>
					</c:if>
					<button type="submit" class="btn btn-primary" id="goListBtn">목록</button>
				</div>



			</div>
			<!-- /.box -->
		</div>
		<!--/.col (left) -->

	</div>
	<!-- /.row -->



	<div class="row">
		<div class="col-md-12">

			<div class="box box-success">
				<div class="box-header">
					<h3 class="box-title">댓글달기</h3>
				</div>
				<c:if test="${not empty login}">
					<div class="box-body">
						<label for="exampleInputEmail1">작성자</label> <input
							class="form-control" type="text" placeholder="USER ID"
							id="newReplyWriter" value="${login.uname}" readonly="readonly">
						<label for="exampleInputEmail1">댓글 내용</label> <input
							class="form-control" type="text" placeholder="REPLY TEXT"
							id="newReplyText">
					</div>
					<!-- /.box-body -->
					<div class="box-footer">
						<button type="button" class="btn btn-primary" id="replyAddBtn">댓글 추가</button>
					</div>
				</c:if>
				<c:if test="${empty login}">
					<div class="box-body">
						<div>
							<a href="javascript:goLogin();">로그인 해 주세요.</a>
						</div>
					</div>
				</c:if>
			</div>


			<!-- The time line -->
			<ul class="timeline">
				<!-- timeline time label -->
				<li class="time-label" id="repliesDiv"><span class="bg-green">
						댓글 목록 <small id='replycntSmall'> [
							${boardVO.replycnt} ] </small>

				</span></li>
			</ul>

			<div class='text-center'>
				<ul id="pagination" class="pagination pagination-sm no-margin ">

				</ul>
			</div>

		</div>
		<!-- /.col -->
	</div>
	<!-- /.row -->



	<!-- Modal -->
	<div id="modifyModal" class="modal fade" role="dialog" tabindex="-1">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"></h4>
				</div>
				<div class="modal-body" data-rno>
					<p>
						<input type="text" id="replytext" class="form-control">
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-info" id="replyModBtn">댓글 수정</button>
					<button type="button" class="btn btn-danger" id="replyDelBtn">댓글 삭제</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>


</section>
<!-- /.content -->

<script id="templateAttach" type="text/x-handlebars-template">
<li data-src='{{fullName}}'>
  <span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
  <div class="mailbox-attachment-info">
	<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
	</span>
  </div>
</li>                
</script>


<script id="template" type="text/x-handlebars-template">
{{#each .}}
<li class="replyLi" data-rno={{rno}}>
<i class="fa fa-comments bg-blue"></i>
 <div class="timeline-item" >
  <span class="time">
    <i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
  </span>
  <h3 class="timeline-header"><strong>{{rno}}</strong>. {{rwriter}}</h3>
  <div class="timeline-body">{{rcontent}} </div>
    <div class="timeline-footer">
	{{#eqReplyer rwriter}}
     <a class="btn btn-primary btn-xs" 
	    data-toggle="modal" href="#modifyModal">댓글 수정/삭제</a>
	{{/eqReplyer}}
    </div>
  </div>			
</li>
{{/each}}
</script>

<script>
	Handlebars.registerHelper("eqReplyer", function(rwriter, block) {
		var accum = '';
		if (rwriter == '${login.uname}') {
			accum += block.fn();
		}
		return accum;
	});

	Handlebars.registerHelper("prettifyDate", function(timeValue) {
		var dateObj = new Date(timeValue);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth() + 1;
		var date = dateObj.getDate();
		return year + "/" + month + "/" + date;
	});
	var printData = function(replyArr, target, templateObject) {
		var template = Handlebars.compile(templateObject.html());
		var html = template(replyArr);
		$(".replyLi").remove();
		target.after(html);
	}
	var bno = ${boardVO.bno};
	var replyPage = 1;
	function getPage(pageInfo) {

		$.getJSON(pageInfo, function(data) {
			printData(data.list, $("#repliesDiv"), $('#template'));
			printPaging(data.pageMaker, $(".pagination"));

			$("#modifyModal").modal('hide');
			$("#replycntSmall").html("[ " + data.pageMaker.totalCount + " ]");

		});
	}
	var printPaging = function(pageMaker, target) {
		var str = "";
		if (pageMaker.prev) {
			str += "<li><a href='" + (pageMaker.startPage - 1)
					+ "'> << </a></li>";
		}
		for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
			var strClass = pageMaker.cri.page == i ? 'class=active' : '';
			str += "<li "+strClass+"><a href='"+i+"'>" + i + "</a></li>";
		}
		if (pageMaker.next) {
			str += "<li><a href='" + (pageMaker.endPage + 1)
					+ "'> >> </a></li>";
		}
		target.html(str);
	};
	$("#repliesDiv").on("click", function() {
		if ($(".timeline li").length > 1) {
			return;
		}
		getPage("/reply/" + bno + "/1");
	});

	$(".pagination").on("click", "li a", function(event) {

		event.preventDefault();

		replyPage = $(this).attr("href");

		getPage("/reply/" + bno + "/" + replyPage);

	});

	$("#replyAddBtn").on("click", function() {

		var replyerObj = $("#newReplyWriter");
		var replytextObj = $("#newReplyText");
		var rwriter = replyerObj.val();
		var rcontent = replytextObj.val();

		$.ajax({
			type : 'post',
			url : '/reply/',
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : 'text',
			data : JSON.stringify({
				bno : bno,
				rwriter : rwriter,
				rcontent : rcontent
			}),
			success : function(result) {
				console.log("result: " + result);
				if (result == 'SUCCESS') {
					swal({
						  type: 'success',
						  title: '댓글이 등록되었습니다.',
						  showConfirmButton: false,
						  timer: 1800
						})
					replyPage = 1;
					getPage("/reply/" + bno + "/" + replyPage);
					replyerObj.val("");
					replytextObj.val("");
				}
			}
		});
	});
	$(".timeline").on("click", ".replyLi", function(event) {

		var reply = $(this);

		$("#replytext").val(reply.find('.timeline-body').text());
		$(".modal-title").html(reply.find('.timeline-header').text());

	});

	$("#replyModBtn").on("click", function() {

		var rno = $(".modal-title").html();
		var replytext = $("#replytext").val();

		$.ajax({
			type : 'put',
			url : '/reply/' + rno,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "PUT"
			},
			data : JSON.stringify({
				rcontent : replytext
			}),
			dataType : 'text',
			success : function(result) {
				console.log("result: " + result);
				if (result == 'SUCCESS') {
					swal({
						  type: 'success',
						  title: '댓글이 수정되었습니다.',
						  showConfirmButton: false,
						  timer: 1800
						})
					getPage("/reply/" + bno + "/" + replyPage);
				}
			}
		});
	});
	$("#replyDelBtn").on("click", function() {

		var rno = $(".modal-title").html();
		var replytext = $("#replytext").val();

		$.ajax({
			type : 'delete',
			url : '/reply/' + rno,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "DELETE"
			},
			dataType : 'text',
			success : function(result) {
				console.log("result: " + result);
				if (result == 'SUCCESS') {
					swal({
						  type: 'success',
						  title: '댓글이 삭제되었습니다.',
						  showConfirmButton: false,
						  timer: 1800
						})
					getPage("/reply/" + bno + "/" + replyPage);
				}
			}
		});
	});
</script>


<script>
	$(document).ready(
			function() {
				var formObj = $("form[role='form']");
				console.log(formObj);

				$("#modifyBtn").on("click", function() {
					formObj.attr("action", "/board/modifyPage");
					formObj.attr("method", "get");
					formObj.submit();
				});

				$("#removeBtn").on("click", function() {
					var replyCnt = ${boardVO.replycnt};
					if (replyCnt > 0) {
						swal("댓글이 달린 게시물을 삭제할 수 없습니다.");
						return;
					}

					var arr = [];
					$(".uploadedList li").each(function(index) {
						arr.push($(this).attr("data-src"));
					});

					if (arr.length > 0) {
						$.post("/deleteAllFiles", {
							files : arr
						}, function() {

						});
					}
					formObj.attr("action", "/board/removePage");
					formObj.submit();
				});

				$("#goListBtn ").on("click", function() {
					formObj.attr("method", "get");
					formObj.attr("action", "/board/list");
					formObj.submit();
				});

				var bno = ${boardVO.bno};
				var template = Handlebars.compile($("#templateAttach").html());

				$.getJSON("/board/getAttach/" + bno, function(list) {
					$(list).each(function() {

						var fileInfo = getFileInfo(this);

						var html = template(fileInfo);

						$(".uploadedList").append(html);

					});
				});

				$(".uploadedList").on("click", ".mailbox-attachment-info a",
						function(event) {

							var fileLink = $(this).attr("href");

							if (checkImageType(fileLink)) {

								event.preventDefault();

								var imgTag = $("#popup_img");
								imgTag.attr("src", fileLink);

								console.log(imgTag.attr("src"));

								$(".popup").show('slow');
								imgTag.addClass("show");
							}
						});

				$("#popup_img").on("click", function() {

					$(".popup").hide('slow');

				});

			});

	function goLogin() {
		self.location = "/user/login";
	}
</script>



<%@include file="../template/footer.jsp"%>