<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<h6 class="card-title text-center"> University </h6>
<div class="form-label-group">
	<form:input path="account.university" id="inputUniversity" class="form-control" />
	<B><form:errors path="account.university" cssClass="error" /></B>
	<!-- <button class="btn btn-lg btn-light btn-block text-uppercase" type="button">대학 찾기</button> -->
	<button id="button1" onclick="popup();">대학교 찾기</button>
	<script>
		function button1_click() {
			alert("버튼1을 누르셨습니다.");
		}
	</script>
	<script>
        function popup(){
            var url = "http://localhost:8080/usStore/searchUniv.do";
            var name = "univAPI";
            var option = "width = 500, height = 500, top = 100, left = 200, location = no"
            window.open(url, name, option);
        }
    </script>
</div>
<hr class="my-4">

<h5 class="card-title text-center"> Account Information </h5>

<div class="form-label-group">
	<form:input path="account.username" id="inputName" class="form-control" />
	<B><form:errors path="account.username" cssClass="error" /></B> <label for="inputName">Name</label>
</div>

<div class="form-label-group">
	<form:input path="account.email" id="inputEmail" class="form-control" />
	<B><form:errors path="account.email" cssClass="error" /></B> <label for="inputEmail">E-Mail</label>
</div>

<div class="form-label-group">
	<form:input path="account.phone" id="inputPhone" class="form-control" />
	<B><form:errors path="account.phone" cssClass="error" /></B> <label for="inputPhone">Phone</label>
</div>

<div class="form-label-group">
	<form:input path="account.addr1" id="inputAddress1" class="form-control" />
	<B><form:errors path="account.addr1" cssClass="error" /></B> <label for="inputAddress1">Address1</label>
</div>

<div class="form-label-group">
	<form:input path="account.addr2" id="inputAddress2" class="form-control" />
	<B><form:errors path="account.addr2" cssClass="error" /></B> <label for="inputAddress2">Address2</label>
</div>

<div class="form-label-group">
	<form:input path="account.city" id="inputCity" class="form-control" />
	<B><form:errors path="account.city" cssClass="error" /></B> <label for="inputCity">city</label>
</div>

<div class="form-label-group">
	<form:input path="account.zip" id="inputzip" class="form-control" />
	<B><form:errors path="account.zip" cssClass="error" /></B> <label for="inputzip">Zipcode</label>
</div>

<div class="form-label-group">
	<form:input path="account.country" id="inputCountry" class="form-control" />
	<B><form:errors path="account.country" cssClass="error" /></B> <label for="inputCountry">Country</label>
</div>