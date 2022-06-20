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
		<small class="float-right text-underline-bold">부서관리 > 부서조회</small>
		<h2 class="text-title">
			부서조회
		</h2>
	</div>
	<hr>
	<form action="sectionSelectList.do" method="post">
		<div class="input-group mb-3">
			<input type="text" class="form-control" id="search" name="search" placeholder="부서명으로 검색하실 수 있습니다." aria-label="Recipient's username" aria-describedby="searchButton">
			<div class="input-group-append">
			  <button class="btn btn-outline-secondary" type="submit" id="searchButton">검색</button>
			</div>
		</div>
	</form>
	<table class="table" id="sectionList">
		<tr>
			<th>부서코드</th>
			<th>부서명</th>
			<th>부서순서</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		<c:forEach items="${list}" var="list">
			<tr id="tr_${list.section_id}">
				<td>${list.section_id}</td>
				<td>${list.section_name}</td>
				<td>${list.section_sort}</td>
				<td><button class="table-btn" type="button" onclick="sectionSelect(${list.section_id})" data-toggle="modal" data-target="#sectionUpdateModal">수정</button></td>
				<td><button class="table-btn" type="button" onclick="sectionDelete(${list.section_id})">삭제</button></td>
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
	<div class="modal fade" id="sectionUpdateModal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">부서 수정</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>

				<div class="modal-body">
					<div class="form-group">
						<label for="section_id" class="col-sm-3 col-form-label">부서코드</label> 
						<input id="section_id" name="section_id" type="text" class="col-sm-7 input" readonly="readonly">
					</div>
					<div class="form-group">
						<label for="section_name" class="col-sm-3 col-form-label">부서명</label> 
						<input id="section_name" name="section_name" type="text" class="col-sm-7 input">
					</div>
					<div class="form-group">
						<label for="section_sort" class="col-sm-3 col-form-label">부서순서</label> 
						<input id="section_sort" name="section_sort" type="text" class="col-sm-7 input">
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" onclick="sectionUpdateCheck()">수정</button>
					<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function sectionSelect(section_id){
			$.ajax({
				url:"sectionSelect.do",
				method:"post",
				data: {
					"section_id" : section_id
				},
				dataType : "json",
				success:function(result){
					$("#section_id").val(result.section_id);
					$("#section_name").val(result.section_name);
					$("#section_sort").val(result.section_sort);
				}
			});
		}
		
		function sectionUpdateCheck(){
			if($.trim($("#section_id").val()) == "") {
				toastr.options = { "positionClass": "toast-top-center" }
				toastr["error"]("부서코드을 입력하세요.");
				$("#section_id").focus();
			}else if($.trim($("#section_name").val()) == "") {
				toastr.options = { "positionClass": "toast-top-center" }
				toastr["error"]("부서명을 입력하세요.");
				$("#section_name").focus();
			}else if($.trim($("#section_sort").val()) == "") {
				toastr.options = { "positionClass": "toast-top-center" }
				toastr["error"]("부서순서을 입력하세요.");
				$("#section_sort").focus();
			}else{
				sectionUpdate();
			}
		}
		
		function sectionUpdate(){
			swal({
				title: "정말 수정하시겠습니까?",
				icon: "info",
				buttons: true,
			})
			.then((willDelete) => {
				if (willDelete) {
					$.ajax({
						url:"sectionUpdate.do",
						method:"post",
						dataType : "json",
						data: {
							"section_id" : $("#section_id").val(),
							"section_name" : $("#section_name").val(),
							"section_sort" : $("#section_sort").val()
						},
						dataType : "json",
						success:function(result){
							toastr.options = { "positionClass": "toast-top-center" }
							toastr.info("회원 수정을 성공하였습니다.");
							$("#sectionList").load(location.href+" #sectionList");
							$("#sectionUpdateModal").modal("hide");
						}
					});
				}
			})
		}
		
		function sectionDelete(section_id){
			swal({
				title: "정말 삭제하시겠습니까?",
				icon: "warning",
				buttons: true,
				dangerMode: true,
			}).then((willDelete) => {
				if (willDelete) {
					$.ajax({
						url:"sectionDelete.do",
						data: {
							"section_id" : section_id
						},
						dataType : "json",
						success:function(result){
							if(result == 1){
								toastr.options = { "positionClass": "toast-top-center" }
								toastr.info("부서삭제를 성공하였습니다.");
								document.getElementById("tr_"+section_id).remove();
							}else{
								toastr.options = { "positionClass": "toast-top-center" }
								toastr.info("부서삭제를 실패하였습니다.");
							}	
						},
						error:function(error){
							toastr.options = { "positionClass": "toast-top-center" }
							toastr.error("부서에 소속된 회원이 있습니다.");
						}
					});
				}
			})
		}
	</script>
</body>
</html>