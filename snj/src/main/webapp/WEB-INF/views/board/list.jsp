<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/functions.tld" %>

<%@include file="../template/header.jsp"%>
	<div class="col-md-4 " style="margin-top:40px;">
		<h2>
			<c:choose>
<!-- 				메인페이지에서 넘겨준 카테고리 값에 따른 게시판 이름 출력.  -->
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
<!-- Main content -->
<section id="contact">
	<div class="row">
		<!-- <div class="clearfix"></div> -->
		<div class="col-md-12 ">
			<div class="box">
				<div class="box-header with-border">
					<h2 class="bottombrand wow flipInX">
						<c:choose>
							<c:when test="${cri.category eq 'N'}">
							Notice
							</c:when>
							<c:when test="${cri.category eq 'H'}">
								Horror BBS
							</c:when>
							<c:when test="${cri.category eq 'M'}">
								Horror BBS(Movie)
							</c:when>
							<c:when test="${cri.category eq 'I'}">
								Japan's Live
							</c:when>
							<c:when test="${cri.category eq 'A'}">
								Japan's Attraction
							</c:when>
						</c:choose>
					</h2>
					<!-- 검색창 부분 -->
					<select name="searchType">
						<option value="n"
							<c:out value="${cri.searchType == null?'selected':''}"/>>
							---</option>
						<option value="t"
							<c:out value="${cri.searchType eq 't'?'selected':''}"/>>
							제목</option>
						<option value="c"
							<c:out value="${cri.searchType eq 'c'?'selected':''}"/>>
							내용</option>
						<option value="w"
							<c:out value="${cri.searchType eq 'w'?'selected':''}"/>>
							작성자</option>
						<option value="tc"
							<c:out value="${cri.searchType eq 'tc'?'selected':''}"/>>
							제목 OR 내용</option>
						<option value="cw"
							<c:out value="${cri.searchType eq 'cw'?'selected':''}"/>>
							내용 OR 작성자</option>
						<option value="tcw"
							<c:out value="${cri.searchType eq 'tcw'?'selected':''}"/>>
							제목 OR 내용 OR 작성자</option>
					</select>
					<!-- 검색시 키워드와 카테고리 정보를 같이 넘겨줌 -->
					<input type="text" name='keyword' id="keywordInput1" value='${cri.keyword}'> 
					<input type="hidden" name='category' id="keywordInput2" value='${cri.category}'>
					<button id='searchBtn' class='btn-info btn-sm'>Search</button> 
					<!-- 공지사항 게시판인 경우, 운영자일때만 new button이 보이고, 그외 게시판인 경우 비회원이 아닌 경우 new 버튼이 보임.-->
					<c:choose>
						<c:when
							test="${not empty login && login.u_id eq 'siwoo' && cri.category == 'N'}">
							<button id='newBtn' class='btn-primary btn-sm'>New Notice</button>
						</c:when>
						<c:when test="${not empty login && cri.category ne 'N' && grade ne 'N'}">
							<button id='newBtn' class='btn-primary btn-sm'>New</button>
						</c:when>
					</c:choose> 
					<!-- 공포 동영상과 일본의 생생정보통 게시판의 경우 썸네일형과 일반 목록형 버튼 -->
					<c:if test="${cri.category eq 'M' || cri.category eq 'I'}">
						<button id='imgBtn' class='btn-default btn-sm pull-right'><i class="glyphicon glyphicon-th" aria-hidden="true" ></i></button>
						<button id='listBtn' class='btn-default btn-sm pull-right'><i class="glyphicon glyphicon-th-list" aria-hidden="true"></i></button>
					</c:if>
				</div>
				<!-- .box-body -->
				<!-- #Thumb List-->
				<div class="box-body" id="image">
					<c:choose> 
					<!-- 공포동영상 게시판인 경우 -->
						<c:when test="${cri.category eq 'M' }">
							<c:forEach items="${list}" var="vo">
								<fmt:formatDate var="date" pattern="yyyy-MM-dd" value="${vo.regdate}" />
								<div class="col-xs-4 bg-primary-img teambox">
									<c:choose> 
										<!-- 신규 글인 경우 -->
										<c:when test="${util:newImg(date) }">
											<div class="team-thumb overlay-image2 view-overlay">	
										</c:when>
										<c:otherwise>
											<div class="team-thumb overlay-image view-overlay">
										</c:otherwise>
									</c:choose>
									
										<a href='/board/readPage${pageMaker.makeSearch(pageMaker.cri.page) }&bno=${vo.bno}'> 
											<!-- 유투브 썸네일 이미지 사용 -->
											<img
												src="https://img.youtube.com/vi/${vo.thumb}/0.jpg"
												class="img-responsive">
								
										<div class="mask team_quote">
											<div class="port-zoom-link">
												<h2>${vo.title}[${vo.replycnt}]</h2>
											</div>
										</div>
										</a>
									<h2>작성자: ${vo.writer}</h2>
									<h2>조회수: ${vo.viewcnt}</h2>
									<p><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
											value="${vo.regdate}" />	
									</p>
									</div>
									<br>
								</div>
							</c:forEach>
						</c:when> 
						<!-- 일본 생생정보통 게시판인 경우 -->
						<c:when test="${cri.category eq 'I' }">
						<div class="box-body">
							<c:forEach items="${liveList}" var="vo">
								<fmt:formatDate var="date" pattern="yyyy-MM-dd" value="${vo.regdate}" />
								<div class="col-xs-2 bg-primary-img teambox">
									<c:choose> 
										<!-- 신규 글인 경우 new 이미지 출력-->
										<c:when test="${util:newImg(date) }">
											<div class="team-thumb overlay-image3 view-overlay">	
										</c:when>
										<c:otherwise>
											<div class="team-thumb overlay-image view-overlay">
										</c:otherwise>
									</c:choose>
											<a href='/board/readPage${pageMaker.makeSearch(pageMaker.cri.page) }&bno=${vo.bno}'>
												<img
													src="http://siwoo1620.cafe24.com/down${vo.fullname}"
													alt="" class="img-responsive">
									
											<div class="mask team_quote">
												<div class="port-zoom-link">
													<h2>
													<c:choose>
											        		<c:when test="${fn:length(vo.content) > 12}">
											            		<c:out value="${fn:substring(vo.content,11,24)}"/>....
											           	</c:when>
											           	<c:otherwise>
											            		<c:out value="${vo.content}"/>
											           	</c:otherwise> 
											        </c:choose>
													[${vo.replycnt}]		        
											        </h2>
												</div>
											</div>
											</a>
											<h5>작성자: ${vo.writer}</h5>
											<h5>조회수: ${vo.viewcnt}</h5>
											<p><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
													value="${vo.regdate}" />
											</p>
										</div>
										<br>
									</div>
								</c:forEach>					
							</div>
						</c:when>
					</c:choose>
				</div> 
				<!-- 그외 게시판인 경우 -->
				<div class="box-body" id="list"> 
					<!-- 일본의 이모저모 게시판인 경우 구글 맵을 보여줌.-->
					<c:if test="${cri.category eq 'A' }">
						<p align="center">
						<iframe 
							src="https://www.google.com/maps/d/embed?mid=1IKvNQQ0nTN3k0jGyW44DfNnI5rI" 
							style="width:50%; height:300px;">
						</iframe>
						</p>
					</c:if>
					<table class="table table-hover">
						<thead>
							<tr>
								<th>No</th>
								<th>TITLE</th>
								<th>WRITER</th>
								<th>REGDATE</th>
								<th>VIEWCNT</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="vo" varStatus="status">
							<fmt:formatDate var="date" pattern="yyyy-MM-dd"
											value="${vo.regdate}" />
								<tr>
									<!-- 게시물 번호 역순처리(총갯수-((현재페이지-1)*페이지당 보여지는 갯수 + 인덱스))  -->
									<td>${pageMaker.totalCount - ((pageMaker.cri.page-1) * pageMaker.cri.perPageNum + status.index) }</td>
									<td><a
										href='/board/readPage${pageMaker.makeSearch(pageMaker.cri.page) }&bno=${vo.bno}'>
											${vo.title}<strong>[ ${vo.replycnt} ]</strong>
											<c:if test="${util:newImg(date) }">
												<img src="${root}/resources/img/home/new.gif">
											</c:if>	
									</a></td>
									<td>${vo.writer}</td>
									<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
											value="${vo.regdate}" /></td>
									<td><span class="badge bg-red">${vo.viewcnt }</span></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<!-- /#image -->
				<!-- /.box-body -->


				<div class="box-footer"> 
					<!-- 하단부 페이징 처리부분 -->
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
</section>
<!-- /.content -->



