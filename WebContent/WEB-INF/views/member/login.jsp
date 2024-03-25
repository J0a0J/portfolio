<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common-template.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	
	var ctx = "${pageContext.request.contextPath}";
	
	$(document).ready(function(){
		$('#msgDiv').hide();
		$("#loading-div-background").css({ opacity: 1 });
		
		$('#btnLogin').click(function(){
			if( $('#memberId').val() == '' || $('#memberPw').val() == '' ){
				var msgTag = $('<strong>').text("모든 항목은 필수입니다.");
				$('#msgDiv').html(msgTag).show();
				return;
			}
			
			// overlay 보이기
			$("#loading-div-background").css({'z-index' : '9999'}).show();
			var formData = new FormData(document.loginForm);
			$.ajax({
				url: ctx + '/member/login.do',
				type: "POST",
				data: formData,
				dataType:'TEXT',
				cache: false,
				processData: false,
				contentType: false,
				success: function(data, textStatus, jqXHR) {
					data = $.parseJSON(data);
					console.log(data);
					if(data.msg != undefined && data.msg != ''){
						var msgTag = $("<strong>").text(data.msg);
						$('#msgDiv').html(msgTag).show();
						$("#loading-div-background").hide();	// overlay 숨기기
					}
					else {
						window.location.href = ctx + data.nextPage;
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					$("#loading-div-background").hide();	// overlay 숨기기					
					console.log(jqXHR);
					console.log(textStatus);
					console.log(errorThrown);
				}
			});
		});
	});
</script>
</head>
<body>
	<!-- -->
	<section>
		<div class="container">
<!-- 			<h2>LOGIN</h2> -->
			<div class="row">
	
				<div class="col-md-6 offset-md-3">
	
					<!-- ALERT -->
					<div id="msgDiv" class="alert alert-mini alert-danger mb-10"></div>
					<!-- /ALERT -->
						
					<div class="box-static box-border-top p-30">
						<div class="box-title mb-30">
							<h2 class="fs-20">LOGIN</h2>
						</div>
	
						<form class="m-0" method="post" name="loginForm" autocomplete="off">
							<div class="clearfix">
								
								<!-- Email -->
								<div class="form-group">
									<input type="text" id="memberId" name="memberId" class="form-control" placeholder="USER ID" required="">
								</div>
								
								<!-- Password -->
								<div class="form-group">
									<input type="password" id="memberPw" name="memberPw" class="form-control" placeholder="Password" required="">
								</div>
									
							</div>
							
							<div class="row">
								<%--
								<div class="col-md-6 col-sm-6 col-6">
									<!-- Inform Tip -->                                        
									<div class="form-tip pt-20">
										<a class="no-text-decoration fs-13 mt-10 block" href="#">Forgot Password?</a>
									</div>
								</div>
								 --%>
								
<!-- 								<div class="col-md-6 col-sm-6 col-6 text-right"> -->
								<div class="col-md-12 col-sm-12 col-12 text-right">
									<button type="button" id="btnLogin" class="btn btn-primary">OK, LOG IN</button>
								</div>
							</div>
							
						</form>
	
					</div>
					
					<div class="mt-30 text-center">
						<a href="javascript:movePage('/member/goRegisterPage.do')"><strong>Create Account</strong></a>
					</div>
	
				</div>
			</div>
			
		</div>
	</section>
	<!-- / -->
	<!-- overlay html start -->
	<div id="loading-div-background">
	      <div id="loading-div" class="ui-corner-all">
	           <img style="height:32px;width:32px;margin:30px;" src="<c:url value='/resources/please_wait.gif'/>" alt="Loading.."/>
	           <br>
	           PROCESSING. PLEASE WAIT...
	      </div>
	</div>
	<!-- overlay html end -->
</body>
<jsp:include page="../common-template-footer.jsp" />
</html>