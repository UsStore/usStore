<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
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

                    <li>
                    	<a href="<c:url value="/shop/secondHand/listItem.do?productId=2"/>">중고거래</a>
                   	</li>

                    <li>
                    	<a href="<c:url value="/shop/auction/listItem.do?productId=1"/>">경메</a>
                    </li>
                    
                    <li>
                    	<a href="<c:url value="/shop/groupBuying/listItem.do?productId=0"/>">공동구매</a>
                    </li>

                    <li role="separator" class="divider"></li>

                    <li>
                    	<a href="<c:url value="/shop/rank.do"/>">Ranking</a>
                    </li>

                  </ul>
                </div>

            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->

            <div class="collapse navbar-collapse" id="navbar">

              <ul class="nav navbar-nav navbar-right">

                <li><a href="#">About Us</a></li>

              </ul>

            </div><!-- /.navbar-collapse -->

          </div><!-- /.container-fluid -->

        </nav>

    </div>

<!-- IncludeHeader end-->
<!-- ----------- -->   