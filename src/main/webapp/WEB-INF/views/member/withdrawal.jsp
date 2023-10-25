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
.panel1{
	background-color: transparent;
	border:transparent;
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
		<form role="form" action="/member/withdrawalCP" method="POST"
			id="formButton">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> <input id="userid" name="userid"
				type="hidden" class="form-control" value="${member.userid}" />
			<div class="row1">
				<div class="col-md-41 col-md-offset-41">
					<div class="login-panel panel1 panel-default1">
						<div class="panel-body1">
							<fieldset>
								<button class="btn-lg btn-primary btn-block wdButton">탈퇴하기</button>
							</fieldset>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	type="text/javascript"></script>
<script>
	$(function() {
		$(".wdButton").on("click",function(){
			alert("탈퇴되었습니다. 자동으로 로그아웃 됩니다.");
		})
	});
</script>
<%@ include file="../includes/footer.jsp"%>