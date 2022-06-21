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
	<div>
		<small class="float-right text-underline-bold">회원관리 > 회원조회</small>
		<h2 class="text-title">
			회원조회
		</h2>
	</div>
	
	<form action="memberSelectList.do" method="post">
		<div class="input-group mb-3">
			<input type="text" class="form-control" id="search" name="search" placeholder="이름으로 검색하실 수 있습니다." aria-label="Recipient's username" aria-describedby="searchButton">
			<div class="input-group-append">
			  <button class="btn btn-outline-secondary" type="submit" id="searchButton">검색</button>
			</div>
		</div>
	</form>
	<table class="table" id="memberList">
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
				<td><button class="table-btn" type="button"
						onclick="memberSelect(${list.member_num})" data-toggle="modal" data-target="#memberUpdateModal">수정</button></td>
				<td><button class="table-btn" type="button"
						onclick="memberDelete(${list.member_num})">삭제</button></td>
				<td><button class="table-btn" type="button"
						onclick="memberPwReset(${list.member_num})">비밀번호 초기화</button></td>
			</tr>
		</c:forEach>
	</table>
	
	<div style="display: block; text-align: center;">		
		<ul class="pagination justify-content-center">
			<c:if test="${paging.startPage != 1 }">
				<li class="page-item"><a class="page-link" href="memberSelectList.do?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a></li>
			</c:if>
		
			<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
				<c:choose>
					<c:when test="${p == paging.nowPage }">
						<li class="page-item active"><b class="page-link">${p}</b></li>
					</c:when>
					<c:when test="${p != paging.nowPage }">
						<li class="page-item"><a class="page-link" href="memberSelectList.do?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a></li>
					</c:when>
				</c:choose>
			</c:forEach>
		
			<c:if test="${paging.endPage != paging.lastPage}">
				<li class="page-item"><a class="page-link" href="memberSelectList.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a></li>
			</c:if>
		</ul>
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
					<input id="member_update_num" name="member_update_num" type="hidden" class="input">
					<div class="form-group row">
						<label for="section_id" class="col-sm-3 col-form-label">부서</label>
						<select id="section_id" name="section_id" class="col-sm-7 form-control">
							<c:forEach items="${sectionList}" var="list">
								<option value="${list.section_id}">${list.section_name}</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group row">
						<label for="member_update_email" class="col-sm-3 col-form-label">이메일</label> 
						<input id="member_update_email" name="member_update_email" type="email" class="col-sm-7 input">
					</div>
					<div class="form-group row">
						<label for="member_update_name" class="col-sm-3 col-form-label">이름</label> 
						<input id="member_update_name" name="member_update_name" type="text" class="col-sm-7 input">
					</div>
					<div class="form-group row">
						<label for="member_update_phone" class="col-sm-3 col-form-label">전화번호</label> 
						<input id="member_update_phone" name="member_update_phone" type="tel" class="col-sm-7 input">
					</div>
					<div class="form-group row">
						<label for="member_update_job" class="col-sm-3 col-form-label">직책</label> 
						<input id="member_update_job" name="member_update_job" type="text" class="col-sm-7 input">
					</div>
					<div class="form-group row">
						<label for="member_update_auth" class="col-sm-3 col-form-label">권한</label>
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
					<button class="btn btn-primary" onclick="memberUpdateCheck()">수정</button>
					<button class="btn btn-secondary" type="button"	data-dismiss="modal">Cancel</button>
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
								toastr.options = { "positionClass": "toast-top-center" }
								toastr["info"]("수정 되었습니다.");
								$("#memberList").load(location.href+" #memberList");
								$("#memberUpdateModal").modal("hide");
							}
					});
				}
			})
		}
		
		function memberDelete(member_num, member_name){
			swal({
				title: "정말 삭제하시겠습니까?",
				icon: "warning",
				buttons: true,
				dangerMode: true,
			}).then((willDelete) => {
				if (willDelete) {
					$.ajax({
						url:"memberDelete.do",
						data: {
							"member_num" : member_num
						},
						dataType : "json",
						success:function(result){
// 							console.log(result)
// 							if(result == 1){
								toastr.options = { "positionClass": "toast-top-center" }
								toastr["info"]("삭제 되었습니다.");
								document.getElementById("tr_"+member_num).remove();
// 							}else{
// 								toastr.options = { "positionClass": "toast-top-center" }
// 								toastr.info("회원삭제를 실패하였습니다.");
// 							}	
						},error:function(error){
							console.log(error)
						}
					});
				}
			})
		}
		
		function memberPwReset(member_num){
			swal({
				title: "정말 비밀번호를 초기화하시겠습니까?",
				icon: "warning",
				buttons: true,
				dangerMode: true,
			}).then((willDelete) => {
				if (willDelete) {
					$.ajax({
						url:"memberPwReset.do",
						data: {
							"member_num" : member_num
						},
						dataType : "json",
						success:function(result){
							if(result == 1){
								toastr.options = { "positionClass": "toast-top-center" }
								toastr.info("비밀번호 초기화를 성공하였습니다.");
							}else{
								toastr.options = { "positionClass": "toast-top-center" }
								toastr.info("비밀번호 초기화를 실패하였습니다.");
							}	
						}
					});
				}
			})
		}
	</script>
</body>
</html>