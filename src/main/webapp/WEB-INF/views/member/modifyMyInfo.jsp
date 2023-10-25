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

a {
	text-decoration: none;
	color: black;
}

a:hover {
	color: #852007;
}
</style>
<div class="wrapper">
	<div class="container">
		<section class="features-icons text-center">
			<div class="container">
				<div class="row">
					<div class="col-lg-4">
						<div class="mx-auto mb-5 mb-lg-0 mb-lg-3">
							<p class="fa fa-gittip"></p>
							<h3>
								<a href="/member/mypage">내 정보</a>
							</h3>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="mx-auto mb-5 mb-lg-0 mb-lg-3">
							<p class="fa fa-edit"></p>
							<h3>
								<a href="/member/modifyMyInfo">정보 수정</a>
							</h3>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="mx-auto mb-5 mb-lg-0 mb-lg-3">
							<p class="fa fa-bomb"></p>
							<h3>
								<a href="/member/withdrawal">회원 탈퇴</a>
							</h3>
						</div>
					</div>
				</div>
			</div>
		</section>
		<section class="features-icons text-center"></section>
		<div class="row1">
			<form role="form" method="post" action="/member/modifyMyInfo">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
				<div class="col-md-41 col-md-offset-41">
					<div class="login-panel panel1 panel-default1">
						<div class="panel-body1">
							<fieldset>
								<div class="row">
									<div class="form-group1">
										<label for="userid">아이디</label>
										<div>
											<input id="userid" name="userid" type="text"
												class="form-control1" value="${member.userid}" readonly>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group1">
										<label for="userpw">비밀번호</label> <input id="userpw"
											name="userpw" type="text" class="form-control"
											value="${member.userpw}" />
									</div>
								</div>
								<div class="row">
									<div class="form-group1">
										<label for="userName">이름</label> <input id="userName"
											name="userName" type="text" class="form-control"
											value="${member.userName}" />
									</div>
								</div>
								<div class="row">
									<div class="form-group1">
										<label for="userName">가입일</label><input id="regDate"
											name="regDate" type="text" class="form-control"
											value="<fmt:formatDate pattern="yyyy/MM/dd"
													value='${member.regDate}' />" />
									</div>
								</div>
								<button type="submit" class="btn-lg btn-primary btn-block modifyCP">회원정보
									수정하기</button>
							</fieldset>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	type="text/javascript"></script>
<script>
	$(function(){
		$(".modifyCP").click(function(){
			alert("수정되었습니다.");
		});
	})
</script>
<%@ include file="../includes/footer.jsp"%>