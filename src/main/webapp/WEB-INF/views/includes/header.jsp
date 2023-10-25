<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Movie</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="/resources/assets/favicon.ico" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap"
	rel="stylesheet">
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/resources/css/styles.css" rel="stylesheet" />
<link href="/resources/css/login.css" rel="stylesheet" />
<link href="/resources/css/custom.css" rel="stylesheet" />
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
</head>
<body>
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="/"><b>CRUNKY</b></a>
			<ul class="navbar-nav active ">
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="/movie/list">Home</a></li>
				<!-- 
				<li class="nav-item"><a class="nav-link" href="/movie/register">Register</a></li>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<li class="nav-item"><a class="nav-link" href="/member/memberManage">Member</a></li>
				</sec:authorize>
				<sec:authorize access="isAnonymous()">
					<li class="nav-item"><a class="nav-link" href="/customLogin">LogIn</a></li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<li class="nav-item"><a class="nav-link" href="/customLogout">Logout</a></li>
				</sec:authorize>
				 -->
				<li class="nav-item dropdown"><sec:authorize
						access="isAnonymous()">
						<li class="nav-item"><a class="nav-link" href="/customLogin">LogIn</a></li>
					</sec:authorize> <sec:authorize access="isAuthenticated()">
						<a class="nav-link dropdown-toggle" id="navbarDropdown" href="/"
							role="button" data-bs-toggle="dropdown" aria-expanded="false"><sec:authentication property="principal.username"/>님</a>
					</sec:authorize>
					<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
						<sec:authorize access="isAnonymous()">
							<li><a class="dropdown-item" href="/customLogin">LogIn</a></li>
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
							<li><a class="dropdown-item" href="/customLogout">Logout</a></li>
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
							<li><a class="dropdown-item" href="/member/mypage">MyPage</a></li>
							<li><a class="dropdown-item" href="/movie/register">Register</a></li>
							<li><a class="dropdown-item" href='/movie/likeList?userid=<sec:authentication property="principal.username"/>'>LikeList</a></li>
						</sec:authorize>
						<sec:authorize access="hasRole('ROLE_ADMIN')">
							<li><a class="dropdown-item" href="/member/memberManage">Member</a></li>
						</sec:authorize>
					</ul></li>
			</ul>
		</div>
	</nav>