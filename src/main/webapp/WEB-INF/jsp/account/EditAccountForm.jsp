<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="IncludeAccount.jsp" %>

  <div class="container">
    <div class="row">
      <div class="col-lg-10 col-xl-9 mx-auto">
        <div class="card card-signin flex-row my-5">
          <div class="card-img-left d-none d-md-flex">
             <!-- Background image for card set in CSS! -->
          </div>
          <div class="card-body">
            <h5 class="card-title text-center">Register</h5>
            <hr class="my-4"><br><br>
            <form:form class="form-signin" modelAttribute="accountForm" method="post">
 			<form:errors cssClass="error" /> 
 			
 			<h6 class="card-title text-center"> University </h6>
			<div class="form-label-group">
				<c:if test="${accountForm.newAccount}">
					<form:input path="account.university" id="inputUniversity" readonly="true" value="${accountForm.account.university}" class="form-control"/>
					<B><form:errors path="account.university" cssClass="error" /></B>
					<label for="inputUniversity">University</label>
				</c:if> 
				<c:if test="${!accountForm.newAccount}">
					<form:input path="account.university" id="inputUniversity" readonly="true" value="${accountForm.account.university}" class="form-control" />
					<label for="inputUniversity">University</label>
				</c:if>
				<button class="btn btn-block btn-dark" style="font-size: 15px;" type="button" onclick="popup();" type="button">대학교 검색하기</button>
				<script>
			        function popup(){
			            var url = "/usStore/searchUniv.do";
			            var name = "univAPI";
			            var option = "width = 500, height = 500, top = 100, left = 200, location = no"
			            window.open(url, name, option);
			        }
			    </script>
			<br>
			</div>
              <div class="form-label-group">
                <c:if test="${accountForm.newAccount}">
	              <form:input path="account.userId" class="form-control"/>
	              <B><form:errors class="form-control" path="account.userId" id="inputUserId" cssClass="error" /></B>
	            </c:if> 
	            <c:if test="${!accountForm.newAccount}">
	              <form:input path="account.userId" class="form-control" value="${accountForm.account.userId}" disabled="true"/>
	            </c:if>
                <label for="inputUsername">USER ID</label>
              </div>
              
              <div class="form-label-group">
                <form:password path="account.password" id="inputPassword" class="form-control"/>
                <B><form:errors path="account.password" cssClass="error" /></B>
                <label for="inputPassword">Password</label>
              </div>
              
              <div class="form-label-group">
                <form:password path="repeatedPassword" id="inputConfirmPassword" class="form-control"/>
                <B><form:errors path="repeatedPassword" cssClass="error" /></B>
                <label for="inputConfirmPassword">Confirm password</label>
              </div>
              <br><br>
			  <%@ include file="IncludeAccountFields.jsp"%>
			  <hr class="my-4">
              <button class="btn btn-lg btn-dark btn-block text-uppercase" style="font-size: 20px;" type="submit">Register</button>
             </form:form>
             <%--   <h3><b><a href='<c:url value="/shop/listOrders.do"/>'>My Orders</a></b></h3> --%>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>