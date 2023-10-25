<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ include file="../includes/header.jsp"%>
<style>
.uploadResult ul {
	margin: 0;
	padding: 0;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 100%;
	height: 100%;
	margin-bottom: 3rem !important;
	margin-bottom: 0 !important;
}
</style>
<section class="py-5">
	<div class="container px-4 px-lg-5 my-5">

		<form role="form" method="post" action="/movie/modify">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> <input type="hidden" name="pageNum"
				value="${cri.pageNum}"> <input type="hidden" name="amount"
				value="${cri.amount}"> <input type="hidden" name="keyword"
				value="${cri.keyword}"> <input type="hidden" name="type"
				value="${cri.type}">
			<div class="row gx-4 gx-lg-5 align-items-center">
				<div class="col-md-6">
					<div class="uploadResult">
						<ul>

						</ul>
					</div>
				</div>
				<div class="col-md-6">

					<div class="form-group">
						<label>Genre</label>
						<p>
							액션<input type="checkbox" name="genre" value="액션"
								class="custom-control-input"> | 공포<input type="checkbox"
								name="genre" value="공포" class="custom-control-input"> |
							멜로<input type="checkbox" name="genre" value="멜로"
								class="custom-control-input"> | 코미디<input
								type="checkbox" name="genre" value="코미디"
								class="custom-control-input"> | 애니메이션<input
								type="checkbox" name="genre" value="애니메이션"
								class="custom-control-input">
						</p>
					</div>
					<div class="form-group">
						<label>MNO</label> <input class="form-control" name="mno"
							value="${info.mno}" readonly>
						<!-- ${info.mno} -->
					</div>
					<div class="form-group">
						<label>Title</label> <input class="form-control" name="title"
							value="${info.title}">
					</div>

					<nav class="navbar navbar-expand-lg navbar-light">
						<div class="container px-4 px-lg-5">
							<ul class="navbar-nav me-1 my-sm-4 fs-4">
								<li class="nav-item dropdown"><a class="nav-link"
									role="button" data-bs-toggle="dropdown" aria-expanded="false">평점&nbsp;
										<select name="rating" id="chk_select">
											<option>1</option>
											<option>2</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
									</select> 점
								</a></li>
							</ul>
						</div>

					</nav>

					<div class="form-group">
						<label>Content</label>
						<textarea class="form-control" rows="3" name="content">${info.content}</textarea>
					</div>
					<div class="form-group">
						<label>Regdate</label> <input class="form-control" name="regdate"
							value="${info.regdate}"> <label>Director</label> <input
							class="form-control" name="director" value="${info.director}">
						<label>Writer</label> <input class="form-control" name="writer"
							value="${info.writer}" readonly="readonly">
					</div>
					<div class="form-group" class="uploadDiv">
						<input type="file" name="uploadFile">
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="mb-5 mb-md-0 my-5">
					<sec:authentication property="principal" var="pinfo" />
					<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq info.writer}">
							<button id="sub" class="btn btn-primary" data-oper="modify">저장</button>
							<button id="del" class="btn btn-danger" data-oper="remove">삭제</button>
						</c:if>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<button id="sub" class="btn btn-primary" data-oper="modify">저장</button>
						<button id="del" class="btn btn-danger" data-oper="remove">삭제</button>
					</sec:authorize>
				</div>
			</div>
		</form>
	</div>
</section>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(function() {
		var formObj = $("form");
		$("form .btn").on("click", function(e) {
			e.preventDefault();
			var operation = $(this).data("oper");
			console.log(operation);
			if (operation === 'remove') {
				formObj.attr({
					"action" : "/movie/remove",
					"method" : "post"
				});
			} else if (operation === 'modify') {
				formObj.attr({
					"action" : "/movie/modify",
					"method" : "post"
				});
				var str = "";
				$(".uploadResult ul li").each(function(i, obj){
					var jobj = $(obj);
					console.dir(jobj);
					console.log("-------------------");
					console.log(jobj.data('filename'));	//input에 name vo에서 가져온거임
					//이미지에 대한 정보 전송
					str += "<input type='hidden' name='attach.fileName' value='" + jobj.data('filename') + "'>";	//밑에 li에 data-하고 넣은 것들임
					str += "<input type='hidden' name='attach.uuid' value='" + jobj.data('uuid') + "'>";
					str += "<input type='hidden' name='attach.uploadPath' value='" + jobj.data('path') + "'>";	//data-path니까 path
				});
				console.log(str);
				formObj.append(str);
			}

			formObj.submit();
		});
	})
	
	var mno = '${info.mno}';
	//function 앞엔 url(attach 목록 불러오는 url)
	$.getJSON("/movie/getAttach", {mno : mno}, function(arr) {
		console.log(arr);
		var str = "";
		$(arr).each(function(i, obj){
			var fileCallPath = encodeURIComponent(obj.uploadPath
					+ "/" + obj.uuid + "_" + obj.fileName);
			str += '<li data-path="'+obj.uploadPath+'" data-uuid="'+obj.uuid+'" data-filename="'+obj.fileName+'">';
			str += '<img src="/display?fileName='
					+ fileCallPath + '">';
			str += '<span>' + obj.fileName + '</span>';
			str += '<button type="button" data-file="' + fileCallPath + '" data-type="image" class="btn-danger">x</button><br></li>';
		});
		$(".uploadResult ul").html(str);
		
	});
	
	var uploadResult = $(".uploadResult ul");
	function showUploadFile(uploadResultArr) {
		var str = "";
		$(uploadResultArr)
				.each(
						function(i, obj) {
							var fileCallPath = encodeURIComponent(obj.uploadPath
									+ "/" + obj.uuid + "_" + obj.fileName);
							str += '<li data-path="'+obj.uploadPath+'" data-uuid="'+obj.uuid+'" data-filename="'+obj.fileName+'">';
							str += '<img src="/display?fileName='
									+ fileCallPath + '">';
							str += '<span>' + obj.fileName + '</span>';
							str += '<button type="button" data-file="' + fileCallPath + '" data-type="image" class="btn-danger">x</button><br></li>';
						});
		uploadResult.append(str);
	}//showUploadFile
	
	
	uploadResult.on("click", "button", function(e) {
		e.preventDefault();
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
				event.cancelBubble = true;
			    event.returnValue = false;

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

	
	var cloneObj = $(".uploadDiv").clone();
	$('input[type="file"]').change(function() {
		var formData = new FormData(); //객체 생성
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
			data : formData,
			type : 'post',
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			dataType : 'json',
			success : function(result) {
				console.log(result);
				showUploadFile(result); //함수 호출
				$(".uploadDiv").html(cloneObj.html()); //초기화(파일 업로드 후에 파일선택에 선택된 파일 없다고 뜸)
			}
		}); //end $.ajax
	});
	
	$("#chk_select").val(${info.rating});

	var theme= "${info.genre}";
	var chkbox=$('.custom-control-input');
	theme=theme.split(',');
	
	for(i=0; i<theme.length; i++) {
		for(j=0; j<chkbox.length; j++) {
			if(theme[i]==chkbox[j].value) {
				chkbox[j].checked = true;
			}
		}
	}
</script>
<script>
	$(function() {
		$("#sub").on("click",function(){
			alert("수정이 완료되었습니다.");
		})
	});
</script>
<script>
	$(function() {
		$("#del").on("click",function(){
			alert("삭제가 완료되었습니다.");
		})
	});
</script>
<%@ include file="../includes/footer.jsp"%>
