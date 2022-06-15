<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="group">
		<label for="section_id" class="label">section</label>
		<select id="section_id" name="section_id" class="select">
			<option value="1">테스트 1</option>
			<option value="2">테스트 2</option>
			<option value="3">테스트 3</option>
		</select>
	</div>
	<div class="group">
		<label for="member_insert_email" class="label">email</label>
		<input id="member_insert_email" name="member_insert_email" type="text" class="input">
	</div>
	<div class="group">
		<label for="member_insert_pw" class="label">Password</label>
		<input id="member_insert_pw" name="member_insert_pw" type="password" class="input" data-type="password">
	</div>
	<div class="group">
		<label for="member_insert_name" class="label">name</label>
		<input id="member_insert_name" name="member_insert_name" type="text" class="input">
	</div>
	<div class="group">
		<label for="member_insert_phone" class="label">phone</label>
		<input id="member_insert_phone" name="member_insert_phone" type="text" class="input">
	</div>
	<div class="group">
		<label for="member_insert_job" class="label">job</label>
		<input id="member_insert_job" name="member_insert_job" type="text" class="input">
	</div>
	<div class="group">
		<label for="member_insert_auth" class="label">auth</label>
		<div class="form-check form-check-inline">
			<input class="form-check-input" type="radio" name="member_insert_auth" id="member_insert_admin" value="0">
			<label class="form-check-label" for="member_insert_admin">관리자</label>
		</div>
		<div class="form-check form-check-inline">
			<input class="form-check-input" type="radio" name="member_insert_auth" id="member_insert_member" value="1" checked="checked">
			<label class="form-check-label" for="member_insert_member">일반 사용자</label>
		</div>
	</div>
	<div class="group">
		<input type="button" class="button" onclick="memberAdminInput()" value="Sign Up">
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
// 					toastr.info("회원 수정을 성공하였습니다.");
					location.href="memberSelectList.do";
				}
			});
		}
	</script>
</body>
</html>