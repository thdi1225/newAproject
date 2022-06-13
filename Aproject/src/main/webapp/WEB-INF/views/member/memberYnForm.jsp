<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<table>
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
				<td><button type="button" onclick="memberYn(${list.member_name}, ${list.member_num})">승인</button></td>
			</tr>
		</c:forEach>
	</table>
	<script type="text/javascript">
		function memberYn(member_name, member_num){
			$.ajax({
				url:"memberYn.do",
				data: {
					"member_num" : member_num
				},
				success:function(result){
					toastr.info("님 회원승인이 성공하였습니다.");

					document.getElementById("tr_"+member_num).remove();
				}
			});
		}
	</script>
</body>
</html>