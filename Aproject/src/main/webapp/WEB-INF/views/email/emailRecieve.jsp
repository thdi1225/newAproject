<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div align="center">
		<table border="1">
			<thead>
				<tr>
					<th width="100">No.</th>
					<th width="200">보낸사람</th>
					<th width="300">제목</th>
					<th width="200">전송 시간</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${emails}" var="email">
					<tr>
						<td>${email.emailId}</td>
						<td>${email.emailFrom}</td>
						<td>${email.emailTitle}</td>
						<td><fmt:formatDate value="${email.emailDate}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
						
					</tr>
				</c:forEach>
			</tbody>
			
			
		</table>
	</div>
</body>
</html>