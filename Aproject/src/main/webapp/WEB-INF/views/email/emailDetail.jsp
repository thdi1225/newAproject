<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		<div class="titleCon">
			<c:if test="${empty email.emailFrom}">
				<p class="inline">TO :</p>
				<p id="to" class="toBlock inline">${email.emailTo}</p>
			</c:if>
			<c:if test="${empty email.emailTo}">
				<p class="inline">FROM :</p>
				<p class="toBlock inline">${email.emailFrom}</p>
			</c:if>
			<p class="title">${email.emailTitle}</p>
		</div>
		<div class="subject">
			<p>${email.emailSubject}</p>
		</div>
	</div>

</body>
</html>