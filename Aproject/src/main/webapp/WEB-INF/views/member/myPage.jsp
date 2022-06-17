<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<input id="member_update_num" name="member_update_num" type="hidden" class="input" value="${memberVO.member_num}">
	<div class="group">
		<label for="section_id" class="label">section</label>
		<select id="section_id" name="section_id" class="select">
			<c:forEach items="${sectionList}" var="list">
				<option value="${list.section_id}">${list.section_name}</option>
			</c:forEach>
		</select>
	</div>
	<div class="group">
		<label for="member_update_email" class="label">email</label> <input
			id="member_update_email" name="member_update_email" type="email" class="input" value="${memberVO.member_email}">
	</div>
	<div class="group">
		<label for="member_update_email" class="label">password</label> <input
			id="member_update_email" name="member_update_pw" type="password" class="input" value="${memberVO.member_pw}">
	</div>
	<div class="group">
		<label for="member_update_name" class="label">name</label> 
		<input id="member_update_name" name="member_update_name" type="text" class="input" value="${memberVO.member_name}">
	</div>
	<div class="group">
		<label for="member_update_phone" class="label">phone</label> 
		<input id="member_update_phone" name="member_update_phone" type="tel" class="input" value="${memberVO.member_phone}">
	</div>
	<div class="group">
		<label for="member_update_job" class="label">job</label> 
		<input id="member_update_job" name="member_update_job" type="text" class="input" value="${memberVO.member_job}">
	</div>
	
	<button onclick="memberUpdate()">수정</button>
	
	<script type="text/javascript">
		$("#section_id").val(${memberVO.section_id}).prop("selected", true);
		
		function memberUpdate(){
			$.ajax({
				url:"memberMyPage.do",
				method:"post",
				dataType : "json",
				data: {
					"member_num" : $("#member_update_num").val(),
					"section_id" : $("#section_id").val(),
					"member_email" : $("#member_update_email").val(),
					"member_pw" : $("#member_update_pw").val(),
					"member_name" : $("#member_update_name").val(),
					"member_phone" : $("#member_update_phone").val(),
					"member_job" : $("#member_update_job").val()
				},
				dataType : "json",
				success:function(result){
					toastr.info("회원 수정을 성공하였습니다.");
					location.href="home.do";
				}
			});
		}
	</script>
</body>
</html>