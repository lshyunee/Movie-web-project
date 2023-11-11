<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ include file="../includes/header.jsp"%>
<style>
.wrapper {
	position: relative;
	min-height: 100%;
	padding-bottom: 120px;
}

li {
	list-style-type: none;
}

.heart {
	border: 0px;
	background-color:transparent;
}

.like {
	width: 50px;
	height: 50px;
}

a {
  text-decoration-line: none;
  color : black;
}

a:hover {
  color : brown;
}

</style>
<div class="wrapper">
	<div class="container">
		<div class="panel1 panel-default1">
			<div class="panel-heading1">
				<b>찜 목록</b>
			</div>
			<form role="form" action="/movie/likeListRemove" method="POST">
				<input type="hidden" id="userid" name="userid"
					value='<sec:authentication property="principal.username"/>'>
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
				<!-- /.panel-heading -->
				<div class="panel-body1">
					<div class="table-responsive">
						<table class="table">
							<thead>
								<tr>
									<th></th>
									<th></th>
									<th></th>
									<th></th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="list" items="${list}">
									<tr>
										<td><div class="uploadResult" id="${list.mno}">
												<ul>

												</ul>
											</div></td>
										<td><a href='/movie/info?mno=${list.mno}'>${list.title}</a></td>
										<td><fmt:formatDate pattern="yyyy/MM/dd"
												value="${list.regDate}" /></td>
										<td><input type="hidden" name="title"
											value="${list.title}"></td>
										<td><input type="hidden" name="mno" value="${list.mno}">
											<button type="submit" class="heart" data-option="${list.mno}">
												<img src="/resources/image/heart2.png" class="like" alt="" onclick="">
												
											</button></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</form>
			
			<!-- /.panel-body -->
		</div>
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	type="text/javascript"></script>
<script type="text/javascript" src="/resources/js/member.js"></script>
<script>
	<c:forEach var="list" items="${list}">
	$(function() {
		var mno = '${list.mno}';
		$
				.getJSON(
						"/movie/getAttach",
						{
							mno : mno
						},
						function(arr) {
							console.log(arr);
							var str = "";
							if (arr.length == 0) {
								str += '<li><img></li>';
							} else {
								$(arr)
										.each(
												function(i, obj) {
													var fileCallPath = encodeURIComponent(obj.uploadPath
															+ "/s_"
															+ obj.uuid
															+ "_"
															+ obj.fileName);
													str += '<li data-path="' + obj.uploadPath + '" data-uuid="' + obj.uuid + '" data-filename="' +obj.fileName + '">';
													str += '<img src="/display?fileName='
															+ fileCallPath
															+ '"></li>';
												});
							}
							$('#${list.mno} ul').html(str);
						});
	});
	</c:forEach>
</script>
<script type="text/javascript">
	/*
	 $(document).ready(function () {
	 $(".heart").on("click", function () {
	 var mno = $(".heart").find("option:selected").data("data");
	 var sendData = {'userid' : '<sec:authentication property="principal.username"/>', 'mno' : 'mno'};
	 $.ajax({
	 url :'/movie/likeListRemove',
	 type :'POST',
	 data : sendData,
	 success : function(data){
	 }
	 });
	 });
	 });
	 */
</script>
<script>
	var actionForm = $('#actionForm');
	$(".pagination a").on('click', function(e) {
		e.preventDefault();
		console.log("click");
		actionForm.find('input[name="pageNum"]').val($(this).attr('href'));
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
</script>
<%@ include file="../includes/footer.jsp"%>