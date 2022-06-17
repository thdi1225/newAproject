<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<div align="center">
		<table border="1" id="memberList">
			<tr>
				<th>번호</th>
				<th>메일</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>등록일</th>
				<th>부서</th>
				<th>직책</th>
				<th>권한</th>
				<th>수정</th>
				<th>삭제</th>
				<th>비밀번호 초기화</th>
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
					<td><c:if test="${list.member_auth == 0}">관리자</c:if> <c:if
							test="${list.member_auth == 1}">일반 사용자</c:if></td>
					<td><button type="button"
							onclick="memberSelect(${list.member_num})" data-toggle="modal"
							data-target="#memberUpdateModal">수정</button></td>
					<td><button type="button"
							onclick="memberDelete(${list.member_num})">삭제</button></td>
					<td><button type="button"
							onclick="memberPwReset(${list.member_num})">비밀번호 초기화</button></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	<!-- 회원 수정 모달 -->
	<div class="modal fade" id="memberUpdateModal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">회원 수정</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>

				<div class="modal-body">
					<input id="member_update_num" name="member_update_num" type="text"
						class="input">
					<div class="group">
						<label for="section_id" class="label">section</label> <select
							id="section_id" name="section_id" class="select">
							<option value="1">테스트 1</option>
							<option value="2">테스트 2</option>
							<option value="3">테스트 3</option>
						</select>
					</div>
					<div class="group">
						<label for="member_update_email" class="label">email</label> <input
							id="member_update_email" name="member_update_email" type="text"
							class="input">
					</div>
					<div class="group">
						<label for="member_update_name" class="label">name</label> <input
							id="member_update_name" name="member_update_name" type="text"
							class="input">
					</div>
					<div class="group">
						<label for="member_update_phone" class="label">phone</label> <input
							id="member_update_phone" name="member_update_phone" type="text"
							class="input">
					</div>
					<div class="group">
						<label for="member_update_job" class="label">job</label> <input
							id="member_update_job" name="member_update_job" type="text"
							class="input">
					</div>
					<div class="group">
						<label for="member_update_auth" class="label">auth</label>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="member_update_auth" id="member_update_admin" value="0">
							<label class="form-check-label" for="member_update_admin">관리자</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="member_update_auth" id="member_update_member" value="1">
							<label class="form-check-label" for="member_update_member">일반 사용자</label>
						</div>
					</div>

				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">Cancel</button>
					<button onclick="memberUpdate()">수정</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function memberSelect(member_num){
			$.ajax({
				url:"memberSelect.do",
				method:"post",
				data: {
					"member_num" : member_num
				},
				dataType : "json",
				success:function(result){
					$("#member_update_num").val(result.member_num);
					$("#section_id").val(result.section_id).prop("selected", true);
					$("#member_update_email").val(result.member_email);
					$("#member_update_name").val(result.member_name);
					$("#member_update_phone").val(result.member_phone);
					$("#member_update_job").val(result.member_job);
					if(result.member_auth == 0){
						$("#member_update_admin").prop("checked", true);
					}else if(result.member_auth == 1){
						$("#member_update_member").prop("checked", true);
					}
				}
			});
		}
		
		function memberUpdate(){
			$.ajax({
				url:"memberUpdate.do",
				method:"post",
				dataType : "json",
				data: {
					"member_num" : $("#member_update_num").val(),
					"section_id" : $("#section_id").val(),
					"member_email" : $("#member_update_email").val(),
					"member_name" : $("#member_update_name").val(),
					"member_phone" : $("#member_update_phone").val(),
					"member_job" : $("#member_update_job").val(),
					"member_auth" : $("input[name='member_update_auth']:checked").val()
				},
				dataType : "json",
				success:function(result){
					toastr.info("회원 수정을 성공하였습니다.");
					$("#memberList").load(location.href+" #memberList");
					$("#memberUpdateModal").modal("hide");
				}
			});
		}
		
		function memberDelete(member_num, member_name){
			$.ajax({
				url:"memberDelete.do",
				data: {
					"member_num" : member_num
				},
				dataType : "json",
				success:function(result){
					if(result == 1){
						toastr.info("회원삭제를 성공하였습니다.");
						document.getElementById("tr_"+member_num).remove();
					}else{
						toastr.info("회원삭제를 실패하였습니다.");
					}	
				}
			});
		}
		
		function memberPwReset(member_num){
			$.ajax({
				url:"memberPwReset.do",
				data: {
					"member_num" : member_num
				},
				dataType : "json",
				success:function(result){
					if(result == 1){
						toastr.info("비밀번호 초기화를 성공하였습니다.");
					}else{
						toastr.info("비밀번호 초기화를 실패하였습니다.");
					}	
				}
			});
		}
	</script>
</body>
</html>