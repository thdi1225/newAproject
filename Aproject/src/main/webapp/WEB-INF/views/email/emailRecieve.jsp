<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	tbody tr:hover{
		background-color : blue;
		color:white;
	}
</style>
</head>
<body>
	<div align="center">
		<input type="button" onclick="location.href='emailRecieve.do?type=refresh'" value="새로고침">
		<input type="button" value="선택 삭제" id="selectDelete">
		<table border="1">
			<thead>
				<tr>
					<th width="100">선택</th>
					<th width="100">No.</th>
					<th width="200">보낸사람</th>
					<th width="300">제목</th>
					<th width="200">전송 시간</th>
					<th width="100">삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${emails}" var="email">
					<tr id="detailEmail">
						<td><input type="checkbox" id="oneCheck"></td>
						<td id="emailId">${email.emailId}</td>
						<td>${email.emailFrom}</td>
						<td>${email.emailTitle}</td>
						<td><fmt:formatDate value="${email.emailDate}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
						<td><input type="button" value="삭제" id="deleteEmail"></td>
					</tr>
				</c:forEach>
				
			</tbody>
		</table>
	</div>
	<script type="text/javascript">
        var cols = document.querySelectorAll("#deleteEmail");

        for (var i = 0; i < cols.length; i++) {
            cols[i].addEventListener("click", delEmail);
        }

        function delEmail(e) {
            let emailId = e.target.parentElement.parentElement.children[1].innerText; //id값이 있는 위치!!
            let param = 'emailId='+emailId;
            console.log(param);
            e.target.parentElement.parentElement.remove();
            fetch('emailDelete.do',{
            	method : 'post',
  			  	headers : {'Content-Type':'application/x-www-form-urlencoded'},
  			  	body : param
            })
        }

	</script>
</body>
</html>