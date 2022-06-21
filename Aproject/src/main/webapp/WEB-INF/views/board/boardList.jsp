<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.6.0.min.js"></script>
<style type="text/css">
.table tr:hover{
	background-color:rgba(194,208,234,0.2);
	color:black;
	cursor:pointer;
}
</style>
</head>
<body>
	<div>
		<small class="float-right text-underline-bold">커뮤니티 > 게시판 목록</small>
		<h2 class="text-title">
			게시판 목록
		</h2>
		<hr>
	</div>
			<form action="boardList.do" method="post">
		
			<div class="input-group mb-3">
				<input type="text" class="form-control" id="search" name="search">&nbsp; 
			    <div class="input-group-append">
				<input class="btn btn-outline-secondary" type="submit" value="검색">
				</div>
			</div>
	   
		</form>
		<div>
			<table class="table" id="ta">
					<tr>
						<th>글번호</th>
						<th>작성자</th>
						<th>제목</th>
						<th>작성일자</th>
						<th>조회수</th>
<!-- 						<th>첨부파일</th> -->
					</tr>
					<c:forEach items="${list }" var="board">
						<tr onclick="boardDetail(${board.board_id })">
							<td align="center">${board.board_id }</td>
							<td align="center">${board.board_writer }</td>
							<td>${board.board_title }</td>
							<td align="center">${board.board_date }</td>
							<td align="center">${board.hit }</td>
<%-- 							<td>${board.fileName }</td> --%>
						</tr>
					</c:forEach>
			</table>
			<div style="display: block; text-align: center;">	
				<ul class="pagination justify-content-center">	
				<c:if test="${paging.startPage != 1 }">
					<li class="page-item"><a class="page-link"href="boardList.do?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a></li>
				</c:if>
				<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
					<c:choose>
						<c:when test="${p == paging.nowPage }">
						<li class="page-item active"><b class="page-link">${p }</b></li>
						</c:when>
						<c:when test="${p != paging.nowPage }">
							<li class="page-item"><a class="page-link"href="boardList.do?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a></li>
						</c:when>
					</c:choose>
				</c:forEach>
				
				<c:if test="${paging.endPage != paging.lastPage}">
					<li class="page-item"><a class="page-link"href="boardList.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a></li>
				</c:if>
			   </ul>
			</div>
		</div>
		<br/><br> 
		<form id="frmm" action="boardDetail.do" method="post">
			<input type="hidden" id="board_id" name="board_id">
		</form>

		
			<button class="table-btn" type="button" onclick="location.href='boardInputForm.do'">글쓰기</button>
		
	</div>
	<script type="text/javascript">
	let message = "${message}"
	if(message != null && message != ''){
		toastr.options = { "positionClass": "toast-top-center" }
		toastr["success"](message);
	}
	
	function boardDetail(board_id){
		frmm.board_id.value = board_id;
		frmm.submit();
	}
</script>
</body>
</html>