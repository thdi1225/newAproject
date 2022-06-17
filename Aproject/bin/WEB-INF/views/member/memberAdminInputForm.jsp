<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="memberInsert.do" method="post">
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
			<input type="submit" class="button" value="Sign Up">
		</div>
	</form>
</body>
</html>