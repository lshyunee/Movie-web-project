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
</style>
<div class="wrapper">
	<div class="container">
		<div class="panel1 panel-default1">
			<div class="panel-heading1">
				<b>회원목록</b>
			</div>
			<form role="form" action="/member/removeMember" method="POST">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
				<!-- /.panel-heading -->
				<div class="panel-body1">
					<div class="table-responsive">
						<table class="table">
							<thead>
								<tr>
									<th>User ID</th>
									<th>User NAME</th>
									<th>reg Date</th>
									<th></th>
									<th>비고</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="list" items="${list}">
									<c:if test="${list.userid != 'admin'}">
										<tr>
											<td>${list.userid}</td>
											<td>${list.userName}</td>
											<td><fmt:formatDate pattern="yyyy/MM/dd"
													value="${list.regDate}" /></td>
											<td><input type="hidden" name="userpw" value="${list.userpw}"></td>
											<td>
												<button type="button" class="btn btn-warning modifyBtn"
													data-options='${list.userid}'>수정</button>
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</form>
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
			<!-- /.panel-body -->
		</div>
		<form id="searchForm" action="/member/memberManage" method="get">
			<select name="type">
				<option value="" ${pageMaker.cri.type==null?'selected':''}>---</option>
				<option value="I" ${pageMaker.cri.type=='I'?'selected':''}>아이디</option>
				<option value="N" ${pageMaker.cri.type=='N'?'selected':''}>이름</option>
			</select> <input type="text" name="keyword"> <input type="hidden"
				name="pageNum" value="${pageMaker.cri.pageNum}"> <input
				type="hidden" name="amount" value="${pageMaker.cri.amount}">
			<button class="btn btn-default">Search</button>
		</form>
		<form id="actionForm" action="/member/memberManage" method="get">
			<input type="hidden" name="pageNum" value='${pageMaker.cri.pageNum}'>
			<input type="hidden" name="amount" value='${pageMaker.cri.amount}'>
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
			<input type="hidden" name="type" value="${pageMaker.cri.type}">
		</form>
	</div>
</div>
<!-- Modal -->
<div class="modal" id="myModal" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">Member Information</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>UserID</label> <input class="form-control" name="userid"
						value="userid">
				</div>
				<div class="form-group">
					<label>UserName</label> <input class="form-control" name="username"
						value="username">
				</div>
				<div class="form-group">
					<label>UserPW</label> <input class="form-control" name="userpw"
						value="">
				</div>
				<div class="form-group">
					<label>UserRegDate</label> <input class="form-control"
						name="userregdate" value="userregdate">
				</div>
			</div>
			<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn btn-warning">수정</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">삭제</button>
				<button id="modalCloseBtn" type="button" class="btn btn-default"
					style="border-radius: 15px;">Close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	type="text/javascript"></script>
<script type="text/javascript" src="/resources/js/member.js"></script>
<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	$(function() {

		var modal = $(".modal");
		var modalInputUserId = modal.find("input[name='userid']");
		var modalInputUserPw = modal.find("input[name='userpw']");
		var modalInputUserName = modal.find("input[name='username']");
		var modalInputUserRegDate = modal.find("input[name='userregdate']");

		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");

		$("#modalCloseBtn").click(function() {
			modal.modal("hide");
		});
		
		$(document).ajaxSend(function(e, xhr, options){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});
		
		$(".table").on("click", "button", function() {
			var userid = $(this).data("options");
			console.log(userid);
			memberService.get(userid, function(data) {
				modalInputUserId.val(data.userid).attr("readonly", "readonly");
				modalInputUserName.val(data.userName).attr("readonly", false);
				modalInputUserPw.val(data.userpw).attr("readonly", false);
				modalInputUserRegDate.val(memberService.displayTime(data.regDate)).attr(
						"readonly", "readonly");
				modal.data("userid", data.userid);
				modal.modal("show");
			});

			modalModBtn.on("click", function(e) {
				var member = {
					userid : modal.data("userid"),
					userName : modalInputUserName.val(),
					userpw : modalInputUserPw.val()
				};
				console.log(userid);
				
				memberService.update(member, function(result) {
					modal.modal("hide");
					showList(pageNum);
				});
				alert("수정되었습니다.");
				location.reload();
			});

			modalRemoveBtn.on("click", function(e) {
				var userid = modal.data("userid");
				console.log("userid: " + userid);
				
				memberService.remove(userid, function(result) {
					alert(userid + "가 삭제되었습니다.");
					targettr.remove();
					modal.modal("hide");
					showList(pageNum);
				});
				location.reload();
			});//remove


		});
		
		
		/*
		$(".table").on("click", "button", function() {
			var userid = $(this).data("options");
			var targettr = $(this).closest("tr");
			console.log("클릭");
			console.log(userid);
			$.ajax({
				url : '/member/removeMember',
				data : {
					userid : userid
				},
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				dataType : 'text',
				type : 'post',
				success : function(result) {
					alert(userid + "가 삭제되었습니다.");
					targettr.remove();
				}
			});//end Ajax

		});
		*/

	});
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