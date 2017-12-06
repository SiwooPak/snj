<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%@include file="../template/header.jsp"%>

<!-- Main content -->
<section class="content">
	<div class="row">
		<!-- left column -->
		<div class="col-md-12">
			<!-- general form elements -->
			<div class='box'>
				<div class="box-header with-border">
				</div>

				<div class='box-body' style='margin-top:10px;'>
					<select name="searchType">
						<option value="n"
							<c:out value="${cri.searchType == null?'selected':''}"/>>
							---</option>
						<option value="i"
							<c:out value="${cri.searchType eq 'i'?'selected':''}"/>>
							ID</option>
						<option value="n"
							<c:out value="${cri.searchType eq 'n'?'selected':''}"/>>
							NAME</option>	
						<option value="r"
							<c:out value="${cri.searchType eq 'r'?'selected':''}"/>>
							Register Date</option>
						<option value="ir"
							<c:out value="${cri.searchType eq 'ir'?'selected':''}"/>>
							ID OR Register Date</option>
						<option value="in"
							<c:out value="${cri.searchType eq 'in'?'selected':''}"/>>
							ID OR NAME</option>
						<option value="nr"
							<c:out value="${cri.searchType eq 'nr'?'selected':''}"/>>
							Name OR Register Date</option>
						<option value="inr"
							<c:out value="${cri.searchType eq 'inr'?'selected':''}"/>>
							ID or Name OR Register Date</option>				
					</select>
					<input type="text" name='keyword' id="keywordInput" value='${cri.keyword}'>
					<button id='searchBtn'>Search</button> 

				</div>
			</div>


			<div class="box">
				<div class="box-header with-border">
					<h2 class="bottombrand wow flipInX">
						Memeber's List
					</h2>
				</div>
				<div class="box-body">
					<div class="table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>ID</th>
									<th>NAME</th>
									<th>EMAIL</th>
									<th>BIRTH</th>
									<th>REGISTER DATE</th>
									<th>POINT</th>
									<th>GRADE</th>
									<th>etc..</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list}" var="vo">
									<tr>
										<td>${vo.u_id}</td>
										<td>${vo.uname}</td>
										<td>${vo.email}</td>
										<td>${vo.birth}</td>
										<td>
											<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${vo.regdate}" />
										</td>
										<td>${vo.upoint}</td>
										<td>
											<c:choose>
												<c:when test="${vo.grade eq 'N' }">
													준회원
												</c:when>
												<c:when test="${vo.grade eq 'M' }">
													정회원
												</c:when>
												<c:when test="${vo.grade eq 'A' }">
													운영자
												</c:when>
											</c:choose>
										</td>
										<td>
											<button class="btn-info btn-xs" data-toggle="modal" data-target="#modal" data-id="${vo.u_id}">modify</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<!-- /.box-body -->


				<div class="box-footer">

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
				<!-- /.box-footer-->
			</div>
		</div>
		<!--/.col (left) -->
	</div>
	<!-- /.row -->
	
	<!-- Modal -->
	<div id="modal" class="modal fade" role="dialog" tabindex="-1">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"></h4>
				</div>
				<div class="modal-body">
					<input type="hidden" name="u_id" value="" id="u_id">
					<p><b id="user_Id"></b>님의 등급 혹은 추방하시겠습니까?</p>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" id="upBtn">Grade Up</button>
					<button type="button" class="btn btn-danger" id="byeBtn">Bye</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- /.content -->


<script>
	function goList() {
		self.location = "${root}/user/list";
	}
	$('#modal').on('show.bs.modal', function (e) { // myModal 윈도우가 오픈할때 아래의 옵션을 적용
		  var button = $(e.relatedTarget); // 모달 윈도우를 오픈하는 버튼
		  var userId = button.data('id'); // 버튼에서 data-id 값을 userId 변수에 저장
		  var modal = $(this);
		  modal.find('#user_Id').text(userId)// 모달 윈도우에서 #user_Id를 찾아 userId 값을 치환
		});
</script>

<script>
	
	$(document).ready(
			function() {
				$('#searchBtn').on("click",function(event) {
					self.location = "list"
					+ '${pageMaker.makeQuery(1)}'
					+ "&searchType="
					+ $("select option:selected").val()
					+ "&keyword=" + $('#keywordInput').val()
				});
				$("#upBtn").on("click", function() {
					var u_id = $("#user_Id").text();

					$.ajax({
						type : 'put',
						url : '/user/'+u_id,
						headers : {
							"Content-Type" : "application/json",
							"X-HTTP-Method-Override" : "PUT"
						},
						dataType : 'text',
						success : function(result) {
							//console.log("result: " + result);
							if (result == 'SUCCESS') {
								swal({
									  type: 'success',
									  title: '멤버가 등업되었습니다.',
									  showConfirmButton: false,
									  timer: 1800
									})
								setTimeout(function() {
									goList();}, 1500);
							}
						}
					});
				});
				$("#byeBtn").on("click", function() {
					var u_id = $("#user_Id").text();

					$.ajax({
						type : 'delete',
						url : '/user/' + u_id,
						headers : {
							"Content-Type" : "application/json",
							"X-HTTP-Method-Override" : "DELETE"
						},
						dataType : 'text',
						success : function(result) {
							//console.log("result: " + result);
							if (result == 'SUCCESS') {
								swal({
									  type: 'success',
									  title: '멤버가 추방되었습니다.',
									  showConfirmButton: false,
									  timer: 1800
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