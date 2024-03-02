<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="<c:url value='/resources/js/scripts.js'/>"></script>

<script type="text/javascript">
$(document).ready(function(){	
	
	$('#btnUpdate').on('click', function(){
		var frm = document.readForm;
		var formData = new FormData(frm);
	    // code here
	});
	
	$('#btnDelete').on('click', function(){		
		if(confirm("삭제하시겠습니까?")){
			// code here
		}
	});
	
});//ready 
</script>

</head>
<body>
	<section>
		<div class="container">
			<div class="row">
				<!-- LEFT -->
				<div class="col-md-12 order-md-1">
					<form name="readForm" class="validate" method="post" enctype="multipart/form-data" data-success="Sent! Thank you!" data-toastr-position="top-right">
						<input type="hidden" name="boardSeq" value ="PK1"/>
						<input type="hidden" name="typeSeq" value ="PK2"/>
					</form>
					<!-- post -->
					<div class="clearfix mb-80">
						<div class="border-bottom-1 border-top-1 p-12">
							<span class="float-right fs-10 mt-10 text-muted">작성일시</span>
							<center><strong>타이틀</strong></center>
						</div>
						<div class="block-review-content">
							<div class="block-review-body">
								<div class="block-review-avatar text-center">
									<div class="push-bit">							
										<img src="resources/images/_smarty/avatar2.jpg" width="100" alt="avatar">
										<!--  <i class="fa fa-user" style="font-size:30px"></i>-->
									</div>
									<small class="block">닉네임</small>		
									<hr />
								</div>
								<p>
									본문 내용
								</p>
							<!-- 컬렉션 형태에서는 (list) items  -->
							
							<!-- 첨부파일 없으면  -->
								<c:if test="${empty attFiles}"> 
									<tr>
										<th class="tright" >#첨부파일 다운로드 횟수</th>
										<td colspan="6" class="tright"> </td> <!-- 걍빈칸  -->
									</tr>
								</c:if>
										
							<!-- 파일있으면  -->				
								<c:forEach items="${attFiles}" var="file" varStatus ="f" >
									</tr>									<tr>
										<th class="tright">첨부파일 ${ f.count }</th>
										<td colspan="6" class="tleft"> 
										<c:choose>
											<c:when test="${file.linked == 0}">
												${file.file_name} (서버에 파일을 찾을 수 없습니다.)
											</c:when>
											
											<c:otherwise>
												<a href="<c:url value='/board/downloadFile.do?fileIdx=${file.file_idx}'/>"> 
												${file.file_name}  ( ${file.file_size } bytes) 
												</a> 
												<br/>
											</c:otherwise>
										</c:choose>
										</td>
									</tr>
								</c:forEach>					
								</div>
							<div class="row">
								<div class="col-md-12 text-right">
							<c:if test="${ true }">				
									<a href="javascript:movePage('/board/goToUpdate.do?boardSeq=PK1')">
							       		 <button type="button" class="btn btn-primary"><i class="fa fa-pencil"></i> 수정</button>
							   		</a>	
									<button type="button" class="btn btn-primary"  id="btnDelete">
											삭제
									</button>
							</c:if>
								
					   		<c:choose>
				        		<c:when test="${empty currentPage}">
					        		<a href="javascript:movePage('/board/list.do')">
							        	<button type="button" class="btn btn-primary">목록</button>
							   		</a>
				        		</c:when>
				        		<c:otherwise>
				        			<a href="javascript:movePage('/board/list.do?page=currentPage')">
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
</html>