<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- tag library 선언 : c tag --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
					
		$('#btnUpdate').on('click', function(){ 
			// 온클릭시 굳이 function doWrite() 펑션 선언,호출하지 말고 바로 종속시켜 기능 먹인다. 
			// 여기서 바로 기능 구현. --> function의 선언을 줄인다.  
			//따로 function 만들게 되면 해당 기능 수행하는 연결점 찾기 어렵다.. (펑션이름 일일이 검색해야함) 
			//여기서는 id= btnWrite 를 onClick 시 이 기능을 수행한다. 라고 바로 연결지어 확인가능.. 

			//jQuery  #[id]
			var title = $('#title').val();

			if(title.length == 0){
				alert("제목을 입력하세요.");
				$('#title').focus();
				
				return;		
			}
			//ck editor 가 textarea 위에 씌워져있어서 ck editor 불러와야함. 
			var content = _summernote.code();
			if(content.length < 0 ){
				alert("내용을 입력하세요.");
				_summernote.focus();
				return;		
			}
			$('#content').val(content);
			
			customAjax("<c:url value='/notice/update.do' />", "/notice/read.do?boardSeq=${boardInfo.board_seq}");
		
		}); //#btnUpdate end 		
}); //ready End 

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
         success : function (result, textStatus, XMLHttpRequest) {
             var data = $.parseJSON(result);
             
             console.log('data' + data);
             console.log('boardSeq' + data.boardSeq);
             
             alert(data.msg);
             var boardSeq = data.boardSeq;
             if(data.result == 1){
                movePage(this, responseUrl);
             } else {
               window.location.href="<c:url value='/index.do'/>";
             }
         },
         error : function (XMLHttpRequest, textStatus, errorThrown) {
               alert("작성 에러\n관리자에게 문의바랍니다.");
             console.log("작성 에러\n" + XMLHttpRequest.responseText);
         }
	});
} // func customAjax End 

function deleteFile(fileIdx, boardSeq){
	  if("${sessionScope.memberId}" != null) {
       	 if(confirm("첨부파일을 삭제하시겠습니까?")){
        	// code here
       	}	       
  	}
}//func deletefile

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
							<h2 class="card-title">공지 글 수정</h2>
						</div>
						<div class="card-block">
							<form name="updateForm" class="validate" method="post" enctype="multipart/form-data" data-success="Sent! Thank you!" data-toastr-position="top-right">
								<input type="hidden" name="memberId" value="${ sessionScope.memberId }"/>
								<input type="hidden" name="memberIdx" value="${ sessionScope.memberIdx }"/>
								<input type="hidden" name="typeSeq" value="${ boardInfo.type_seq}"/>
								<input type="hidden" name="boardSeq" value="${ boardInfo.board_seq }"/>
								<input type="hidden" name="hasFile" value="${ boardInfo.has_file }"/>
									
								<fieldset>
									<!-- required [php action request] -->
									<input type="hidden" name="action" value="contact_send" />	
									<div class="row">
										<div class="col-md-8 col-sm-8">
											<label>제목</label>
											<input type="text" name="title" id="title" value="타이틀" class="form-control required">
										</div>
										
										<div class="col-md-4 col-sm-4">
											<label>작성자</label>
											<input type="text" id="memberNick" name="memberNick" value="작성자" 
											class="form-control" readonly="readonly">
										</div>
										
									</div>
	
									<div class="row">
										<div class="col-md-12 col-sm-12">
											<label>내용</label>
											<textarea class="summernote form-control" data-height="200" data-lang="en-US" name="content" id="content" rows="4">
												내용내용내용내용내용내용내용
											</textarea>
									
										</div>
									</div>
	
									<div class="row">
										<div class="col-md-12">
											<label>
												첨부파일
											</label>

											<!-- custom file upload -->												
		<c:if test="${empty attFiles}"> <!-- 첨부파일없으면  -->
											<div class="fancy-file-upload fancy-file-primary">
												<i class="fa fa-upload"></i>
												<input type="file" class="form-control" name="attFiles" onchange="jQuery(this).next('input').val(this.value);" />
												<input type="text" class="form-control" placeholder="no file selected" readonly="" />
												<span class="button">Choose File</span>
											</div>
											<div class="fancy-file-upload fancy-file-primary">
												<i class="fa fa-upload"></i>
												<input type="file" class="form-control" name="attFiles" onchange="jQuery(this).next('input').val(this.value);" />
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
														
														<input type="text" class="form-control" placeholder="${file.file_name} (${file.file_size} bytes)" readonly="" />
													</div>
	
												</div>
												<div class="col-md-4 col-sm-4">	
													<button type="button" class="btn btn-primary" onclick="deleteFile(${file.file_idx} , ${file.board_seq});">
														첨부파일 삭제
													</button>
												</div>					
											</div>
	</c:forEach>
										</div>
									</div>
								</fieldset>

								<div class="row">
									<div class="col-md-12 text-right">
										<a href="javascript:movePage(null, '/notice/list.do?')">
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
</html>