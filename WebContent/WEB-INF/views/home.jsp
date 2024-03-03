<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<!-- REVOLUTION SLIDER -->
	<link href="<c:url value='/resources/plugins/slider.revolution/css/extralayers.css'/>" rel="stylesheet" type="text/css" />
	<link href="<c:url value='/resources/plugins/slider.revolution/css/settings.css'/>" rel="stylesheet" type="text/css" />
	
	<!-- REVOLUTION SLIDER -->
	<script src="<c:url value='/resources/plugins/slider.revolution/js/jquery.themepunch.tools.min.js'/>"></script>
	<script src="<c:url value='/resources/plugins/slider.revolution/js/jquery.themepunch.revolution.min.js'/>"></script>
	<script src="<c:url value='/resources/js/view/demo.revolution_slider.js'/>"></script>	
</head>
	<body class="smoothscroll enable-animation">
		<%-- 내용 나올 div 시작!!!! --%>
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
									<li>Spring Framework 4.3.14.RELEASE / myBatis 3.4.1 / jUnit 4.12</li>
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
	</body>
</html>