<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>JohnDoe's Portfolio </title>
	<meta name="description" content="" />
	<meta name="Author" content="Dorin Grigoras [www.stepofweb.com]" />

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
	<link href="<c:url value='/resources/css/color_scheme/green.css'/>" rel="stylesheet" type="text/css" id="color_scheme" />
	
	<!-- JAVASCRIPT FILES -->
	<script>var plugin_path = "<c:url value='/resources/plugins/'/>";</script>
	<script src="<c:url value='/resources/plugins/jquery/jquery-3.3.1.min.js'/>"></script>
	
	<script src="<c:url value='/resources/js/scripts.js'/>"></script>
	
	<script src="<c:url value='/resources/js/common.js'/>"></script>
	

	<!-- REVOLUTION SLIDER -->
	<script src="<c:url value='/resources/plugins/slider.revolution/js/jquery.themepunch.tools.min.js'/>"></script>
	<script src="<c:url value='/resources/plugins/slider.revolution/js/jquery.themepunch.revolution.min.js'/>"></script>
	<script src="<c:url value='/resources/js/view/demo.revolution_slider.js'/>"></script>
	<script type="text/javascript" >
		var ctx = '<%= request.getContextPath() %>';
	    $(document).ready(function() {
	    	//movePage(this, '/home.do');
	    	
	    	// 뒤로가기 버튼 죽이기
	          history.pushState(null, document.title, location.href); 
	          window.addEventListener('popstate', function(event) { 
	             if(confirm('사이트를 벗어나시겠습니까?')){
	               if(!confirm('꼭 가시겠어요?'))
	                  history.pushState(null, document.title, location.href);
	               else
	                  history.back();
	             }
	          });

	    });
	</script>
