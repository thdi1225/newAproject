<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<small class="float-right text-underline-bold">회원관리 > 회원등록</small>
		<h2 class="text-title">
			회원등록
		</h2>
	</div>
	
	<div class="border rounded p-3">
	<div class="form-group row">
		<label for="section_id" class="col-sm-2 col-form-label">section</label>
		<select id="section_id" name="section_id" class="col-sm-7 form-control">
			<c:forEach items="${sectionList}" var="list">
				<option value="${list.section_id}">${list.section_name}</option>
			</c:forEach>
		</select>
	</div>
	<div class="form-group row">
		<label for="member_insert_email" class="col-sm-2 col-form-label">email</label>
		<input id="member_insert_email" name="member_insert_email" type="email" class="col-sm-7 input">
	</div>
	<div class="form-group row">
		<label for="member_insert_pw" class="col-sm-2 col-form-label">Password</label>
		<input id="member_insert_pw" name="member_insert_pw" type="password" class="col-sm-7 input" data-type="password">
	</div>
	<div class="form-group row">
		<label for="member_insert_name" class="col-sm-2 col-form-label">name</label>
		<input id="member_insert_name" name="member_insert_name" type="text" class="col-sm-7 input">
	</div>
	<div class="form-group row">
		<label for="member_insert_phone" class="col-sm-2 col-form-label">phone</label>
		<input id="member_insert_phone" name="member_insert_phone" type="tel" class="col-sm-7 input">
	</div>
	<div class="form-group row">
		<label for="member_insert_job" class="col-sm-2 col-form-label">job</label>
		<input id="member_insert_job" name="member_insert_job" type="text" class="col-sm-7 input">
	</div>
	<div class="form-group row">
		<label for="member_insert_auth" class="col-sm-2 col-form-label">auth</label>
		<div class="form-check form-check-inline">
			<input class="form-check-input" type="radio" name="member_insert_auth" id="member_insert_admin" value="0">
			<label class="form-check-label" for="member_insert_admin">관리자</label>
		</div>
		<div class="form-check form-check-inline">
			<input class="form-check-input" type="radio" name="member_insert_auth" id="member_insert_member" value="1" checked="checked">
			<label class="form-check-label" for="member_insert_member">일반 사용자</label>
		</div>
	</div>
	<div class="group text-right">
		<input type="button" class="table-btn" onclick="memberAdminInput()" value="Sign Up">
	</div>
	</div>
	
	<script type="text/javascript">
		function memberAdminInput(){
			$.ajax({
				url:"memberAdminInput.do",
				method:"post",
				dataType : "json",
				data: {
					"member_insert_email" : $("#member_insert_email").val(),
					"section_id" : $("#section_id").val(),
					"member_insert_pw" : $("#member_insert_pw").val(),
					"member_insert_name" : $("#member_insert_name").val(),
					"member_insert_phone" : $("#member_insert_phone").val(),
					"member_insert_job" : $("#member_insert_job").val(),
					"member_insert_auth" : $("input[name='member_insert_auth']:checked").val()
				},
				dataType : "json",
				success:function(result){
					location.href="memberSelectList.do";
				}
			});
		}
	</script>
</body>
</html>