<script type="text/javascript">
	var images = ['beauty_dayana_women_01.jpg', 'beauty_dayana_women_02.jpg', 'beauty_dayana_women_03.jpg']; 
	//게시판에 들어올때마다 3개의 이미지가 랜덤으로 나옴
	$('.box').css({
		'background-image': 'url(${root}/resources/img/demo/' 
				+ images[Math.floor(Math.random() * images.length)] + ')',
				"background-size": "cover"}); 
	//신규 글을 작성하거나 글을 수정시 목록으로 넘어오며, 등록 및 수정 성공시 알림창(sweetAlert.js) 
	var result = '${msg}';
	if (result == 'Register_Success') {
		swal({
			  type: 'success',
			  title: '등록이 완료되었습니다.',
			  showConfirmButton: false,
			  timer: 1800
			})
	}else if (result == 'remove_success') {
		swal({
			  type: 'success',
			  title: '삭제가 완료되었습니다.',
			  showConfirmButton: false,
			  timer: 1800
			})
	}else if (result == 'modify_success') {
		swal({
			  type: 'success',
			  title: '수정이 완료되었습니다.',
			  showConfirmButton: false,
			  timer: 1800
			})
	}
</script>

<script>
	$(document).ready(function() { 
 		// 공포동영상과 생생정보통 게시판은 기본으로 썸네일형으로 출력, 그외 게시판은 목록형.
		if($('#keywordInput2').val() == 'M' || $('#keywordInput2').val() == 'I'){
			$('#image').show();
			$('#list').hide();
		} else {
			$('#image').hide();
			$('#list').show();
		} 
		// 키워드 입력하여 검색 버튼 클릭시
		$('#searchBtn').on("click",function(event) {
			self.location = "list"
			+ '${pageMaker.makeQuery(1)}'
			+ "&searchType="
			+ $("select option:selected").val()
			+ "&keyword=" + $('#keywordInput1').val()
			+ "&category=" + $('#keywordInput2').val();
		}); 
		// new 버튼 클릭시 글 작성 페이지로 이동.
		$('#newBtn').on("click", function(evt) {
			self.location = "/board/register?category=${cri.category}";
		}); 
		// 목록 버튼 클릭시 썸네일형에서 목록형으로.
		$('#listBtn').on("click", function(evt) {
			$('#image').hide('fast');
			$('#list').show();
		});
		// 썸네일 버튼 클릭시 목록형에서 썸네일형으로.
		$('#imgBtn').on("click", function(evt) {
			$('#list').hide('fast');
			$('#image').show();
		});
	});
</script>


<%@include file="../template/footer.jsp"%>
