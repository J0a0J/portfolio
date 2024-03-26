<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
/* 폼 요소 정렬 */
#commentSubmitForm {
    display: flex;
    flex-direction: row;
    align-items: center;
    width: 500px; /* 폼 너비 조절 */
}


.form-group {
    display: flex;
    flex-direction: row;
    align-items: center;
    margin-right: 10px;
}


label {
    margin-right: 10px; 
    font-weight: bold;
}

/* 입력 필드 스타일 */
input[type="text"],
textarea {
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

#commentForm textarea,
#commentForm button {
	vertical-align: top;
    height: 60px; 
}
span.comment-nick {
	display: inline-block;
    width: 200px; 
    
}
.comment-container > span {
	margin-right: 5%;
}
.comment-date {
    float: right;
}


</style>
<jsp:include page="../common-template.jsp" />


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="<c:url value='/resources/js/scripts.js'/>"></script>

<script type="text/javascript">
	
	var currentUrl = window.location.href;
	var ctx = "${pageContext.request.contextPath}";
	

	$(document).ready(	function() {
		var url = ctx + '/board/read.do?page=' + ${page} + '&boardSeq=' + ${boardSeq};
		history.pushState({}, '', url);
		
		// 댓글 시간 계산 
		function calculateTimeDifference(postTime) {
			  // 날짜 형식 변환 (예: YYYY-MM-DD HH:MM:SS)
			  const date = moment(postTime, "YYYY-MM-DD HH:mm");
			  console.log("data   " + date);

			  // 현재 시간과의 차이 계산
			  const now = moment();
			  const timeDiff = now.diff(date, "minutes");

			  // 분 단위로 표시
			  if (timeDiff < 60) {
			    return timeDiff + "분 전";
			  } else if (timeDiff < 1440) { // 24시간(하루) 이내인 경우
			    return Math.floor(timeDiff / 60) + "시간 전";
			  } else { // 하루 이상인 경우
			    return Math.floor(timeDiff / 1440) + "일 전";
			  }
			}
		// 댓글 작성 시간 불러오기 
		const comments = document.querySelectorAll('.comment-date');
		// 댓글 시간 변경 
		for (const comment of comments) {
		  const postTime = comment.getAttribute("data-post-time");
		  const timeDiff = calculateTimeDifference(postTime); // 시간 차이 계산
		  // 시간 차이를 해당 요소에 표시
	      comment.textContent = timeDiff;
		}
		
		// 로그인 하지 않고 댓글 작성하려고 하면 로그인 페이지로 이동 
		$('#noComment').on('click', function() {
			window.location.href = ctx + "/member/goLoginPage.do";
		})

		$('#btnUpdate').on('click', function() {
			var frm = document.readForm;
			var formData = new FormData(frm);
			// code here
		});

		$('#btnDelete').on('click',function() {
			if (confirm("삭제하시겠습니까?")) {
				customAjax(
						"<c:url value='/board/delete.do?boardSeq=${boardSeq}' />",
						"/board/list.do?page=${currentPage}");
			}
		});
		
		// 댓글 작성 버튼 클릭 시 
		$('#btnReply').on('click', function() {
		    // commentContent의 값을 가져와서 변수에 저장
		    var comment = $('#commentContent').val();
		    
		    // sessionScope 가 존재하지 않는 경우를 위해 스트링으로.
		    var memberIdxStr = "${sessionScope.memberIdx}";
		    // 존재한다면 다시 정수 타입으로 변환. 
		    var memberIdx = memberIdxStr !== "" ? parseInt(memberIdxStr) : null;
		    var commentInfo = {
		        "replyContent": comment,
		        "memberIdx": memberIdx,
		        "memberNick": "${sessionScope.memberNick}",
		        "boardSeq": ${boardSeq}
		    };

		    $.ajax({
		        url: ctx + "/board/comment.do",
		        data: JSON.stringify(commentInfo),
		        type: 'POST',
		        dataType: "json",
		        contentType: "application/json",
		        success: function(result, textStatus, XMLHttpRequest) {
		            movePage(url);
		            location.reload();
		        },
		        error: function(XMLHttpRequest, textStatus, errorThrown) {
		            alert("작성 에러\n관리자에게 문의바랍니다.");
		            console.log("작성 에러\n" + XMLHttpRequest.responseText);
		        }
		    });
		});
		

	});//ready

	function customAjax(url, responseUrl) {
		var frm = document.updateForm;
		var formData = new FormData(frm);
		$.ajax({
			url : url,
			data : formData,
			type : 'POST',
			dataType : "text",
			processData : false,
			contentType : false,
			success : function(result, textStatus, XMLHttpRequest) {
				var data = $.parseJSON(result);

				alert(data.msg);
				var boardSeq = data.boardSeq;

				movePage(responseUrl);

			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert("작성 에러\n관리자에게 문의바랍니다.");
				console.log("작성 에러\n" + XMLHttpRequest.responseText);
			}
		});
	} // func customAjax End
	
