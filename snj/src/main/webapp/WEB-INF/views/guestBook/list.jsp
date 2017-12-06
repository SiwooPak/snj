<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%@include file="../template/header.jsp"%>

<link rel="stylesheet" href="${root}/resources/css/bootstrap.min.css">
<!-- Main content -->
<section class="content bg-dark">
	<div class="row">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-16 text-center" style="margin-top: 30px;">
					<h1 class="section-heading bottombrand wow flipInX">GuestBook
					</h1>
				</div>
			</div>
		</div>

		<div class="container-fluid">
			<div class="row">
				<div class="col-md-12">
					<ul class="tline-holder">
						<li class="tline-item-left wow fadeInLeft">
							<div class="tline-item-content">
								<div class="date-icon fa fa-rocket"></div>
								<div class="tline-item-txt text-left">
									<form action="./create" method="post">
										<label>작성자</label>
										<c:choose>
											<c:when test="${not empty login.u_id}">
												<p>
													<input type="text" name="writer" class="form-control"
														value="${login.uname}" readonly="readonly" />
												</p>
											</c:when>
											<c:when test="${empty login.u_id}">
												<p>
													<input type="text" name="writer" value="" class="form-control"
														placeholder="Enter Name" />
												</p>
											</c:when>
										</c:choose>
										<label>내용</label>
										<textarea class="form-control" rows="4" cols="78"
											name="content" placeholder="Please Leave your Guest Book"></textarea>
										<c:if test="${empty login.u_id}">
											<label>비밀번호</label> 
											<input type="password" name="pass" value=""
												class="form-control" placeholder="Enter Password" />
										</c:if>	
										<button class="btn btn-primary">등록</button>
									</form>
								</div>
							</div>
						</li>
						<!-- 방명록 부모글-->
						<c:forEach var="guest" items="${list}">
							<c:choose>
								<c:when test="${guest.ansnum == 0}">
									<li class="tline-item-left wow fadeInLeft">
										<div class="tline-item-content">
											<div class="date-icon fa fa-rocket"></div>
											<div class="tline-item-txt text-right">
												<div class="meta">
													<p style="text-align: left;">
														NO.&nbsp;
														<c:out value="${guest.gbno }" />
													</p>
													<c:out value="${guest.regdate }" />
												</div>
												<h3>
													<c:out value="${guest.writer }" />
												</h3>
												<pre>${guest.content }</pre>
												<c:if test="${guest.writer eq login.uname}">
													<button type="button" class="btn btn-primary btn-xs"
														id="mode" data-toggle="modal" data-target="#myModal"
														data-gbno="${guest.gbno}" data-writer="${guest.writer}"
														data-content="${guest.content }" data-guest="${guest}">수정
														및 삭제</button>
												</c:if>
												<button type="button" class="btn btn-primary btn-xs"
													id="register" data-toggle="modal" data-target="#myModal3"
													data-gbno="${guest.gbno}" >댓글달기</button>	
											</div>
										</div>
									</li>
								</c:when>
								<c:when test="${guest.ansnum>0 }">
									<li class="tline-item-right wow fadeInRight">
										<div class="tline-item-content">
											<div class="date-icon fa fa-camera"></div>
											<div class="tline-item-txt text-left">
												<div class="meta">
													<c:if test="${guest.grpno > 0}">
														<c:set var="no" value="${no+1 }" />
														<p style="text-align: left;">
															NO.&nbsp;
															<c:out value="${no}" />
														</p>
													</c:if>
													<c:out value="${guest.regdate }" />
												</div>
												<h3>
													<c:out value="${guest.writer }" />
												</h3>
												<pre>${guest.content}</pre>
												<c:if test="${guest.writer eq login.uname}">
													<button type="button" class="btn btn-primary btn-xs"
														id="mode" data-toggle="modal" data-target="#myModal"
														data-gbno="${guest.gbno}" data-writer="${guest.writer}"
														data-content="${guest.content}" data-guest="${guest}">수정
														및 삭제</button>
												</c:if>
											</div>
										</div>
									</li>
								</c:when>
							</c:choose>
						</c:forEach>
					</ul>
					<c:if test="${pageMaker.next && pageMaker.endPage>0}"></c:if>
					<div class="tline-start">
						<div class="tline-start-content">
							<div class="text-center">
								<ul class="pagination">

									<c:if test="${pageMaker.prev}">
										<li><a
											href="list${pageMaker.makeSearch(pageMaker.startPage - 1) }">&laquo;</a></li>
									</c:if>

									<c:forEach begin="${pageMaker.startPage }"
										end="${pageMaker.endPage }" var="idx">
										<li
											<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
											<a href="list${pageMaker.makeSearch(idx)}">${idx}</a>
										</li>
									</c:forEach>

									<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
										<li><a
											href="list${pageMaker.makeSearch(pageMaker.endPage +1) }">&raquo;</a></li>
									</c:if>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class='tline-start-content'>
				<select name="searchType" style="width: 30%;">
					<option value="n" class="form-control"
						<c:out value="${cri.searchType == null?'selected':''}"/>>
							---</option>
					<option value="c" class="form-control"
						<c:out value="${cri.searchType eq 'c'?'selected':''}"/>>
							내용</option>
					<option value="w" class="form-control"
						<c:out value="${cri.searchType eq 'w'?'selected':''}"/>>
							작성자</option>
					<option value="cw" class="form-control"
						<c:out value="${cri.searchType eq 'cw'?'selected':''}"/>>
							내용 OR 작성자</option>
				</select> <input type="text" name='keyword' id="keywordInput"
					value='${cri.keyword }'>
				<button type="button" id='searchBtn' class="btn-info btn-xs"
					aria-label="Left Align">
					<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
				</button>
			</div>
		</div>
	</div>

	<div class="modal" id="myModal" aria-hidden="true"
		style="display: none; z-index: 1050;">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header" data-guest>
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title">방명록 수정, 삭제.</h4>
				</div>
				<div class="container"></div>
				<div class="modal-body">
					<label>글 번호</label> 
					<input type="text" id="index" name="gbno"
						class="form-control" value="" readonly="readonly" /> 
					<label>작성자</label>
					<input type="text" id="realWriter" value="" readonly="readonly"
						class="form-control" /> 
					<label>내용</label>
					<textarea class="form-control" rows="4" cols="78" name="content1"
						id="content1"></textarea>
					<c:if test="${empty login }">
						<label>비밀번호</label>
						<input type="password" name="pass" id="pass1" class="form-control">
					</c:if>	
				</div>
				<div class="modal-footer">

					<button type="button" class="btn btn-info" id="modify">수정</button>
					<button type="button" class="btn btn-danger" id="delete">삭제</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 답글 달기. -->
	<div class="modal" id="myModal3" aria-hidden="true"
		style="display: none; z-index: 1050;">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title">이 글의 답글 달기</h4>
				</div>
				<div class="container"></div>
				
					<div class="modal-body">
						<input type="hidden" id="index2" name="gbno" class="form-control"
							value="" /> 
						<label>이름</label>
						<c:choose>
							<c:when test="${not empty login.u_id}">
								<p>
									<input type="text" id="writer2" class="form-control"
										value="${login.uname}" readonly="readonly" />
								</p>
							</c:when>
							<c:otherwise>
								<p>
									<input type="text" id="writer2" class="form-control"
										placeholder="Enter Name" />
								</p>
							</c:otherwise>
						</c:choose>
						<label>내용</label>
						<textarea class="form-control" rows="4" cols="78" id="content2"
							placeholder="Please Leave your Guest Book"></textarea>
						<c:if test="${empty login.u_id}">
							<p>
								<label>비밀번호</label> <input type="password" id="pass2"
									class="form-control" placeholder="Enter Password" />
							</p>
						</c:if>
					</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-success" id="comment">댓글
						달기</button>
				</div>
			</div>
		</div>
	</div>
