<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- tag library 선언 : c tag --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common-template.jsp" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="<c:url value='/resources/js/scripts.js'/>"></script>
<script type="text/javascript">

	//jQuery event(click) 처리 
	$(document).ready(function(){
		
		/** Summernote HTML Editor
		<textarea class="summernote form-control" data-height="200"></textarea>
		 ***************************** **/
		var _summernote = jQuery('textarea.summernote');		
		if(_summernote.length > 0) {
			
//			loadScript('http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js', function() {
			loadScript(plugin_path + 'editor.summernote/summernote.js', function() {		
				if(jQuery().summernote) {
	
					_summernote.each(function() {	
						var _lang = jQuery(this).attr('data-lang') || 'ko_KR';
	
						if(_lang != 'en-US') { // Language!
						alert(_lang);
							loadScript(plugin_path + 'editor.summernote/lang/summernote-'+_lang+'.js');
						}	
						jQuery(this).summernote({
							height: jQuery(this).attr('data-height') || 200,
							lang: 	jQuery(this).attr('data-lang') || 'ko-KR', // default: 'en-US'
							toolbar: [
							/*	[groupname, 	[button list]]	*/
								['style', 		['style']],
								['fontsize', 	['fontsize']],
								['style', 		['bold', 'italic', 'underline','strikethrough', 'clear']],
								['color', 		['color']],
								['para', 		['ul', 'ol', 'paragraph']],
								['table', 		['table']],
								['media', 		['link', 'picture', 'video']],
								['misc', 		['codeview', 'fullscreen', 'help']]
							]
						});
					});	
				}
			});
		}
		
	    $('#btnUpdate').click(function(event) {
	        event.preventDefault();
	        
	        var title = $('#title').val();
	        
	        var content = $('textarea.summernote').code();

	        if(title.length == 0) {
	            alert("제목을 입력하세요.");
	            $('#title').focus();
	            return;		
	        }

	        if(content.length == 0) {
	            alert("내용을 입력하세요.");
	            _summernote.focus();
	            return;		
	        }

	        $('#content').val(content);
	        
	       

			var moveUrl = '<c:url value="/notice/update.do?" />';
			
			console.log("moveUrl      " + moveUrl);
			
			var comebackUrl = '<c:url value="/notice/read.do" />';
			customAjax(moveUrl, comebackUrl);

	});

}) 

function customAjax(url, responseUrl) {
		
	 	var frm = document.updateForm;
		var formData = new FormData(frm);
		var newForm = new FormData();
		
	
		// 폼 데이터 채우기 (게시글 정보)
		formData.forEach(function(value, key) {
			newForm.append(key, value);
		}); 

	
		// 파일 정보 추가
		const fileInputs = document.querySelectorAll('input[type="file"]');
		const selectedFiles = Array.from(fileInputs)
		    .map(input => input.files[0]) // 파일 입력 요소에서 파일 가져오기
		    .filter(file => file !== undefined); // undefined 값 제외
	
		selectedFiles.forEach(file => {
			// 파일정보 form 에 추가 
			newForm.append("attFiles", file)
		});
	


 
     $.ajax({
    	 anyne: true,
         url : url,
         type : 'PUT',
         data : newForm,
         processData : false,
         contentType : false,
         enctype : 'multipart/form-data',
         success : function (result, textStatus, XMLHttpRequest) {
            console.log("sSibal   	" + result);
                movePage(responseUrl);
           
         },
         error : function (XMLHttpRequest, textStatus, errorThrown) {
               /* alert("작성 에러\n관리자에게 문의바랍니다."); */
             console.log("작성 에러\n" + XMLHttpRequest.responseText);
         }
	});
} // func customAjax End 


function deleteFile(fileIdx, boardSeq, title, content, memberNick) {
	console.log(fileIdx, boardSeq, title);
	
	if ("${sessionScope.memberId}" != null) {
	    if(confirm("첨부파일을 삭제하시겠습니까?")) {
	        let deleteLink = '/notice/deleteAttFile.do?fileIdx='+ fileIdx + '&boardSeq=' + boardSeq;
	        let updateLink = '/notice/goToUpdate.do?boardSeq=' +
	            boardSeq + '&title=' + title + 
	            '&content=' + content + 
	            '&memberNick=' + memberNick + 
	            '&hasFile=Y' 
	            '&currentPage=' + 1;
	        /* movePage(deleteLink, updateLink); */
	        
	        $.ajax({
	            url: deleteLink,
	            type: 'POST',
	            data: {
	                fileIdx: fileIdx,
	                boardSeq: boardSeq
	            },
	            success: function(response) {
	                console.log('File deleted successfully');
	                // 필요한 경우 추가 작업 수행
	                // 예: 삭제된 파일에 대한 UI 업데이트 등
	                // 페이지 이동 없이 그대로 유지
	            },
	            error: function(xhr, status, error) {
	            	console.log("Request Headers: ", JSON.stringify(xhr.getAllResponseHeaders()));
	                console.error('Error deleting file:', error);
	            }
	        });
	    }
	}
}
//func deletefile

