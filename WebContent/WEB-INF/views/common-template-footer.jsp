<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Jiweon's Portfolio</title>
    <meta name="description" content="">
    <meta name="Author" content="Dorin Grigoras [www.stepofweb.com]">

    <!-- mobile settings -->
    <meta name="viewport" content="width=device-width, maximum-scale=1, initial-scale=1, user-scalable=0" />
    <!--[if IE]><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><![endif]-->

    <!-- WEB FONTS : use %7C instead of | (pipe) -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600%7CRaleway:300,400,500,600,700%7CLato:300,400,400italic,600,700" rel="stylesheet" type="text/css" />

    <!-- CORE CSS -->
    <link href="<c:url value='/resources/plugins/bootstrap/css/bootstrap.min.css'/>" rel="stylesheet" type="text/css" />

    <!-- REVOLUTION SLIDER -->
    <link href="<c:url value='/resources/plugins/slider.revolution/css/extralayers.css'/>" rel="stylesheet" type="text/css" />
    <link href="<c:url value='/resources/plugins/slider.revolution/css/settings.css'/>" rel="stylesheet" type="text/css" />
    
    <!-- COMMON -->
    <link href="<c:url value='/resources/css/common.css'/>" rel="stylesheet" type="text/css" />

    <!-- THEME CSS -->
    <link href="<c:url value='/resources/css/essentials.css'/>" rel="stylesheet" type="text/css" />
    <link href="<c:url value='/resources/css/layout.css'/>" rel="stylesheet" type="text/css" />

    <!-- PAGE LEVEL SCRIPTS -->
    <link href="<c:url value='/resources/css/header-1.css'/>" rel="stylesheet" type="text/css" />
    <link href="<c:url value='/resources/css/color_scheme/blue.css'/>" rel="stylesheet" type="text/css" id="color_scheme" />
    
    <!-- JAVASCRIPT FILES -->
    <script>var plugin_path = "<c:url value='/resources/plugins/'/>";</script>
    <script src="<c:url value='/resources/plugins/jquery/jquery-3.3.1.min.js'/>"></script>
    
    <script src="<c:url value='/resources/js/scripts.js'/>"></script>
    
    <script src="<c:url value='/resources/js/common.js'/>"></script>
    

    <!-- REVOLUTION SLIDER -->
    <script src="<c:url value='/resources/plugins/slider.revolution/js/jquery.themepunch.tools.min.js'/>"></script>
    <script src="<c:url value='/resources/plugins/slider.revolution/js/jquery.themepunch.revolution.min.js'/>"></script>
    <script src="<c:url value='/resources/js/view/demo.revolution_slider.js'/>"></script>
</head>
<body>		
			<footer id="footer" style="padding:0px 1px 1px 0px">
			<div class="container">
				<div class="row">
					<div class="col-md-3">
						<!-- Contact Address -->
						<address>
							<ul class="list-unstyled">
								<li class="footer-sprite address">
									주소<br>
									zip code ~~~<br>
								</li>
								<li class="footer-sprite phone">
									010-cccc-3333
								</li>
								<li class="footer-sprite email">
									<a href="mailto:#">your_email</a>
								</li>
							</ul>
						</address>
						<!-- /Contact Address -->
					</div>

					<div class="col-md-2">
						<!-- Links -->
						<h4 class="letter-spacing-1">MENU</h4>
						<ul class="footer-links list-unstyled">
							<li><a href="<c:url value='/index.do'/>">홈으로</a></li>
							<li><a href="javascript:movePage('/profile.do')">프로필</a></li>
							<li><a href="javascript:movePage('/board/list.do')">게시판(spring)</a></li>
						</ul>
						<!-- /Links -->
					</div>

					<div class="col-md-7">
					
					<h4 class="letter-spacing-1">THANKS FOR VISITING</h4>
					<p>제가 구현한 스프링 게시판의 주요기능 확인을 위해 회원가입을 해주세요. :) <br/>
					이 게시판은 관리자 / 일반 모드를 구분하여 구현하였으며 회원가입시 일반회원 모드로 가입됩니다.<br/>
					* 임의의 관리자 계정으로 로그인:  <h3> ID: admin123 / PW: admin12# </h3>
					</div>
						
					<div id="sidepanel" class="sidepanel-light">
						<a id="sidepanel_close" href="#"><!-- close -->
							<i class="fa fa-remove"></i>
						</a>
			
						<div class="sidepanel-content">
							<h2 class="sidepanel-title">Jiweon's Portfolio</h2>
			
							<!-- SIDE NAV -->
							<ul class="list-group">
			
								<li class="list-group-item">
									<a href="<c:url value='/index.do'/>">
										<i class="ico-category et-heart"></i>  
										HOME
									</a>
								</li>
								<li class="list-group-item">
									<a href="javascript:movePage('/profile.do')">
										<i class="ico-category et-happy"></i>  
										PROFILE
									</a>
								</li>
								<li class="list-group-item">
									<a href="javascript:movePage('/notice/list.do')">
										<i class="ico-category et-happy"></i>  
										NOTICE
									</a>
								</li>
								<li class="list-group-item">
									<a href="javascript:movePage('/board/list.do')">
										<i class="ico-category et-happy"></i>  
										FREE-BOARD
									</a>
								</li>
							
								<li class="list-group-item">
									<a href="javascript:movePage('/tables.do')">
										<i class="ico-category et-happy"></i>  
										DEV-NOTES
									</a>
								</li>
								<li class="list-group-item">
									<a href="#">
										<i class="ico-category et-beaker"></i> 
										LEARNING
									</a>
								</li>
			
			
							</ul>
	
			
							
						</div>
					</div>
				</div>
			</div>			
		</footer>

</body>
</html>