</section>

<script>	
	function goList() {
		self.location = "${root}/guestBooks/";
	}

	$('#myModal').on('show.bs.modal', function(event) { // myModal 윈도우가 오픈할때 아래의 옵션을 적용
		var button = $(event.relatedTarget); // 모달 윈도우를 오픈하는 버튼
		var gbno = button.data('gbno'); // 버튼에서 data-gbno 값을 gbno 변수에 저장
		var writer = button.data('writer');
		var content = button.data('content');
		var modal = $(this);
		modal.find('#realWriter').val(writer);
		modal.find('#content1').val(content);
		modal.find('#index').val(gbno); // 모달위도우에서 #index을 찾아 gbno 값을 치환
	});
	$('#myModal3').on('show.bs.modal', function(event) { // myModal 윈도우가 오픈할때 아래의 옵션을 적용
		var button = $(event.relatedTarget); // 모달 윈도우를 오픈하는 버튼
		var gbno = button.data('gbno'); // 버튼에서 data-gbno 값을 gbno 변수에 저장
		var modal = $(this);
		modal.find('#index2').val(gbno);
	});
	
	$(document).ready(
			function() {
				$('#searchBtn').on(
						"click",
						function(event) {
							self.location = "" + '${pageMaker.makeQuery(1)}'
									+ "&searchType="
									+ $("select option:selected").val()
									+ "&keyword=" + $('#keywordInput').val();
						});

				$("#comment").on("click", function() {
					var gbnoObj = $("#index2");
					var gwriterObj = $("#writer2");
					var gcontentObj = $("#content2");
					var passObj = $("#pass2");

					var gbno = gbnoObj.val();
					var gwriter = gwriterObj.val();
					var gcontent = gcontentObj.val();
					var password = passObj.val();

					$.ajax({
						type : 'post',
						url : './comments/' + gbno,
						headers : {
							"Content-Type" : "application/json",
							"X-HTTP-Method-Override" : "POST"
						},
						data : JSON.stringify({
							gbno : gbno,
							writer : gwriter,
							content : gcontent,
							pass : password
						}),
						dataType : 'text',
						success : function(result) {
							//console.log("result: " + result);
							if (result == 'SUCCESS') {
								swal({
									  title: '답글이 등록되었습니다.', 
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
									goList();}, 1500);
								gwriterObj.val("");
								gcontentObj.val("");
								passObj.val("");
							}
						}
					});
				});
				$("#modify").on("click", function() {
					var gbnoObj = $("#index");
					var gcontentObj = $("#content1");
					var passObj = $("#pass1");
					
					var gbno = gbnoObj.val();
					var gcontent = gcontentObj.val();
					var password = passObj.val();
					
					$.ajax({
						type : 'put',
						url : './comments/' + gbno,
						headers : {
							"Content-Type" : "application/json",
							"X-HTTP-Method-Override" : "PUT"
						},
						data : JSON.stringify({
							gbno : gbno,
							content : gcontent,
							pass : password
						}),
						dataType : 'text',
						success : function(result) {
							console.log("result: " + result);
							if (result == 'SUCCESS') {
								swal({
									  title: '글이 수정되었습니다.', 
									  timer: 1500,
									  onOpen: () => {
									    swal.showLoading()
									  }
									}).then((result) => {
									  if (result.dismiss === 'timer') {
									    console.log('I was closed by the timer')
									  }
									})
								setTimeout(function() {
									goList();}, 1500);
								passObj.val("");
							} else {
								alert("비밀번호가 일치하지 않아 수정에 실패했습니다.");
							}
						}
					});
				});

				$("#delete").on("click", function() {
					var gbnoObj = $("#index");
					var passObj = $("#pass");

					var gbno = gbnoObj.val();
					var password = passObj.val();

					$.ajax({
						type : 'delete',
						url : './comments/' + gbno,
						headers : {
							"Content-Type" : "application/json",
							"X-HTTP-Method-Override" : "DELETE"
						},
						data : JSON.stringify({
							gbno : gbno,
							pass : password
						}),
						dataType : 'text',
						success : function(result) {
							console.log("result: " + result);
							if (result == 'SUCCESS') {
								swal({
									  title: '글이 삭제되었습니다.', 
									  timer: 1500,
									  onOpen: () => {
									    swal.showLoading()
									  }
									}).then((result) => {
									  if (result.dismiss === 'timer') {
									    console.log('I was closed by the timer')
									  }
									})
								setTimeout(function() {
									goList();}, 1500);
							}
						}
					});
				});
			});
</script>
<%@include file="../template/footer.jsp"%>