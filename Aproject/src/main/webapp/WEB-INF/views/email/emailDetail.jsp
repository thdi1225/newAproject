<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/all.css" rel="stylesheet">
</head>
<body>
	<h1>${email.emailTitle}</h1>
	<p>보낸 날짜 : ${email.emailDate }</p>
	<p>보낸 사람 : ${email.emailFrom }</p>
	<p>${email.emailSubject}</p>
</body>
</html>