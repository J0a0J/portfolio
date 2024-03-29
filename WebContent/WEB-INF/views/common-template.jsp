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
   	<script type="text/javascript" >
		var ctx = '<%= request.getContextPath() %>';
	    $(document).ready(function() {
	    	//movePage('/home.do');
	    	
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
<body>
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
								<li><a tabindex="-1" href="<c:url value='/member/goLoginPage.do' />">LOGIN</a></li>
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
										<a class="dropdown-toggle noicon" href="<c:url value='/profile.do' />">
											PROFILE
										</a>
									</li>
									<li class="dropdown"><!-- SPRING BOARD -->
										<a class="dropdown-toggle">
											SPRING BOARD
										</a>
										<ul class="dropdown-menu">
											<li><a href="<c:url value='/notice/list.do' />">공지사항</a></li>
											<li><a href="<c:url value='/board/list.do' />">자유게시판</a></li>
										</ul>
									</li>
									<li class="dropdown"><!-- NOTES -->
										<a class="dropdown-toggle noicon" href="<c:url value='/devNotes.do' />">
											DEV-NOTES
										</a>
									</li>
									
							
							<c:if test='${sessionScope.memberId != null && sessionScope.memberType ==1 }'>
									<li class="dropdown mega-menu"><!-- SHORTCODES -->
										<a class="dropdown-toggle noicon" href="javascript:movePage('/admin.do')">
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
</body>
</html>
