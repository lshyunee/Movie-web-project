<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 100px;
}
</style>
</head>
<body>
	<h1>Upload with Ajax</h1>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	<button id="uploadBtn">Upload</button>
	<div class="uploadResult">
		<ul>

		</ul>
	</div>
	<script src="/resources/vendor/jquery/jquery.min.js"></script>
	<script type="text/javascript">
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880;
		function checkExtension(fileName, fileSize) {
			if (fileSize >= maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}
			if (regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}//checkExtension()

		var uploadResult = $(".uploadResult ul");
		function showUploadFile(uploadResultArr) {
			var str = "";
			$(uploadResultArr).each(
					function(i, obj) {
						//str += "<li>" + obj.fileName + "</li>";
						var fileCallPath = encodeURIComponent(obj.uploadPath
								+ "/s_" + obj.uuid + "_" + obj.fileName);
						str += '<li><img src="/display?fileName='
								+ fileCallPath + '"></li>';
					});
			uploadResult.append(str);
		}//showUploadFile
		
		uploadResult.on("click", "span", function(){
			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			console.log(targetFile);
			$.ajax({	//삭제된다해도 화면은 유지해야하니까 ajax씀
				url:'/deleteFile',
				data:{fileName:targetFile, type:type},
				dataType:'text',
				type:'post',
				success:function(result){
					alert(result);
				}
			});
			
		});

		$(function() {
			var cloneObj = $(".uploadDiv").clone();
			$("#uploadBtn").on("click", function() {
				var formData = new FormData();
				var inputFile = $("input[name='uploadFile']");
				var files = inputFile[0].files;
				console.log(files);
				for (var i = 0; i < files.length; i++) {
					if (!checkExtension(files[i].name, files[i].size)) {
						return false;
					}
					formData.append("uploadFile", files[i]);
				}
				$.ajax({
					url : 'uploadAjaxAction',
					processData : false,
					contentType : false,
					data : formData,
					type : 'post',
					dataType : 'json',
					success : function(result) {
						console.log(result);
						showUploadFile(result); //함수 호출
						$(".uploadDiv").html(cloneObj.html()); //초기화(파일 업로드 후에 파일선택에 선택된 파일 없다고 뜸)
					}
				}); //end $.ajax
			});
		});
	</script>
</body>
</html>