</script>

</head>
<body>
	<!-- -->
	<section>
		<div class="container">
			<h3></h3>
			<div class="row">
				<div class="col-md-12 col-sm-12">
					<!-- Useful Elements -->
					<div class="card card-default">
						<div class="card-heading card-heading-transparent">
							<h2 class="card-title">게시글 수정</h2>
						</div>
						<div class="card-block">
							<form name="updateForm" class="validate" data-success="Sent! Thank you!" data-toastr-position="top-right">
								<input type="hidden" name="memberId" value="${ sessionScope.memberId }"/>
								<input type="hidden" name="memberIdx" value="${ sessionScope.memberIdx }"/>
								<input type="hidden" name="typeSeq" value="${ boardMember.typeSeq}"/>
								<input type="hidden" name="boardSeq" value="${ boardMember.boardSeq }"/>
								<input type="hidden" name="hasFile" value="${ boardMember.hasFile }"/>
									
								<fieldset>
									<!-- required [php action request] -->
									<input type="hidden" name="action" value="contact_send" />	
									<div class="row">
										<div class="col-md-8 col-sm-8">
											<label>제목</label>
											<c:if test="${not empty boardMember}">
											    <input type="text" name="title" id="title" value="${boardMember.title}" class="form-control required">
										</div>
										
										<div class="col-md-4 col-sm-4">
											<label>작성자</label>
											<input type="text" id="memberNick" name="memberNick" value="${boardMember.memberNick }" 
											class="form-control" readonly="readonly">
										</div>
										
									</div>
	
									<div class="row">
										<div class="col-md-12 col-sm-12">
											<label>내용</label>
											<textarea class="summernote form-control" data-height="200" data-lang="en-US" name="content" id="content" rows="4">
												${ boardMember.content}
											</textarea>
											</c:if>
									
										</div>
									</div>
	
									<div class="row">
										<div class="col-md-12">
											<label>
												첨부파일
											</label>

											<!-- custom file upload -->												
											<!-- 첨부파일없으면  -->
											<c:if test="${empty attFiles}"> 
											<div class="fancy-file-upload fancy-file-primary">
												<i class="fa fa-upload"></i>
												<input type="file" class="form-control" onchange="jQuery(this).next('input').val(this.value);" />
												<input type="text" class="form-control" placeholder="no file selected" readonly="" />
												<span class="button">Choose File</span>
											</div>
											<div class="fancy-file-upload fancy-file-primary">
												<i class="fa fa-upload"></i>
												<input type="file" class="form-control" onchange="jQuery(this).next('input').val(this.value);" />
												<input type="text" class="form-control" placeholder="no file selected" readonly="" />
												<span class="button">Choose File</span>
											</div>
											<small class="text-muted block">Max file size: 10Mb (zip/pdf/jpg/png)</small>
											</c:if>
										<!-- 파일있으면  -->	
										<c:forEach items="${attFiles}" var="file" varStatus ="f" > 
											<div class="row">	
												<div class="col-md-8 col-sm-8">
													<div class="fancy-file-upload fancy-file-primary" >
														<i class="fa fa-upload"></i>
														
														<input type="text" id="fileInfo" class="form-control" placeholder="${file.fileName} (${file.fileSize} bytes)" readonly="" />
														<!-- 파일 정보를 가져오게 하기 위해서 설정. -->
														<div style="display: none;">
														    <input type="text" name="attFiles" id="fileName" value="${file}" readonly="" />
														    <input type="text" id="fileSize" value="${file.fileSize}" readonly="" />
														</div>
														
													</div>
	
												</div>
												<div class="col-md-4 col-sm-4">	
													<%-- <a href="javascript:movePage('/board/deleteAttFile.do?fileIdx=${file.fileIdx }&boardSeq=${file.boardSeq }')"> --%>
													<button type="button" class="btn btn-primary" onclick="deleteFile(${file.fileIdx} , ${file.boardSeq}, '${boardMember.title }', 
													'${boardMember.content }', '${boardMember.memberNick }');">
														첨부파일 삭제
													</button>
													
													</a>
												</div>					
											</div>
	</c:forEach>
										</div>
									</div>
								</fieldset>

								<div class="row">
									<div class="col-md-12 text-right">
										<a href="<c:url value='/notice/list.do?page=${currentPage }' />">
											<button type="button" class="btn btn-primary">
												목록
											</button>
										</a>
										
										<button type="button" class="btn btn-primary" id="btnUpdate">
											수정
										</button>
										
									</div>
								</div>
							</form>
						</div>

					</div>
					<!-- /Useful Elements -->
				</div>
			</div>
		</div>
	</section>
	<!-- / -->

</body>
<jsp:include page="../common-template-footer.jsp" />
</html>