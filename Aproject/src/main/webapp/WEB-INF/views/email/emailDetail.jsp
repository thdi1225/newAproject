<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/mail/mailDetail.css" rel="stylesheet">
</head>
<body>
	<div class="con">
		<p class="floatRight miniFont">${email.emailDate }</p>
		<div>
			<p class="inline">From : </p>
			<p class="toBlock inline">${email.emailFrom}</p>
			<p class="title">${email.emailTitle}</p>
		</div>
		<div class="subject">
			<p>${email.emailSubject}</p>
		</div>
		
	</div>
</body>
</html>