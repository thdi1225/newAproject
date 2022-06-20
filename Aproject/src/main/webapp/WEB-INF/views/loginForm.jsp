<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>
<link  href="css/login.css" rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css"
	integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></link>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"
	integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body>
<div class="login-wrap">
	<div class="login-html">
		<input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">로그인</label>
		<input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">회원가입</label>
		<div class="login-form">
			<div class="sign-in-htm">
				<form id="login" action="login.do" method="post" onsubmit="return loginCheck()">
					<div class="group">
						<label for="member_email" class="label">이메일</label>
						<input id="member_email" name="member_email" type="email" class="input" maxlength="20">
					</div>
					<div class="group">
						<label for="member_pw" class="label">비밀번호</label>
						<input id="member_pw" name="member_pw" type="password" class="input" data-type="password" maxlength="20">
					</div>
					<div class="group">
						<input type="submit" class="button" value="로그인">
					</div>
				</form>
				<div class="hr"></div>
			</div>
			<div class="sign-up-htm">
				<form action="memberInsert.do" method="post" onsubmit="return signUp()">
					<div class="group">
						<label for="section_id" class="label">부서</label>
						<select id="section_id" name="section_id" class="select">
							<c:forEach items="${sectionList}" var="list">
								<option value="${list.section_id}">${list.section_name}</option>
							</c:forEach>
						</select>
					</div>
					<div class="group">
						<label for="member_insert_email" class="label">이메일</label>
						<input id="member_insert_email" name="member_insert_email" type="email" class="input" maxlength="20">
					</div>
					<div class="group">
						<label for="member_insert_pw" class="label">비밀번호</label>
						<input id="member_insert_pw" name="member_insert_pw" type="password" class="input" data-type="password" maxlength="20">
					</div>
					<div class="group">
						<label for="member_insert_name" class="label">이름</label>
						<input id="member_insert_name" name="member_insert_name" type="text" class="input" maxlength="10">
					</div>
					<div class="group">
						<label for="member_insert_phone" class="label">전화번호</label>
						<input id="member_insert_phone" name="member_insert_phone" type="tel" class="input" maxlength="20">
					</div>
					<div class="group">
						<label for="member_insert_job" class="label">직책</label>
						<input id="member_insert_job" name="member_insert_job" type="text" class="input" maxlength="10">
					</div>
					<div class="group">
<!-- 						<label for="member_insert_job" class="label"></label> -->
						<input type="submit" class="button" value="등록">
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	let message = '${message}';
	let success = '${success}';
	
	if(message != ''){
		toastr.options = { "positionClass": "toast-top-center" }
		toastr["error"](message);
	}

	if(success != ''){
		toastr.options = { "positionClass": "toast-top-center" }
		toastr["success"](success);
	}
	
	function loginCheck(){
		if ($.trim($("#member_email").val()) == "") {
			toastr.options = { "positionClass": "toast-top-center" }
			toastr["error"]("email을 입력하세요.");
			$("#member_email").focus();
			return false;
		}else if($.trim($("#member_pw").val()) == "") {
			toastr.options = { "positionClass": "toast-top-center" }
			toastr["error"]("password을 입력하세요.");
			$("#member_pw").focus();
			return false;
		}
		return true;
	}

	function signUp(){
		if ($.trim($("#member_insert_email").val()) == "") {
			toastr.options = { "positionClass": "toast-top-center" }
			toastr["error"]("email을 입력하세요.");
			$("#member_insert_email").focus();
			return false;
		}else if($.trim($("#member_insert_pw").val()) == "") {
			toastr.options = { "positionClass": "toast-top-center" }
			toastr["error"]("password을 입력하세요.");
			$("#member_insert_pw").focus();
			return false;
		}else if($.trim($("#member_insert_name").val()) == "") {
			toastr.options = { "positionClass": "toast-top-center" }
			toastr["error"]("이름을 입력하세요.");
			$("#member_insert_name").focus();
			return false;
		}else if($.trim($("#member_insert_phone").val()) == "") {
			toastr.options = { "positionClass": "toast-top-center" }
			toastr["error"]("전화번호를 입력하세요.");
			$("#member_insert_phone").focus();
			return false;
		}else if($.trim($("#member_insert_job").val()) == "") {
			toastr.options = { "positionClass": "toast-top-center" }
			toastr["error"]("직책을 입력하세요.");
			$("#member_insert_job").focus();
			return false;
		}
		
		return true;
	}
</script>
</body>
</html>