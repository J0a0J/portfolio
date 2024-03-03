<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
</head>

	<body class="smoothscroll enable-animation">

			
			<%-- 내용 나올 div 시작!!!! --%>
			<section class="alternate">
				<div class="container">

					<div class="row">

						<div class="col-md-3">

							<div class="box-icon box-icon-center box-icon-round box-icon-transparent box-icon-large box-icon-content" style="width:100%;
	height:350px;">
								<div class="box-icon-title">
									<i class="b-0 fa fa-tablet"></i>
									<h2>Fully Reposnive</h2>
								</div>
								<p>Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere</p>
							
								<button type="button" class="btn btn-default btn-lg lightbox" data-toggle="modal" data-target="#myModal">
								DB &nbsp; Modeling &nbsp; &nbsp;(IMG)
								</button> <br><br/>
								
								<a href="<c:url value='/file/downloadERD.do'/>">
									<button type="button" class="btn btn-default btn-lg lightbox" data-toggle="modal">
										ERD Download (MWB)
									</button>
								</a>	
								<br/>	
							</div>

						</div>

						<div class="col-md-3">

							<div class="box-icon box-icon-center box-icon-round box-icon-transparent box-icon-large box-icon-content">
								<div class="box-icon-title">
									<i class="b-0 fa fa-random"></i>
									<h2>Clean Design</h2>
								</div>
								<p>nteger posuere erat a ante venenatis dapibus posuere</p>
							</div>

						</div>

						<div class="col-md-3">

							<div class="box-icon box-icon-center box-icon-round box-icon-transparent box-icon-large box-icon-content">
								<div class="box-icon-title">
									<i class="b-0 fa fa-tint"></i>
									<h2>Reusable Elements</h2>
								</div>
								<p>Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere</p>
							</div>

						</div>

						<div class="col-md-3">

							<div class="box-icon box-icon-center box-icon-round box-icon-transparent box-icon-large box-icon-content">
								<div class="box-icon-title">
									<i class="b-0 fa fa-cogs"></i>
									<h2>Multipurpose</h2>
								</div>
								<p>Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere</p>
							</div>

						</div>

					</div>


				</div>
				
				
									<!-- img modal content -->
					<div id="myModal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">

								<!-- Modal Header -->
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
									<h4 class="modal-title" id="myModalLabel">ERD</h4>
								</div>

								<!-- Modal Body -->
								<div class="modal-body">

									<img id="erdImg" width="100%" src="<c:url value='/resources/portfolio_ERD.png'/>"/>

								<!-- Modal Footer -->
								<div class="modal-footer">
									<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
								</div>

							</div>
						</div>
					</div> <!-- img modal content -->

					
				</div>
				
				
			</section>
			<!-- / -->

	

		
	</body>
</html>