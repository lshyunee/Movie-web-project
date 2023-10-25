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

#heart{
	width : 50px;
	height : 50px;
}

</style>
<section class="py-5">
	<div class="container px-4 px-lg-5 my-5">
		<div class="row gx-4 gx-lg-5 align-items-center">
			<div class="col-md-6">
				<div class="uploadResult">
					<ul>

					</ul>
				</div>
			</div>
			<div class="col-md-5">
				<div class="pre">
					<a href="http://www.youtube.com/results?search_query=${info.title}"
						target="_blank"><button class="btn btn-default">
							<img src="/resources/image/Golink.jpg" alt="" width="40"
								height="40">예고편 보러가기
						</button></a>
				<sec:authorize access="isAuthenticated()">
					<a class="btn pull-right heart"> <img id="heart" src="">
					</a>
				</sec:authorize>
				</div>
				<br>
				<div class="small mb-1">${info.genre}</div>
				<h1 class="display-5 fw-bolder mt-4">${info.title}</h1>
				<div class="fs-5 mb-5">
					<div class="d-flex  small text-warning mb-2">
						<c:forEach var="plus" begin="1" end="${info.rating}" step="1">
							<img src="/resources/image/cruncky.png" width="30px">&nbsp;
									</c:forEach>
						<c:forEach var="minus" begin="${info.rating}" end="4" step="1">
							<img src="/resources/image/dark.png" width="30px"> &nbsp;
									</c:forEach>
					</div>
				</div>
				<p class="lead">${info.content}</p>
				<div class="d-flex">
					<p class="me-5 mt-5">
						개봉 날짜: <b>${info.regdate}</b>
					</p>
					<br>
					<p class="mt-5">
						<b>감독: ${info.director}</b>
					</p>
				</div>
				<div class="d-flex">
					<p class="me-5 mt-5">
						작성자: <b>${info.writer}</b>
					</p>
					<p class="me-5 mt-5">
						작성 날짜: <b><fmt:formatDate pattern='yyyy-MM-dd'
								value='${info.uploaddate}' /></b>
					</p>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="mb-5 mb-md-0 my-5">
				<sec:authentication property="principal" var="pinfo" />
				<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username eq info.writer}">
						<button class="btn btn-primary modBtn">수정</button>
					</c:if>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<button class="btn btn-primary modBtn">수정</button>
				</sec:authorize>
				<button class="btn btn-primary listBtn">목록</button>
			</div>
			<form id="actionForm" action="/movie/list" method="get">
				<input type="hidden" name="mno" value="${info.mno}"> <input
					type="hidden" name="pageNum" value="${cri.pageNum}"> <input
					type="hidden" name="amount" value="${cri.amount}"> <input
					type="hidden" name="keyword" value="${cri.keyword}"> <input
					type="hidden" name="type" value="${cri.type}">
			</form>
		</div>
		<div>
			<br> <br>
		</div>
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-comments fa-fw"></i> #댓글
						<sec:authorize access="isAuthenticated()">
							<button id='addReplyBtn'
								class='btn btn-primary btn-xs pull-right'>댓글 작성</button>
						</sec:authorize>
					</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<ul class="chat">

						</ul>
					</div>
					<!-- /.panel-body -->
					<div class="panel-footer"></div>
					<!-- /.panel-footer -->
				</div>
			</div>
		</div>
	</div>
</section>

<!-- Modal -->
<div class="modal" id="myModal" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label> <input class="form-control" name="reply"
						value="New Reply!!">
				</div>
				<div class="form-group">
					<label>Replyer</label> <input class="form-control" name="replyer"
						value="replyer">
				</div>
				<div class="form-group">
					<label>Reply Date</label> <input class="form-control"
						name="replyDate" value="2022-11-24">
				</div>
			</div>
			<div class="modal-footer">
				<!-- 
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<button id="modalModBtn" type="button" class="btn btn-warning modalModBtn"
						style="border-radius: 15px;">Modify</button>
					<button id="modalRemoveBtn" type="button" class="btn btn-danger modalRemoveBtn">Remove</button>
				</sec:authorize>
			 -->
				<button id="modalModBtn" type="button" class="btn btn-warning"
					style="border-radius: 15px;">Modify</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>
				<button id="modalCloseBtn" type="button" class="btn btn-default"
					style="border-radius: 15px;">Close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<script src="https://code.jquery.com/jquery-3.4.1.js"
	type="text/javascript"></script>
