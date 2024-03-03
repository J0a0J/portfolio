<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
<title>에러!!</title>
<script type="text/javascript">
	$(document).ready(function(){
		init();
	});
	
	function init(){
		var msg = '${msg}';
		if(msg != ''){
			alert(msg);
		}
		
		var contextPath = '${pageContext.request.contextPath}';
		var nextLocation = '${nextLocation}';
		if(nextLocation != null && nextLocation != ''){
			window.top.location.href = contextPath + nextLocation;
		}
	}
</script>
</head>
<body>

</body>
</html>