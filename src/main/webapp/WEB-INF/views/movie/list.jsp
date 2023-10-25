<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	type="text/javascript"></script>
<style>
.uploadResult ul {
	margin: 0;
	padding: 0;
}

.uploadResult ul li {
	list-style: none;
	height: 300px;
}

.uploadResult ul li img {
	width: 100%;
	height: 100%;
	margin-bottom: 3rem !important;
	margin-bottom: 0 !important;
	margin-bottom: 3rem !important;
}
.myPosts{
	border:none;
	background-color:transparent;
}
</style>
<!-- Header-->
<header class="bg-dark py-4 mainpage"
	style="background: linear-gradient(to right, #FF5402, #FCF100);">
	<!-- background-image: url('/resources/image/cc2.png'); background-size: cover; -->
	<div class="container px-4 px-lg-5 my-5">
		<div class="text-center text-white" id="goList">
			<h1 class="display-4 fw-bolder font-crunky">Movie Crunky</h1>
		</div>
	</div>
</header>
<div class="container px-4 px-lg-5 pt-lg-5">
	<sec:authorize access="isAuthenticated()">
	<input type="hidden" id="username" name="writer"
		value='<sec:authentication property="principal.username"/>'>
	<div class="pull-left">
		<form id="myPosts" action="/movie/list" method="get" class="search">
			<input type="hidden" name="type" value="W"> <input
				id="keyword" type="hidden" name="keyword"> <input
				type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
			<button class="myPosts" type="button"><p class="fa fa-pencil">내가 쓴 글</p></button>
		</form>
	</div>
	</sec:authorize>
	<div class="pull-right">
		<form id="searchForm" action="/movie/list" method="get" class="search">
			<select name="type">

				<option value="T" ${pageMaker.cri.type=='T'?'selected':''}>제목</option>
				<option value="D" ${pageMaker.cri.type=='D'?'selected':''}>감독</option>
				<option value="R" ${pageMaker.cri.type=='R'?'selected':''}>평점</option>
				<option value="G" ${pageMaker.cri.type=='G'?'selected':''}>장르</option>
				<option value="W" ${pageMaker.cri.type=='W'?'selected':''}>작성자</option>
			</select> <input type="text" name="keyword"
				placeholder="Search movies more..."> <input type="hidden"
				name="pageNum" value="${pageMaker.cri.pageNum}"> <input
				type="hidden" name="amount" value="${pageMaker.cri.amount}">
			<button class="btn btn-primary">Search</button>
		</form>
	</div>
</div>
<!-- Section-->
<section class="pt-4 pb-6">
	<div class="container px-4 px-lg-5 mt-5">
		<div
			class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
			<c:forEach var="list" items="${list}">
				<div class="col mb-5">
					<div class="card h-80" style="border-radius: 30px;">
						<div class="uploadResult" id="${list.mno}">
							<ul>

							</ul>
						</div>
						<div class="card-body p-4">
							<div class="text-center">
								<!-- Product name-->

								<h5 class="fw-bolder">${list.title}</h5>

								<div
									class="d-flex justify-content-center small text-warning mb-2">
									<c:forEach var="plus" begin="1" end="${list.rating}" step="1">
										<img src="/resources/image/cruncky.png" width="30px">&nbsp;
									</c:forEach>
									<c:forEach var="minus" begin="${list.rating}" end="4" step="1">
										<img src="/resources/image/dark.png" width="30px"> &nbsp;
									</c:forEach>
									<c:if test="${list.rating eq '5'}">
										<br>
										<img src="/resources/image/file.jpg" width="30px"
											style="position: absolute; bottom: 10px; right: 10px;">
									</c:if>
								</div>
							</div>
						</div>
						<!-- Product actions-->
						<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
							<div class="text-center">
								<a class="move" href="<c:out value='${list.mno}'/>"><button
										class="btn btn-outline-dark mt-auto">상세보기</button></a>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>

		<div class="pull-right">
			<ul class="pagination">
				<c:if test="${pageMaker.prev}">
					<li class="paginate_button previous"><a
						href="${pageMaker.startPage-1}">Previous</a></li>
				</c:if>
				<c:forEach var="num" begin="${pageMaker.startPage}"
					end="${pageMaker.endPage}">
					<li
						class="paginate_button ${pageMaker.cri.pageNum==num?'active':''}"><a
						href="${num}">${num}</a></li>
				</c:forEach>
				<c:if test="${pageMaker.next}">
					<li class="paginate_button next"><a
						href="${pageMaker.endPage+1}">Next</a></li>
				</c:if>
			</ul>
		</div>
		<form id="actionForm" action="/movie/list" method="get">
			<input type="hidden" name="pageNum" value='${pageMaker.cri.pageNum}'>
			<input type="hidden" name="amount" value='${pageMaker.cri.amount}'>
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
			<input type="hidden" name="type" value="${pageMaker.cri.type}">
		</form>
	</div>
</section>
<script type="text/javascript">
	$(function() {
		var actionForm = $('#actionForm');
		$('.pagination a').on('click', function(e) {
			e.preventDefault();
			console.log("click");
			actionForm.find('input[name="pageNum"]').val($(this).attr('href'));
			actionForm.submit();
		});
		$('.move').on(
				"click",
				function(e) {
					e.preventDefault();
					actionForm.append("<input type='hidden' name='mno' value='"
							+ $(this).attr("href") + "'>");
					actionForm.attr("action", "/movie/info");
					actionForm.submit();
				});

		$("#searchForm button").on("click", function(e) {
			var searchForm = $("#searchForm");
			if (!searchForm.find("option:selected").val()) {
				alert("검색 종류를 선택하세요.");
				return false;
			}
			if (!searchForm.find('input[name="keyword"]').val()) {
				alert("키워드를 입력하세요.");
				return false;
			}
			searchForm.find('input[name="pageNum"]').val('1');
			e.preventDefault();
			searchForm.submit();

		});

		$("#goList").click(function() {
			self.location = "/movie/list";
		});

	})

	$("#list").click(function() {
		self.location = "/movie/list";
	});
</script>
<script>
	<c:forEach var="list" items="${list}">
	$(function() {
		var mno = '${list.mno}';
		$.getJSON("/movie/getAttach",{mno : mno},function(arr) {
			console.log(arr);
			var str = "";
			if (arr.length == 0) {
				str += '<li><img></li>';
			} else {
				$(arr).each(function(i, obj) {
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					str += '<li data-path="' + obj.uploadPath + '" data-uuid="' + obj.uuid + '" data-filename="' +obj.fileName + '">';
					str += '<img src="/display?fileName=' + fileCallPath + '" style="border-radius: 30px 30px 0 0;"></li>';
				});
			}
			$('#${list.mno} ul').html(str);
		});
	});
	</c:forEach>
</script>
<script>
	var myPosts = $('#myPosts');
	var username = document.getElementById('username').value;
	$(".myPosts").on('click', function() {
		console.log(username);
		$('#keyword').val(username);
		myPosts.find('input[name="pageNum"]').val('1');
		myPosts.submit();
	});
</script>
<%@ include file="../includes/footer.jsp"%>