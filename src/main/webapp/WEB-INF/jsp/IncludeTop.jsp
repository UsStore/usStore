<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<title>UsStore</title>
	<!-- MetaData -->
	<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Cache-Control" content="max-age=0">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="Expires" content="Tue, 01 Jan 1980 1:00:00 GMT">
	<meta http-equiv="Pragma" content="no-cache">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="2020-01 소프트웨어 시스템 개발 ">
	<meta name="author" content="愛+">
	
	<!-- UsStore Stylesheet -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/usstore.css?after" type="text/css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/account.css?after" type="text/css" />
	
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

	<!-- Google Font -->
	<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700|Raleway:400,300,500,700,600' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.css" type="text/css">

    <!-- Theme Stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?after">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css?after">
    
    <!-- jQuery Library -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>

	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

	<!-- Script -->
	<script src="${pageContext.request.contextPath}/js/script.js"></script>

	<script>
		function search(word) {
			alert("검색어 : " + word);
	
			searchForm.submit();
		}
	</script>

</head>

<!-- 맨 위의 nav bar  -->
<!-- IncludeTopBar start -->

<body>
    <div class="top-bar">

        <div class="container">
        
            <div class="row">

                <div class="col-md-6"></div>

				<div class="action pull-right">
					<ul>
						<c:if test="${empty userSession.account}">
							<li>
								<div class="shop-top btn-group">
									<button type="button" class="btn dropdown-toggle" aria-haspopup="true" aria-expanded="false">
										<a href="<c:url value="/shop/signonForm.do"/>">
											<i class="fa fa-user"></i> LOGIN </a>
									</button>
								</div>
							</li>
						</c:if>

						<c:if test="${!empty userSession.account}">
							<li>

								<div class="shop-top btn-group">
									<button type="button" class="btn dropdown-toggle"
										data-toggle="dropdown" aria-haspopup="true"
										aria-expanded="false">
										MYPAGE <span class="caret"></span>
									</button>

									<ul class="dropdown-menu">
										<li><a href="<c:url value="/shop/viewAccount.do"/>">
											My Account</a></li>
										<li><a href="<c:url value="/shop/editAccount.do"/>">
											Edit Account</a></li>
										<li><a href="<c:url value="/shop/listOrders.do"/>">
											My Orders</a></li>
									</ul>
								</div>
								
							</li>
							
							<li>
								<div class="shop-top btn-group">
									<button type="button" class="btn dropdown-toggle" aria-haspopup="true"
										aria-expanded="false">
										<a href="<c:url value="/shop/viewCart.do"/>">
										<i class="fa fa-shopping-cart"></i> CART </a></button>
								</div>
							</li>
							
							<li>							
								<div class="shop-top btn-group">
									<button type="button" class="btn dropdown-toggle" aria-haspopup="true"
										aria-expanded="false">
										<a href="<c:url value="/shop/signoff.do"/>">
										<i class="fa fa-lock"></i> LOGOUT </a></button>
								</div>
							</li>

						</c:if>

					</ul>

				</div>

			</div>

        </div>

    </div>
<!-- IncludeTopBar end -->
