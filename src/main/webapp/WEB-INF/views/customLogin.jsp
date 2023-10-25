<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ page session="false"%>
<%@ include file="./includes/header.jsp"%>
<div class="container">
	<div class="row1">
		<div class="col-md-41 col-md-offset-41">
			<div class="login-panel panel1 panel-default1">
				<div class="panel-heading1">
					<h3 class="panel-title1">로그인</h3>
				</div>
				<div class="panel-body1">
					<form role="form" method="post" action="/login" id="login_form">
						<fieldset>
							<div class="form-group1">
								<input class="form-control" placeholder="userid" name="username"
									type="text" autofocus>
							</div>
							<div class="form-group1">
								<input class="form-control" placeholder="Password"
									name="password" type="password" value="">
							</div>
							<div class="checkbox1">
								<label> <input name="remember" type="checkbox"
									value="Remember Me">Remember Me
								</label>
							</div>
							<!-- Change this to a button or input when using this as a form -->
							<a href="/" class="btn btn-lg btn-primary btn-block">Login</a>
							<br>
							<a href="/member/join" class="btn btn-lg btn-success btn-block" style="border-radius: 15px;">join</a>
						</fieldset>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	type="text/javascript"></script>
<script>
	$(".btn-primary").on("click", function(e){
		e.preventDefault();
		$("form").submit();
	});
	$("#login_form").keypress(function(e){
		if(e.keyCode == 13){
			$("form").submit();
		}
	})
	
</script>
<script src="/resources/js/scripts.js"></script>