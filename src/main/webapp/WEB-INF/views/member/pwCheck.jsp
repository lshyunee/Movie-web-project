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
	padding-bottom: 265px;
}

.panel1 {
	background-color: transparent;
	border: transparent;
	-webkit-box-shadow: 0 0 0 0;
	box-shadow: 0 0 0 0;
	box-sizing: border-box;
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
						<div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
							<div class="features-icons-icon d-flex">
								<i class="bi-window m-auto text-primary"></i>
							</div>
							<h3>
								<a href="/member/mypage">내 정보</a>
							</h3>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
							<div class="features-icons-icon d-flex">
								<i class="bi-layers m-auto text-primary"></i>
							</div>
							<h3>
								<a href="/member/mypage">정보 수정</a>
							</h3>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="features-icons-item mx-auto mb-0 mb-lg-3">
							<div class="features-icons-icon d-flex">
								<i class="bi-terminal m-auto text-primary"></i>
							</div>
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
			<div class="col-md-41 col-md-offset-41">
				<div class="login-panel panel1 panel-default1">
					<div class="panel-body1">
						<form role="form" method="post" action="/login" id="login_form">
							<fieldset>
								<div class="form-group1">
									<input id="userid" name="username" type="text"
											class="form-control" value="" >
								</div>
								<div class="form-group1">
									<input class="form-control" placeholder="Password"
										name="password" type="password" value="">
								</div>
								<!-- Change this to a button or input when using this as a form -->
								<a href="/member/mypage" class="btn btn-lg btn-primary btn-block">비밀번호 확인</a> <br>
							</fieldset>
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	type="text/javascript"></script>
<script>
</script>
<%@ include file="../includes/footer.jsp"%>