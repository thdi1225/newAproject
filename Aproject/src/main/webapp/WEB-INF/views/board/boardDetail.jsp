<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
	<div><h3>상세보기</h3></div>
	${board.board_id } : ${board.board_writer } : ${board.board_date } : ${board.hit }
	<p>${board.board_title }</p>
	<p>${board.board_subject }</p> 


	<table>
			<c:forEach items="${list}" var="boardReply">
			<tr>
				<td>${boardReply.board_reply_subject}</td>
			</tr>
			<tr>
				<td>${boardReply.board_reply_date}</td>
			</tr>
			</c:forEach>
	</table>
	
	<form method="post" action="boardReplyInsert.do">
		<input type="text" id="board_reply_subject" name="board_reply_subject" placeholder="댓글 내용" size="30">
		<input id="board_id" name="board_id" value="${board.board_id}" type="hidden">
		<input type="button" onclick="boardReplyInsert()" value="등록">
	</form>
</div>
<script type="text/javascript">
function boardReplyInsert(){
	$.ajax({
		url:"boardReplyInsert.do",
		method:"post",
		data:{
			"board_reply_subject":$("#board_reply_subject").val(),
			"board_id" : $("#board_id").val()
		},
		success:function(){
			location.reload();	
		}
	})	
}

</script>
</body>
</html>