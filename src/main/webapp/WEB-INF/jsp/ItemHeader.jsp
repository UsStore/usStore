<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

                <span class="action pull-left">
					<ul class="navbar-nav">
						<li class="nav-item active">
							<!-- Session 정리 필요합니당 -->
							<a class="nav-link" href="<c:url value="/shop/index.do"/>">
								<img border="0" src="${pageContext.request.contextPath}/images/home.png"
									style="float: left; width: 30; height: 30; border: 0;" />
							</a>
						</li>
					</ul>
				</span>
				
				<span class="action pull-right">
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
											
										<li><a href="<c:url value="/shop/viewCalendar.do"/>">
											출석 체크</a></li>
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

				</span>

			</div>

        </div>

    </div>
<!-- IncludeTopBar end -->
 
<!-- IncludeHeader start -->
    <div class="header">

        <div class="container">
              
			<div class="row">	
				<div class="col-md-3 col-sm-3 col-xs-3 col-lg-3">
					<div class="logo">
						<a href="<c:url value="/shop/index.do"/>">
		            		<img src="${pageContext.request.contextPath}/images/logo.png" alt="UsStore">
		        		</a>  
	        		</div>
				</div>
				<div class="search-form">
                	<div class="col-md col-sm-9 col-xs-9 col-lg-9">
                        <form class="navbar-form" name="searchForm"
                        		action="<c:url value='/shop/search/viewItem.do'/>" role="search">
                        		<input type="radio" name="sKind" id="skind1" value="title"/>
					            <label for="skind1">제목</label> &nbsp; &nbsp; &nbsp;
								<input type="radio" name="sKind" id="skind2" value="tag" checked="checked"/>
					            <label for="skind2">태그</label> <br>
                       			<input type="text" id="word" name="word" class="form-control" size="35" placeholder="검색어를 입력해주세요.">
                   				<button class="btn" onclick="search(word.value)"><i class="fa fa-search"></i></button>	
		                 </form>
                    </div>
                </div>
                
            </div>
        
        </div>
    
    </div>

    <div class="navigation">

        <nav class="navbar navbar-theme">

          <div class="container">

            <!-- Brand and toggle get grouped for better mobile display -->

            <div class="navbar-header">

              <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false">

                <span class="sr-only">Menu</span>

                <span class="icon-bar"></span>

                <span class="icon-bar"></span>

                <span class="icon-bar"></span>

              </button>

            </div>

            <div class="shop-category nav navbar-nav navbar-left">

                <!-- Single button -->

                <div class="btn-group">

                  <button type="button" class="btn btn-shop-category dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">

                    Shop By Category <span class="caret"></span>

                  </button>

                  <ul class="dropdown-menu">

                    <li>
                        <a href="<c:url value="/shop/handMade/listItem.do?productId=3"/>">수공예</a>
                    </li>
                    
					<li role="separator" class="divider"></li>
					
                    <li>
                    	<a href="<c:url value="/shop/secondHand/listItem.do?productId=2"/>">중고거래</a>
                   	</li>
                   	
					<li role="separator" class="divider"></li>
					
                    <li>
                    	<a href="<c:url value="/shop/auction/listItem.do?productId=1"/>">경매</a>
                    </li>
                    
                    <li role="separator" class="divider"></li>
                    
                    <li>
                    	<a href="<c:url value="/shop/groupBuying/listItem.do?productId=0"/>">공동구매</a>
                    </li>     

                  </ul>
                </div>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->

            <div class="collapse navbar-collapse" id="navbar">

              <ul class="nav navbar-nav navbar-right">

				<li>
                    <a href="<c:url value="/shop/rank.do"/>">Ranking</a>
                </li>
                <li>
                	<a href="#">About Us</a>
               	</li>
              </ul>

            </div><!-- /.navbar-collapse -->

          </div><!-- /.container-fluid -->

        </nav>

    </div>

<!-- IncludeHeader end-->
<!-- ----------- -->   