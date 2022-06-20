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
	<div class="form-group row">
		<label for="section_id" class="col-sm-2 col-form-label">section</label>
		<select id="section_id" name="section_id" class="col-sm-7 form-control">
			<c:forEach items="${sectionList}" var="list">
				<option value="${list.section_id}">${list.section_name}</option>
			</c:forEach>
		</select>
	</div>
	<div class="form-group row">
		<label for="member_update_email" class="col-sm-2 col-form-label">이메일</label> <input
			id="member_update_email" name="member_update_email" type="email" class="col-sm-7 input" value="${memberVO.member_email}">
	</div>
	<div class="form-group row">
		<label for="member_update_email" class="col-sm-2 col-form-label">비밀번호</label> <input
			id="member_update_email" name="member_update_pw" type="password" class="col-sm-7 input" value="${memberVO.member_pw}">
	</div>
	<div class="form-group row">
		<label for="member_update_name" class="col-sm-2 col-form-label">이름</label> 
		<input id="member_update_name" name="member_update_name" type="text" class="col-sm-7 input" value="${memberVO.member_name}">
	</div>
	<div class="form-group row">
		<label for="member_update_phone" class="col-sm-2 col-form-label">전화번호</label> 
		<input id="member_update_phone" name="member_update_phone" type="tel" class="col-sm-7 input" value="${memberVO.member_phone}">
	</div>
	<div class="form-group row">
		<label for="member_update_job" class="col-sm-2 col-form-label">직책</label> 
		<input id="member_update_job" name="member_update_job" type="text" class="col-sm-7 input" value="${memberVO.member_job}">
	</div>
	
	<button onclick="memberUpdateCheck()">수정</button>
	
	<script type="text/javascript">
		$("#section_id").val(${memberVO.section_id}).prop("selected", true);
		
		function memberUpdateCheck(){
			if ($.trim($("#member_update_email").val()) == "") {
				toastr.options = { "positionClass": "toast-top-center" }
				toastr["error"]("메일을 입력하세요.");
				$("#member_update_email").focus();
			}else if($.trim($("#member_update_name").val()) == "") {
				toastr.options = { "positionClass": "toast-top-center" }
				toastr["error"]("이름을 입력하세요.");
				$("#member_update_name").focus();
			}else if($.trim($("#member_update_phone").val()) == "") {
				toastr.options = { "positionClass": "toast-top-center" }
				toastr["error"]("전화번호을 입력하세요.");
				$("#member_update_phone").focus();
			}else if($.trim($("#member_update_job").val()) == "") {
				toastr.options = { "positionClass": "toast-top-center" }
				toastr["error"]("직책을 입력하세요.");
				$("#member_update_job").focus();
			}else{
				memberUpdate();
			}
		}
		
		function memberUpdate(){
			swal({
				title: "정말 수정하시겠습니까?",
				icon: "info",
				buttons: true,
			})
			.then((willDelete) => {
				if (willDelete) {
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
			})
		}
	</script>
</body>
</html>