<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        var heartval = '${heart}';
        if(heartval>0) {
            console.log(heartval);
            $("#heart").prop("src", "/resources/image/heart2.png");
            $(".heart").prop('name',heartval)
        }
        else {
            console.log(heartval);
            $("#heart").prop("src", "/resources/image/heart.png");
            $(".heart").prop('name',heartval)
        }
        $(".heart").on("click", function () {
            var that = $(".heart");
            var sendData = {'userid' : '<sec:authentication property="principal.username"/>','heart':'${heart}','mno' : '${info.mno}'};
            $.ajax({
                url :'/movie/heart',
                type :'POST',
                data : sendData,
                success : function(data){
                    that.prop('name',data);
                    if(data==1) {
                        $('#heart').prop("src","/resources/image/heart2.png");
                    }
                    else{
                        $('#heart').prop("src","/resources/image/heart.png");
                    }
                }
            });
        });
    });
</script>
<script>
	$(function() {
		var mno = '${info.mno}';
		$.getJSON("/movie/getAttach",{mno : mno},function(arr) {
			console.log(arr);
			var str = "";
			$(arr).each(function(i, obj) {
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
				str += '<li data-path="'+obj.uploadPath+'" data-uuid="'+obj.uuid+'" data-filename="'+obj.fileName+'">';
				str += '<img src="/display?fileName=' + fileCallPath + '"></li>';
			});
			$(".uploadResult ul").html(str);
		});
	});
</script>
<script type="text/javascript">
	console.log("==========");
	console.log("JS TEST");

	var mnoValue = '${info.mno}';

	replyService.getList({
		mno : mnoValue,
		page : 1
	}, function(list) {
		for (var i = 0, len = list.length || 0; i < len; i++) {
			console.log(list[i]);
		}
	});
</script>