</script>

</head>
<body>
	<section>
	<div class="container">
		<div class="row">
			<!-- LEFT -->
			<div class="col-md-12 order-md-1">
				<form name="readForm" class="validate" method="post"
					enctype="multipart/form-data" data-success="Sent! Thank you!"
					data-toastr-position="top-right">
					<c:if test="${not empty boardList }">
						<input type="hidden" name="boardSeq"
							value="${boardList.boardSeq }" />
						<input type="hidden" name="typeSeq" value="${boardList.typeSeq }" />
				</form>
				<!-- post -->
				<div class="clearfix mb-80">
					<div class="border-bottom-1 border-top-1 p-12">
						<span class="float-right fs-10 mt-10 text-muted">${boardList.createDtm}</span>
						<center>
							<strong>${boardList.title}</strong>
						</center>
					</div>
					<div class="block-review-content">
						<div class="block-review-body">
							<div class="block-review-avatar text-center">
								<div class="push-bit">
									<img src="resources/images/_smarty/avatar2.jpg" width="100"
										alt="avatar">
									<!--  <i class="fa fa-user" style="font-size:30px"></i>-->
								</div>
								<small class="block">${boardList.memberNick }</small>
								<hr />
							</div>
							<p>${boardList.content }</p>
							</c:if>
							<!-- 컬렉션 형태에서는 (list) items  -->

							<!-- 첨부파일 없으면  -->
							<c:if test="${empty attFiles}">
								<tr>
									<th class="tright">#첨부파일 다운로드 횟수</th>
									<td colspan="6" class="tright"></td>
									<!-- 걍빈칸  -->
								</tr>
							</c:if>

							<!-- 파일있으면  -->
							<c:forEach items="${attFiles}" var="file" varStatus="f">
								</tr>
								<tr>
									<th class="tright">첨부파일 ${ f.count }</th>
									<td colspan="6" class="tleft"><c:choose>
											<c:when test="${file.saveLoc == null}">
												${file.fileName} (서버에 파일을 찾을 수 없습니다.)
											</c:when>

											<c:otherwise>
												<a
													href="<c:url value='/board/download.do?fileIdx=${file.fileIdx}'/>">
													${file.fileName} ( ${file.fileSize } bytes) </a>
												<br />
											</c:otherwise>
										</c:choose></td>
								</tr>
							</c:forEach>
						</div>
						<hr />
						<div id="commentForm">
							<form id="commentSubmitForm">
							<c:if test="${not empty sessionScope.memberNick}">
								<label for="commentName">${sessionScope.memberNick }</label> 
								
								<br> 
								<textarea id="commentContent" name="commentContent" rows="4" 
									placeholder="댓글을 입력해주세요. " cols="50" required></textarea>
								<br> <br>
								<button type="button" class="btn btn-primary" id="btnReply">댓글 작성</button>
							</c:if>
							<c:if test="${empty sessionScope.memberNick}">
								<textarea id="noComment" name="commentContent" rows="4" 
									placeholder="로그인 후 댓글 작성 가능합니다. " cols="50" required></textarea>

							</c:if>
							</form>
						</div>
						<div>
							<c:if test="${not empty comments }">
								<div class="comment-container">
									<c:forEach items="${comments }" var="comment">
										<div class="comment-info">
											<hr/>
											<span class="commnet-nick"><b>${comment.memberNick }</b></span>
											<span class="comment-content">${comment.replyContent }</span>
											<span class="comment-date" data-post-time="${comment.createDtm }"></span>
										</div>
									</c:forEach>
								</div>
								<hr/>
							</c:if>
						</div>
						<div class="row">
							<div class="col-md-12 text-right">
								<c:if test="${not empty boardList }">
									<!-- Dao에서 read를 통해 수정을 했었는데 그러면 조회수가 2번 더해지기 때문에 -->
									<!-- 값을 받아오는 걸로 변경. -->
									<a
										href="<c:url value='/board/goToUpdate.do?boardSeq=${boardList.boardSeq}&title=${boardList.title}&content=${boardList.content}&memberNick=${boardList.memberNick }&hasFile=${boardList.hasFile }&page=${page }' />">
								</c:if>
								<button type="button" class="btn btn-primary">
									<i class="fa fa-pencil"></i> 수정
								</button>
								</a>
								<button type="button" class="btn btn-primary" id="btnDelete">
									삭제</button>

								<c:choose>
									<c:when test="${empty page}">
										<a href="<c:url value='/board/list.do?page=1' />">
											<button type="button" class="btn btn-primary">목록</button>
										</a>
									</c:when>
									<c:otherwise>
										<a href="<c:url value='/board/list.do?page=${page}' />">
											<button type="button" class="btn btn-primary">목록</button>
										</a>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</section>
</body>
<jsp:include page="../common-template-footer.jsp" />
</html>