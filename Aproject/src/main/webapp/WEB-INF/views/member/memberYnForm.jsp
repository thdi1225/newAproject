<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
</head>
<body>
	<div align="center">
		<table class="table">
			<tr>
				<th>번호</th>
				<th>메일</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>등록일</th>
				<th>부서</th>
				<th>직책</th>
				<th>승인</th>
			</tr>
			<c:forEach items="${list}" var="list">
				<tr id="tr_${list.member_num}">
					<td>${list.member_num}</td>
					<td>${list.member_email}</td>
					<td>${list.member_name}</td>
					<td>${list.member_phone}</td>
					<td>${list.member_date}</td>
					<td>${list.section_id}</td>
					<td>${list.member_job}</td>
					<td><button class="table-btn" type="button" onclick="memberYn('${list.member_name}', '${list.member_num}')">승인</button></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	<script type="text/javascript">
		function memberYn(member_name, member_num){
			$.ajax({
				url:"memberYn.do",
				data: {
					"member_num" : member_num
				},
				success:function(result){
					toastr.info(member_name+"님 회원승인이 성공하였습니다.");
					document.getElementById("tr_"+member_num).remove();
				}
			});
		}
	</script>
</body>
</html>