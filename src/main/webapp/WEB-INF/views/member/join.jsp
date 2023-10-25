<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ include file="../includes/header.jsp"%>
<style>
#checkInfo {
	color: blue;
}

/* 중복아이디 존재하지 않는경우 */
.id_input_re_1 {
	color: green;
	display: none;
}
/* 중복아이디 존재하는 경우 */
.id_input_re_2 {
	color: red;
	display: none;
}
</style>
<div class="container">
	<div class="row1">
		<div class="col-md-41 col-md-offset-41">
			<div class="login-panel panel1 panel-default1">
				<div class="panel-heading1">
					<h3 class="panel-title1">회원가입</h3>
				</div>
				<div class="panel-body1">
					<fieldset>
						<iframe id="iframe1" name="iframe1" style="display: none"></iframe>
						<form class="signup-form" action="/member/join" method="POST"
							target="iframe1">
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
							<div class="row">
								<div class="form-group">
									<label for="userid">아이디</label>
									<div>
										<input id="userid" name="userid" type="text"
											class="form-control1">
										<button type="button" class="btn btn-secondary" id="idCheck">중복확인</button>
									</div>
									<span class="id_input_re_1">사용 가능한 아이디입니다.</span> <span
										class="id_input_re_2">아이디가 이미 존재합니다.</span>
								</div>
							</div>
							<div class="row">
								<div class="form-group1">
									<label for="userpw">비밀번호</label> <input id="userpw"
										name="userpw" type="text" class="form-control" />

								</div>
							</div>
							<div class="row">
								<div class="form-group1">
									<label for="userName">이름</label> <input id="userName"
										name="userName" type="text" class="form-control" />
								</div>
							</div>
							<input id="create" class="btn btn-lg btn-light btn-block"
								type="submit" value="check" />

						</form>

						<form class="signup-form" action="/member/authCheck" method="POST">
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
							<div class="row">
								<div class="input-field col s12">
									<input id="userid2" name="userid" type="hidden"
										class="validate" value="" />
								</div>
							</div>
							<div class="row">
								<div class="form-group1">
									<div id="checkInfo"></div>
								</div>
							</div>
							<input id="auth" name="auth" type="hidden" class="validate"
								value="ROLE_USER" /> <input id="join"
								class="btn btn-lg btn-primary btn-block" disabled='disabled'
								type="submit" value="가입하기" />
						</form>
					</fieldset>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	type="text/javascript"></script>
<script>
	$(function() {
		$("#join").hide();
		$("#create").click(
				function() {
					var userid = document.getElementById('userid').value;
					var userpw = document.getElementById('userpw').value;
					var username = document.getElementById('userName').value;
					console.log(userid);
					$('#userid2').val(userid);
					$("#create").hide();
					$("#join").show();
					$("#checkInfo").append(
							"<input id='check' type='checkbox'>아이디 : '"
									+ userid + "', 이름 : '" + username
									+ "' 으로 회원가입 하시겠습니까?");
					$("#check").click(function() {
						var boxcheck = $("#check").prop("checked");
						if (boxcheck) {
							$("#join").prop("disabled", false);
						}
						;
					});

				});
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";

		//아이디 중복검사
		$('#idCheck').click(function() {

			//console.log("keyup 테스트");

			var userid = $('#userid').val(); // #userid에 입력되는 값
			var data = {
				userid : userid
			} // '컨트롤에 넘길 데이터 이름' : '데이터(#userid에 입력되는 값)'

			$.ajax({
				type : "post",
				url : "/member/idCheck",
				data : data,
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(result) {
					if (result != 'fail') {
						$('.id_input_re_1').css("display", "inline-block");
						$('.id_input_re_2').css("display", "none");
					} else {
						$('.id_input_re_2').css("display", "inline-block");
						$('.id_input_re_1').css("display", "none");
					}

				}// success 종료

			}); // ajax 종료
		});
	});// function 종료
</script>
<script>
	$(function() {
		$("#join").on("click",function(){
			alert("가입이 완료되었습니다. 로그인 페이지로 이동합니다.");
		})
	});
</script>