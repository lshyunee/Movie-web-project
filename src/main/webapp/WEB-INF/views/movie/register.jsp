<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ include file="../includes/header.jsp"%>
<style>
.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 450px;
	height: 650px;
	margin-bottom: 3rem !important;
	margin-bottom: 0 !important;
}
</style>
<section class="py-5">
	<div class="container px-4 px-lg-5 my-5">
		<form method="post">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
			<div class="row gx-4 gx-lg-5 align-items-center">
				<div class="col-md-6">
					<div class="uploadResult">
						<ul>

						</ul>
					</div>
				</div>
				<div class="col-md-6">

					<div class="fs-5 mb-5">
						<div class="form-group">
							<label>Genre</label>
							<p>
								액션<input type="checkbox" name="genre" value="액션" checked>
								| 공포<input type="checkbox" name="genre" value="공포"> | 멜로<input
									type="checkbox" name="genre" value="멜로"> | 코미디<input
									type="checkbox" name="genre" value="코미디"> | 애니메이션<input
									type="checkbox" name="genre" value="애니메이션">
							</p>
						</div>

						<div class="form-group">
							<label>Title</label> <input class="form-control" name="title">
						</div>
						<nav class="navbar navbar-expand-lg navbar-light">
							<div class="container px-4 px-lg-5">
								<ul class="navbar-nav me-1 my-sm-4 fs-4">
									<li class="nav-item dropdown">평점&nbsp; <select
										name="rating">
											<option>1</option>
											<option>2</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
									</select> 점
									</li>
								</ul>
							</div>

						</nav>
						<div class="form-group">
							<label>Content</label>
							<textarea class="form-control" rows="3" name="content"></textarea>
						</div>
						<div class="form-group">
							<label>Regdate</label> <input class="form-control" name="regdate">
							<label>Director</label> <input class="form-control"
								name="director">
						</div>
						<div class="form-group">
							<label>writer</label> <input class="form-control" name="writer"
								value='<sec:authentication property="principal.username"/>'
								readonly="readonly">
						</div>
						<div>
							<br>
						</div>
						<div class="form-group" class="uploadDiv">
							<input type="file" name="uploadFile">
							<!-- 파일 하나만 업로드 할 경우 multiple 속성이 필요 없음 -->
						</div>
					</div>

				</div>
			</div>
			<div class="col-md-6">
				<div class="mb-5 mb-md-0 my-5">
					<button class="btn btn-primary" type="submit">등록</button>
				</div>
			</div>
		</form>
	</div>
</section>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	type="text/javascript"></script>
<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	var formObj = $("form");
	$('button[type="submit"]')
			.on(
					"click",
					function(e) {
						e.preventDefault();
						console.log("submit clicked");
						var str = "";
						$(".uploadResult ul li")
								.each(
										function(i, obj) {
											var jobj = $(obj);
											console.dir(jobj);
											console.log("-------------------");
											console.log(jobj.data('filename'));
											//이미지에 대한 정보 전송
											str += "<input type='hidden' name='attach.fileName' value='"
													+ jobj.data('filename')
													+ "'>";
											str += "<input type='hidden' name='attach.uuid' value='"
													+ jobj.data('uuid') + "'>";
											str += "<input type='hidden' name='attach.uploadPath' value='"
													+ jobj.data('path') + "'>";
										});
						console.log(str);
						formObj.append(str).submit();
					});

	var regex = new RegExp("(.*?)\.(jpg|png|webp)$");
	var maxSize = 5242880;
	function checkExtension(fileName, fileSize) {
		if (fileSize >= maxSize) {
			alert("파일 사이즈 초과");
			return false;
		}
		if (!regex.test(fileName)) {
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}//checkExtension()

	var uploadResult = $(".uploadResult ul");
	function showUploadFile(uploadResultArr) {
		var str = "";
		$(uploadResultArr)
				.each(
						function(i, obj) {
							//str += "<li>" + obj.fileName + "</li>";
							var fileCallPath = encodeURIComponent(obj.uploadPath
									+ "/" + obj.uuid + "_" + obj.fileName);
							str += '<li data-path="'+obj.uploadPath+'" data-uuid="'+obj.uuid+'" data-filename="'+obj.fileName+'">';
							str += '<img src="/display?fileName='
									+ fileCallPath + '">';
							str += '<span>' + obj.fileName + '</span>';
							str += '<button type="button" data-file="' + fileCallPath + '" data-type="image" class="btn btn-danger">x</button><br></li>';
						});
		uploadResult.append(str);
	}//showUploadFile

	uploadResult.on("click", "button", function() {
		var targetFile = $(this).data("file");
		var targetLi = $(this).closest("li");
		console.log(targetFile);
		$.ajax({
			url : '/deleteFile',
			data : {
				fileName : targetFile
			},
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			dataType : 'text',
			type : 'post',
			success : function(result) {
				alert(result);
				targetLi.remove();
			}
		});

	});

	var cloneObj = $(".uploadDiv").clone();

	$('input[type="file"]').change(function() {
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		console.log(files);
		if (!checkExtension(files[0].name, files[0].size)) {
			return false;
		}
		formData.append("uploadFile", files[0]);
		$.ajax({
			url : '/uploadAjaxAction',
			processData : false,
			contentType : false,
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data : formData,
			type : 'post',
			dataType : 'json',
			success : function(result) {
				console.log(result);
				showUploadFile(result);
				$(".uploadDiv").html(cloneObj.html());
			}
		}); //end $.ajax
	});
</script>
<script>
	$(function() {
		$(".btn").on("click",function(){
			alert("등록이 완료되었습니다.");
		})
	});
</script>
<%@ include file="../includes/footer.jsp"%>