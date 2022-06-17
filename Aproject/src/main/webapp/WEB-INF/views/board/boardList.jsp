<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div align="center">
		<div>
			<h1>자유게시판</h1>
		</div>
		<div>
			<form action="boardList.do">
				<input type="text" id="search" name="search">&nbsp; 
				<input type="submit" value="검색">
			</form>
		</div>
		<br />
		<div>
			<table border="1" id="ta">
				<thead>
					<tr>
					
						<th width="100">글번호</th>
						<th width="150">작성자</th>
						<th width="250">제목</th>
						<th width="150">작성일자</th>
						<th width="100">조회수</th>
						<th width="200">첨부파일</th>
					</tr>
				</thead>
				<tbody id="tb">
					<c:forEach items="${list }" var="board">
						<tr onclick="boardDetail(${board.board_id })">
							<td align="center">${board.board_id }</td>
							<td align="center">${board.board_writer }</td>
							<td>${board.board_title }</td>
							<td align="center">${board.board_date }</td>
							<td align="center">${board.hit }</td>
							<td>${board.fileName }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div style="display: block; text-align: center;">		
				<c:if test="${paging.startPage != 1 }">
					<a href="boardList.do?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a>
				</c:if>
				<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
					<c:choose>
						<c:when test="${p == paging.nowPage }">
							<b>${p }</b>
						</c:when>
						<c:when test="${p != paging.nowPage }">
							<a href="boardList.do?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
						</c:when>
					</c:choose>
				</c:forEach>
				<c:if test="${paging.endPage != paging.lastPage}">
					<a href="boardList.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a>
				</c:if>
			</div>
		</div>
		<br/><br> 
		<form id="frmm" action="boardDetail.do" method="post">
			<input type="hidden" id="board_id" name="board_id">
		</form>

		<div>
			<button type="button" onclick="location.href='boardInputForm.do'">글쓰기</button>
		</div>
	</div>
	<script type="text/javascript">
	function boardDetail(board_id){
		frmm.board_id.value = board_id;
		frmm.submit();
	}
</script>
</body>
</html>