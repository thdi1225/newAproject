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
	<div>
		<small class="float-right text-underline-bold">회원관리 > 가입승인</small>
		<h2 class="text-title">
			가입승인
		</h2>
	</div>
	
	<form action="memberYnForm.do" method="post">
		<div class="input-group mb-3">
			<input type="text" class="form-control" id="search" name="search" placeholder="이름으로 검색하실 수 있습니다." aria-label="Recipient's username" aria-describedby="searchButton">
			<div class="input-group-append">
			  <button class="btn btn-outline-secondary" type="submit" id="searchButton">검색</button>
			</div>
		</div>
	</form>
	
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
	
	<div style="display: block; text-align: center;">		
		<ul class="pagination justify-content-center">
			<c:if test="${paging.startPage != 1 }">
				<li class="page-item"><a class="page-link" href="memberYnForm.do?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a></li>
			</c:if>
		
			<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
				<c:choose>
					<c:when test="${p == paging.nowPage }">
						<li class="page-item active"><b class="page-link">${p}</b></li>
					</c:when>
					<c:when test="${p != paging.nowPage }">
						<li class="page-item"><a class="page-link" href="memberYnForm.do?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a></li>
					</c:when>
				</c:choose>
			</c:forEach>
		
			<c:if test="${paging.endPage != paging.lastPage}">
				<li class="page-item"><a class="page-link" href="memberYnForm.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a></li>
			</c:if>
		</ul>
	</div>
	
	<script type="text/javascript">
		function memberYn(member_name, member_num){
			swal({
				title: "정말 승인하시겠습니까?",
				icon: "info",
				buttons: true,
			})
			.then((willDelete) => {
				if (willDelete) {
					$.ajax({
						url:"memberYn.do",
						data: {
							"member_num" : member_num
						},
						success:function(result){
							toastr.options = { "positionClass": "toast-top-center" }
							toastr.info(member_name+"님 회원승인이 성공하였습니다.");
							document.getElementById("tr_"+member_num).remove();
						}
					});
				}
			})
		}
	</script>
</body>
</html>