<script>
	$(function() {
		var mnoValue = '${info.mno}';
		var replyUL = $(".chat");
		showList(1);
		function showList(page) {replyService.getList({mno : mnoValue, page : page || 1},function(replyCnt, list) {
			if (page == -1) {
				pageNum = Math.ceil(replyCnt / 10.0);
				showList(pageNum);
				return;
			}

			var str = "";
			if (list == null || list.length == 0) {
				replyUL.html("");
				return;
			}
			for (var i = 0, len = list.length || 0; i < len; i++) {
				//console.log(list[i]);
				str += '<li class="left clearfix" data-rno="' + list[i].rno + '">';
				str += '<div>';
				str += '<div class="header">';
				str += '<strong class="primary-font">' + list[i].replyer + '</strong>';
				str += '<small class="pull-right text-muted">' + replyService.displayTime(list[i].replyDate) + '</small>';
				str += '</div>';
				str += '<p>' + list[i].reply + '</p>';
				str += '</div>';
				str += '</li>';
			}//end for
			replyUL.html(str);
			showReplyPage(replyCnt);
		});

		}//end showList

		var pageNum = 1;
		var replyPageFooter = $(".panel-footer");
		function showReplyPage(replyCnt) {
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum - 9;
			var prev = startNum != 1;
			var next = false;
			if (endNum * 10 >= replyCnt) {
				endNum = Math.ceil(replyCnt / 10.0);
			}
			if (endNum * 10 < replyCnt) {
				next = true;
			}

			var str = '<ul class="pagination pull-right">';
			if (prev) {
				str += '<li class="paginate_button previous"><a href="'
						+ (startNum - 1) + '">Previous</a></li>';
			}
			for (var i = startNum; i <= endNum; i++) {
				var active = (pageNum == i) ? 'active' : '';
				str += '<li class="paginate_button '+active+'"><a href="'+i+'">'
						+ i + '</a></li>';
			}
			if (next) {
				str += '<li class="paginate_button next"><a href="'
						+ (endNum + 1) + '">Next</a></li>';
			}
			str += '</ul>';
			replyPageFooter.html(str);
		}//showReplyPage

		replyPageFooter.on("click", "li a", function(e) {
			e.preventDefault();
			console.log("page click");
			var targetPageNum = $(this).attr("href");
			console.log("targetPageNum:" + targetPageNum);
			pageNum = targetPageNum;
			showList(pageNum);
		}); //번호 클릭시 새로운 댓글 출력

		var modal = $(".modal");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");

		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		
		var replyer = null;
		
		<sec:authorize access="isAuthenticated()">
			replyer='<sec:authentication property="principal.username"/>';
		</sec:authorize>
		
		var csrfHeaderName="${_csrf.headerName}";
		var csrfTokenValue="${_csrf.token}";

		$(document).ajaxSend(function(e, xhr, options){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});
		
		$("#modalCloseBtn").click(function() {
			modal.modal("hide");
		});

		$("#addReplyBtn").click(function() {
			modal.find("input").val("");
			modal.find("input[name='replyer']").val(replyer);
			modalInputReplyer.attr("readonly", "readonly");
			modalInputReplyDate.closest("div").hide();
			modal.find('button[id!="modalCloseBtn"]').hide();
			modalRegisterBtn.show();
			modal.modal('show');
		});

		
		modalRegisterBtn.on("click", function(e) {
			var reply = {
				reply : modalInputReply.val(),
				replyer : modalInputReplyer.val(),
				mno : mnoValue
			};
			replyService.add(reply, function(result) {
				alert(result);
				modal.find("input").val("");
				modal.modal("hide");
				showList(-1);
			});
		});//modalRegisterBtn

		replyUL.on("click", "li", function() {
			var rno = $(this).data("rno");
			console.log(rno);
			replyService.get(rno, function(data) {
				modalInputReply.val(data.reply);
				modalInputReplyer.val(data.replyer)
						.attr("readonly", "readonly");
				modalInputReplyDate.val(
						replyService.displayTime(data.replyDate)).attr(
						"readonly", "readonly");
				modalRegisterBtn.hide();
				modalModBtn.hide();
				modalRemoveBtn.hide();
				modal.data("rno", data.rno);
				modal.modal("show");
				
			var originalReplyer = modalInputReplyer.val();
				if(replyer == originalReplyer){
					modalModBtn.show();
					modalRemoveBtn.show();
				} else if (replyer == 'admin'){
					modalModBtn.show();
					modalRemoveBtn.show();
				}
			});

			modalModBtn.on("click", function(e) {
				var originalReplyer = modalInputReplyer.val();
				var reply = {
					rno : modal.data("rno"),
					reply : modalInputReply.val(),
					replyer : originalReplyer,
					mno : mnoValue
				};
				
				if(!replyer){
					alert("로그인후 수정이 가능합니다.");
					modal.modal("hide");
					return;
				}
				
				console.log("Original Replyer: " + originalReplyer);
				
				replyService.update(reply, function(result) {
					alert(result);
					modal.modal("hide");
					showList(pageNum)
				});
				location.reload();
			});

			modalRemoveBtn.on("click", function(e) {
				var rno = modal.data("rno");
				console.log("RNO: " + rno);
				
				if(!replyer){
					alert("로그인후 삭제가 가능합니다.");
					modal.modal("hide");
					return;
				}
				
				var originalReplyer = modalInputReplyer.val();
				
				console.log("Original Replyer: " + originalReplyer);
				
				
				replyService.remove(rno, originalReplyer, function(result) {
					alert(result);
					modal.modal("hide");
					showList(pageNum);
				});
				location.reload();
			});//remove

		});

	});//end
</script>
<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	var actionForm = $("#actionForm");
	
	$(".listBtn").click(function(e) {
		e.preventDefault();
		actionForm.find('input[name="mno"]').remove();
		actionForm.submit();
	});
	$(".modBtn").click(function(e) {
		e.preventDefault();
		actionForm.attr("action", "/movie/modify");
		actionForm.submit();
	});
	
	/*
	$(".addLike").click(function(e) {
		e.preventDefault();
		actionForm.attr("action", "/movie/likeList");
		actionForm.attr("method", "POST");
		actionForm.submit();
	});
	
	$("form .btn").on("click", function(e) {
		e.preventDefault();
		var operation = $(this).data("oper");
		console.log(operation);
		if (operation === 'remove') {
			actionForm.attr({
				"action" : "/movie/heart",
				"method" : "post"
			});
		}});
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(function() {
		var formObj = $("form");
		$("form .addLike").on("click", function(e) {
			e.preventDefault();
			var operation = $(this).data("oper");
			console.log(operation);
			if (operation === 'remove') {
				formObj.attr({
					"action" : "/movie/like",
					"method" : "post"
				});
			} 

			formObj.submit();
		});
	
	});
	*/
</script>

<%@ include file="../includes/footer.jsp"%>