<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link  href="css/login.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="login-wrap">
	<div class="login-html">
		<input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">Sign In</label>
		<input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">Sign Up</label>
		<div class="login-form">
			<div class="sign-in-htm">
				<form action="login.do" method="post">
					<div class="group">
						<label for="member_email" class="label">email</label>
						<input id="member_email" name="member_email" type="email" class="input" maxlength="20">
						최대 20자
					</div>
					<div class="group">
						<label for="member_pw" class="label">password</label>
						<input id="member_pw" name="member_pw" type="password" class="input" data-type="password" maxlength="20">
						최대 20자
						<img alt="svg" src="img\undraw_posting_photo.svg">
					</div>
					<div class="group">
						<input type="submit" class="button" value="Sign In">
					</div>
				</form>
				<div class="hr"></div>
			</div>
			<div class="sign-up-htm">
				<form action="memberInsert.do" method="post">
					<div class="group">
						<label for="section_id" class="label">section</label>
						<select id="section_id" name="section_id" class="select">
							<c:forEach items="${sectionList}" var="list">
								<option value="${list.section_id}">${list.section_name}</option>
							</c:forEach>
						</select>
					</div>
					<div class="group">
						<label for="member_insert_email" class="label">email</label>
						<input id="member_insert_email" name="member_insert_email" type="email" class="input" maxlength="20">
						최대 20자
					</div>
					<div class="group">
						<label for="member_insert_pw" class="label">Password</label>
						<input id="member_insert_pw" name="member_insert_pw" type="password" class="input" data-type="password" maxlength="20">
						최대 20자
					</div>
					<div class="group">
						<label for="member_insert_name" class="label">name</label>
						<input id="member_insert_name" name="member_insert_name" type="text" class="input" maxlength="10">
						최대 10자
					</div>
					<div class="group">
						<label for="member_insert_phone" class="label">phone</label>
						<input id="member_insert_phone" name="member_insert_phone" type="tel" class="input" maxlength="20">
						최대 20자
					</div>
					<div class="group">
						<label for="member_insert_job" class="label">job</label>
						<input id="member_insert_job" name="member_insert_job" type="text" class="input" maxlength="10">
						최대 10자
					</div>
					<div class="group">
						<input type="submit" class="button" value="Sign Up">
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	let message = '${message}';
	if(message != ''){
		alert(message);
	}
</script>
</body>
</html>