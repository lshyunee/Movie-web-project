<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="./includes/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	type="text/javascript"></script>
<script src="/resources/bxslider-4-4.2.12/src/js/jquery.bxslider.js"></script>
<link rel="stylesheet"
	href="/resources/bxslider-4-4.2.12/src/css/jquery.bxslider.css">
<script>
	$(function() {
		$("#slide_gallery").bxSlider({
			auto : true,
			autoControls : true,
			stopAutoOnClick : true,
			pager : true
		});
	})
</script>
<style>
.bx-wrapper {border:0;background:#fbfbfb;box-shadow:none;}
</style>
<!-- Header-->
<header class="bg-dark py-5" style="text-align:center; height:450px; background: linear-gradient(to right, #FF5402, #FCF100);">
	<div class="container px-4 px-lg-5 my-3">
			<ul id="slide_gallery">
				<li><img src="/resources/image/play1.jpg" alt="" width="1320" height="300"></li>
				<li><img src="/resources/image/play2.jpg" alt="" width="1320" height="300"></li>
				<li><img src="/resources/image/play3.jpg" alt="" width="1320" height="300"></li>
			</ul>
	</div>
</header>
<div class="container px-4 px-lg-5 pt-lg-5">
	<div class="pull-right">
		<button class="btn btn-primary"><p class="lead fw-normal mb-0" id="goList">Go Crunky! >></p></button>
	</div>
</div>
<!-- Section-->
<section class="py-5 text-center">
	<div class="container px-2 px-lg-2 my-5">
		<div class="row gx-4 gx-lg-4 align-items-center">
			<div class="col-md-4">
				<a href="https://www.cgv.co.kr/"><img
					src="/resources/image/cgv.png" width="300px"></a>
			</div>
			<div class="col-md-4">
				<a href="https://www.lottecinema.co.kr/NLCHS"><img
					src="/resources/image/lotte.png" width="300px"></a>
			</div>
			<div class="col-md-4">
				<a href="https://www.megabox.co.kr/"><img
					src="/resources/image/megabox.png" width="300px"></a>
			</div>
			<div class="col-md-3 pt-5">
				<a href="https://www.netflix.com/kr/"><img
					src="/resources/image/netflix.png" width="300px"></a>
			</div>
			<div class="col-md-3 pt-5">
				<a href="https://www.tving.com/onboarding"><img
					src="/resources/image/tiving.png" width="300px"></a>
			</div>
			<div class="col-md-3 pt-5">
				<a href="https://www.wavve.com/"><img
					src="/resources/image/wavve.png" width="300px"></a>
			</div>
			<div class="col-md-3 pt-5">
				<a href="https://watcha.com/"><img
					src="/resources/image/watcha.png" width="300px"></a>
			</div>
		</div>
	</div>
</section>
<script type="text/javascript">
	
	$("#goList").click().click(function() {
		self.location = "/movie/list";
	});
</script>
<%@ include file="./includes/footer.jsp"%>