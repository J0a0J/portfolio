<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="./common-template.jsp" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
</head>

	<body class="smoothscroll enable-animation">

			
			<%-- 내용 나올 div 시작!!!! --%>

				<!-- -->
			<section>
				<div class="container">
					
					<div class="row">
					
						<div class="col-lg-6 col-md-6 col-sm-6">
							<div class="col-lg-3 col-md-3 col-sm-3" >
								<img class="img-responsive" src="resources/images/_smarty/lazy-loadimg.jpg" width="500" height="300" alt="">
							</div>
						</div>

						<div class="col-lg-6 col-md-6 col-sm-6">
							<div class="heading-title heading-border-bottom">
								<h3>We believe in Simple &amp; Creative</h3>
							</div>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique excepturi voluptates placeat ducimus delectus magnam tempore dolore dolorem quisquam porro modi voluptatum eum saepe dolorum.</p>
							<blockquote>
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas metus nulla, commodo a sodales sed, dignissim pretium nunc.</p>
								<cite>Albert Einstein</cite>
							</blockquote>
						</div>

					</div>
					
				</div>
			</section>
			<!-- / -->




			<!-- -->
			<section>
				<div class="container">
					
					<div class="row">
					
						<div class="col-lg-6 col-md-6 col-sm-6">

							<div class="heading-title heading-border-bottom">
								<h3>Development Experience</h3>
							</div>

							<ul class="nav nav-tabs nav-clean">
								<li class="active"><a href="#tab1" data-toggle="tab">Web Development</a></li>
		
								<li><a href="#tab3" data-toggle="tab">Mysql</a></li>
							</ul>

							<div class="tab-content">
								<div id="tab1" class="tab-pane fade in active">
									<img class="pull-left" src="demo_files/images/mockups/600x399/20-min.jpg" width="200" alt="" />
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam quidem.<p>
									<p>Officia illum eos quos voluptate omnis deleniti molestiae numquam fugiat ab.</p>
								</div>
								<div id="tab2" class="tab-pane fade">
									<img class="pull-right" src="demo_files/images/mockups/600x399/20-min.jpg" width="200" alt="" />
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit voluptatem accusantium.<p>
									<p>Officia illum eos quos voluptate omnis deleniti molestiae numquam fugiat delectus.</p>
								</div>
								<div id="tab3" class="tab-pane fade">
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam quidem voluptatem accusantium praesentium inventore quae illum.<p>
									<p>Officia illum eos quos voluptate omnis deleniti molestiae numquam fugiat delectus aliquam ab.</p>
								</div>
							</div>
						</div>

						<div class="col-lg-6 col-md-6 col-sm-6">

							<div class="heading-title heading-border-bottom">
								<h3>Skills</h3>
							</div>

							<div class="progress progress-lg"><!-- progress bar -->
								<div class="progress-bar progress-bar-warning progress-bar-striped active text-left" role="progressbar" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100" style="width: 90%; min-width: 2em;">
									<span>JAVA 90%</span>
								</div>
							</div><!-- /progress bar -->

							<div class="progress progress-lg"><!-- progress bar -->
								<div class="progress-bar progress-bar-danger progress-bar-striped active text-left" role="progressbar" aria-valuenow="98" aria-valuemin="0" aria-valuemax="100" style="width: 98%; min-width: 2em;">
									<span>HTML/JSP 98%</span>
								</div>
							</div><!-- /progress bar -->

							<div class="progress progress-lg"><!-- progress bar -->
								<div class="progress-bar progress-bar-success progress-bar-striped active text-left" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%; min-width: 2em;">
									<span>JAVASCRIPT 60%</span>
								</div>
							</div><!-- /progress bar -->

							<div class="progress progress-lg"><!-- progress bar -->
								<div class="progress-bar progress-bar-info progress-bar-striped active text-left" role="progressbar" aria-valuenow="88" aria-valuemin="0" aria-valuemax="100" style="width: 88%; min-width: 2em;">
									<span>MYSQL 88%</span>
								</div>
							</div><!-- /progress bar -->
						</div>
					</div>
					
				</div>
			</section>
			<!-- / -->

		
	</body>
<jsp:include page="./common-template-footer.jsp" />
</html>