</head>
	<body class="smoothscroll enable-animation">
		<!-- wrapper -->
		<div id="wrapper">
			<!-- Top Bar -->
			<div id="topBar">
				<div class="container">

					<!-- right -->
					<ul class="top-links list-inline float-right">
						<c:choose>
	                    	<c:when test='${sessionScope.memberId != null}'>
	                    	<%-- 로그인 사용자 정보 --%>
	                    	
								<li class="text-welcome hidden-xs-down">Welcome!! <strong>${sessionScope.memberNick}</strong></li>
								<li><a tabindex="-1" href="<c:url value='/member/logout.do'/>"><i class="glyphicon glyphicon-off"></i> LOGOUT</a></li>
	                    	</c:when>
	                    	<c:otherwise>
								<li><a tabindex="-1" href="javascript:movePage(this, '/member/goLoginPage.do')">LOGIN</a></li>
	                    	</c:otherwise>
	                    </c:choose>
					</ul>
				</div>
			</div>
			<!-- /Top Bar -->
			
			<div id="header" class="navbar-toggleable-md sticky shadow-after-3 clearfix">
				<!-- TOP NAV -->
				<header id="topNav">
					<div class="container">
						<!-- Mobile Menu Button -->
						<button class="btn btn-mobile" data-toggle="collapse" data-target=".nav-main-collapse">
							<i class="fa fa-bars"></i>
						</button>

						<!-- Logo -->
						<a class="logo float-left" href="<c:url value='/index.do'/>">
							<img src="<c:url value=''/>" alt="" />
						</a>
						
						<div class="navbar-collapse collapse float-right nav-main-collapse submenu-dark">
							<nav class="nav-main">
								<ul id="topMain" class="nav nav-pills nav-main">
									<li class="dropdown active"><!-- HOME -->
										<a class="dropdown-toggle noicon" href="<c:url value='/index.do'/>">
											HOME
										</a>
									</li>
									
									<li class="dropdown"><!-- PROFILE -->
										<a class="dropdown-toggle noicon" href="javascript:movePage(this, '/profile.do')">
											PROFILE
										</a>
									</li>
									<li class="dropdown"><!-- SPRING BOARD -->
										<a class="dropdown-toggle">
											SPRING BOARD
										</a>
										<ul class="dropdown-menu">
											<li><a href="javascript:movePage(this, '/notice/list.do')">공지사항</a></li>
											<li><a href="javascript:movePage(this, '/board/list.do')">자유게시판</a></li>
										</ul>
									</li>
									<li class="dropdown"><!-- NOTES -->
										<a class="dropdown-toggle noicon" href="javascript:movePage(this, '/devNotes.do')">
											DEV-NOTES
										</a>
									</li>
									
							
							<c:if test='${sessionScope.memberId != null && sessionScope.memberType ==1 }'>
									<li class="dropdown mega-menu"><!-- SHORTCODES -->
										<a class="dropdown-toggle noicon" href="javascript:movePage(this, '/admin.do')">
											ADMIN
										</a>
									</li>
							</c:if>		
									<li>
										<a id="sidepanel_btn" href="#" class="fa fa-bars"></a>
									</li>
								</ul>
							</nav>
						</div>
					</div>
				</header>
				<!-- /Top Nav -->
			</div>
			
			<%-- 내용 나올 div 시작!!!! --%>
			<div id="contentDiv">
			<%-- 내용 나올 div 끝!!!! --%>
			
			<section style="padding:0">	
 			
				<!-- REVOLUTION SLIDER-->
				<div class="slider fullwidthbanner-container roundedcorners">
					<div class="fullwidthbanner" data-height="600" data-shadow="0" data-navigationStyle="preview2">
						<ul class="hide">
							<!-- SLIDE --> 
							<li data-transition="random" data-slotamount="1" data-masterspeed="1000" data-saveperformance="off" data-title="Slide 1">
	
								<img data-lazyload="resources/demo_files/images/index/index-min.jpg" alt="" data-bgfit="cover" data-bgposition="center bottom" data-bgrepeat="no-repeat" />
	
								<div class="tp-caption customin ltl tp-resizeme text_white"
									data-x="center"
									data-y="155"
									data-customin="x:0;y:150;z:0;rotationZ:0;scaleX:1;scaleY:1;skewX:0;skewY:0;opacity:0;transformPerspective:200;transformOrigin:50% 0%;"
									data-speed="800"
									data-start="1000"
									data-easing="easeOutQuad"
									data-splitin="none"
									data-splitout="none"
									data-elementdelay="0.01"
									data-endelementdelay="0.1"
									data-endspeed="1000"
									data-endeasing="Power4.easeIn" style="z-index: 10; font-size:20px;">
									<span class="fw-300"> 잘 오셨습니다.
									<b style="font-size:20px">아무개</b>의 포트폴리오 사이트 입니다. :) </span>
								</div>
	
								<div class="tp-caption customin ltl tp-resizeme large_bold_white"
									data-x="center"
									data-y="205"
									data-customin="x:0;y:150;z:0;rotationZ:0;scaleX:1;scaleY:1;skewX:0;skewY:0;opacity:0;transformPerspective:200;transformOrigin:50% 0%;"
									data-speed="800"
									data-start="1200"
									data-easing="easeOutQuad"
									data-splitin="none"
									data-splitout="none"
									data-elementdelay="0.01"
									data-endelementdelay="0.1"
									data-endspeed="1000"
									data-endeasing="Power4.easeIn" style="z-index: 10;">
									WELCOME TO MY WORLD
								</div>
	
								<div class="tp-caption customin ltl tp-resizeme small_light_white font-lato"
									data-x="center"
									data-y="300"
									data-customin="x:0;y:150;z:0;rotationZ:0;scaleX:1;scaleY:1;skewX:0;skewY:0;opacity:0;transformPerspective:200;transformOrigin:50% 0%;"
									data-speed="800"
									data-start="1400"
									data-easing="easeOutQuad"
									data-splitin="none"
									data-splitout="none"
									data-elementdelay="0.01"
									data-endelementdelay="0.1"
									data-endspeed="1000"
									data-endeasing="Power4.easeIn" style="z-index: 20; width: 100%; max-width: 750px; white-space: normal; text-align:center; font-size:20px; line-height: 55px">
									이 사이트는 아래 기술을 이용하여 구현하였습니다.
									<br/>
									<span style="font-size:20px;font-weight:400;line-height: 30px">
									<ul>
										<li>Spring Framework 5.3.32 / myBatis 3.4.1 / jUnit 4.12</li>
										<li>jQuery 3.2.1/ jQuery UI 1.12.1/ jqGrid 4.4.3 / Maven / log 4.12 </li>
										<br/>
										<li>Languages : JAVA, JSP, JavaScript</li>
										<li>Server : AWS t2.micro free tier</li>
										<li>DBMS : MySql 5.7</li>
										<li>WAS : Tomcat 8.5</li>
									</ul>
									</span>								
								</div>
							</li>
	
							<!-- SLIDE 2--> 
							<li data-transition="random" data-slotamount="1" data-masterspeed="1000" data-saveperformance="off" data-title="Slide 2">
	
								<img src="" data-lazyload="resources/demo_files/images/index/24-min.jpg" alt="" data-bgposition="center center" data-kenburns="on" data-duration="10000" data-ease="Linear.easeNone" data-bgfit="100" data-bgfitend="110" />
	
								<div class="tp-caption very_large_text lfb ltt tp-resizeme"
									data-x="right" data-hoffset="-100"
									data-y="center" data-voffset="-50"
									data-speed="600"
									data-start="800"
									data-easing="Power4.easeOut"
									data-splitin="none"
									data-splitout="none"
									data-elementdelay="0.01"
									data-endelementdelay="0.1"
									data-endspeed="500"
									data-endeasing="Power4.easeIn">
									BEING AWAKE.
								</div>
	
								<div class="tp-caption medium_light_white lfb ltt tp-resizeme"
									data-x="right" data-hoffset="-110"
									data-y="center" data-voffset="60"
									data-speed="600"
									data-start="900"
									data-easing="Power4.easeOut"
									data-splitin="none"
									data-splitout="none"
									data-elementdelay="0.01"
									data-endelementdelay="0.1"
									data-endspeed="500"
									data-endeasing="Power4.easeIn">
									Happiness is an accident of nature,<br/>
									a beautiful and flawless aberration.<br/>
									<span style="font-size:24px;font-weight:400;">&ndash; Hyesue Lee</span>
								</div>
							</li>
						</ul>
	
					</div>
				</div>
			<!-- /REVOLUTION SLIDER -->
			</section> 			
		</div>
			<!-- FOOTER -->
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
							<li><a href="javascript:movePage(this, '/profile.do')">프로필</a></li>
							<li><a href="javascript:movePage(this, '/board/list.do')">게시판(spring)</a></li>
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
							<h2 class="sidepanel-title">HYESUE's Portfolio</h2>
			
							<!-- SIDE NAV -->
							<ul class="list-group">
			
								<li class="list-group-item">
									<a href="<c:url value='/index.do'/>">
										<i class="ico-category et-heart"></i>  
										HOME
									</a>
								</li>
								<li class="list-group-item">
									<a href="javascript:movePage(this, '/profile.do')">
										<i class="ico-category et-happy"></i>  
										PROFILE
									</a>
								</li>
								<li class="list-group-item">
									<a href="javascript:movePage(this, '/notice/list.do')">
										<i class="ico-category et-happy"></i>  
										NOTICE
									</a>
								</li>
								<li class="list-group-item">
									<a href="javascript:movePage(this, '/board/list.do')">
										<i class="ico-category et-happy"></i>  
										FREE-BOARD
									</a>
								</li>
							
								<li class="list-group-item">
									<a href="javascript:movePage(this, '/tables.do')">
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
							<!-- /SIDE NAV -->
			
							<!-- Social Icons -->
							<div class="mt-20">							
								<a href="#" target='_blank' class="social-icon social-icon-border social-gplus float-left" data-toggle="tooltip" data-placement="top" title="Google plus">
									<i class="icon-github-circled"></i>
									<i class="icon-github-circled"></i>
								</a>
								<a href="#" target='_blank' class="social-icon social-icon-border social-facebook float-left" data-toggle="tooltip" data-placement="top" title="Facebook">
									<i class="icon-facebook"></i>
									<i class="icon-facebook"></i>
								</a>
								<a href="#" class="social-icon social-icon-border social-twitter float-left" data-toggle="tooltip" data-placement="top" title="Twitter">
									<i class="icon-instagram"></i>
									<i class="icon-instagram"></i>
								</a>
								<a href="#" class="social-icon social-icon-border social-linkedin float-left" data-toggle="tooltip" data-placement="top" title="Linkedin">
									<i class="icon-linkedin"></i>
									<i class="icon-linkedin"></i>
								</a>
							</div>
							<!-- /Social Icons -->
						</div>
					</div>
				</div>
			</div>			
		</footer>
		<!-- /FOOTER -->

		</div>
		<!-- /wrapper -->

		<!-- SCROLL TO TOP -->
		<a href="#" id="toTop"></a>

	</body>
</html>