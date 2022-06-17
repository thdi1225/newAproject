<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div align="center">
		<form id="frm" action="emailService.do" method="post">
			
			받는 사람<input type="email" id="to" name="to" placeholder="이메일"><br>
			제목<input type="text" id="title" name="title" placeholder="제목"><br>
			<textarea id="subject" name="subject" rows="10" cols="30"></textarea><br>
			
			<button type="submit">전송</button>
		</form>
		<input type="button" value="메일 목록" onClick="location.href='emailRecieve.do'">
	</div>
</body>
</html>