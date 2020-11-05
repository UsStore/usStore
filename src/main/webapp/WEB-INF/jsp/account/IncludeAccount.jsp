<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
	<title>UsStore</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Cache-Control" content="max-age=0">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="Expires" content="Tue, 01 Jan 1980 1:00:00 GMT">
	<meta http-equiv="Pragma" content="no-cache">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="2020-01 소프트웨어 시스템 개발 ">
	<meta name="author" content="愛+">
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/usstore.css?" type="text/css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/account.css?" type="text/css" />
	
	<!-- Bootstrap core JavaScript -->
	<script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	
	<!-- Plugin JavaScript -->
	<script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>
	
	<!-- Custom JavaScript for this theme -->
	<script src="${pageContext.request.contextPath}/js/scrolling-nav.js"></script>
	
	<!-- Bootstrap core CSS -->
	<link href="${pageContext.request.contextPath}/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Custom styles for this template -->
	<link href="${pageContext.request.contextPath}/css/scrolling-nav.css" rel="stylesheet">
	
	<!-- Custom styles for this template -->
	<link href="${pageContext.request.contextPath}/css/simple-sidebar.css" rel="stylesheet">

</head>
<body>
 <nav class="navbar navbar-light" style="background-color: #000000; height: 74px; font-size: 20px;">
	<ul class="navbar-nav">
		<li class="nav-item active">
			<a class="nav-link" href="<c:url value="/shop/index.do"/>">
				<!-- Session 정리 필요합니당 -->
				<img border="0" src="${pageContext.request.contextPath}/images/home.png"
					style="float: left; width: 30; height: 30; border: 0; margin-left:20px;" />
			</a>
		</li>
	</ul>
</nav>
<br>