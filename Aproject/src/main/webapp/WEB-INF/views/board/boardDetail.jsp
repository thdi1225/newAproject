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
	<button type="button"
			onclick="boardSelect(${board.board_id})" data-toggle="modal"
			data-target="#boardUpdateModal">수정</button>
	<button type="button"
			onclick="boardDelete(${board.board_id})">삭제</button>


	<table>
			<c:forEach items="${list}" var="boardReply">
			<tr>
				<td>${boardReply.board_reply_subject}</td>
			</tr>
			<tr>
				<td>${boardReply.board_reply_date}</td>
			</tr>
			<tr>
			
			</c:forEach>
	</table>
</div>
<!-- 회원 수정 모달 -->
	<div class="modal fade" id="boardUpdateModal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">게시글 수정</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>

				<div class="modal-body">
					<!-- <input id="board_update_id" name="boardr_update_id" type="text"
						class="input"> -->
				<!-- 	<div class="group">
						<label for="section_id" class="label">section</label> <select
							id="section_id" name="section_id" class="select">
							<option value="1">테스트 1</option>
							<option value="2">테스트 2</option>
							<option value="3">테스트 3</option>
						</select>
					</div> -->
					<div class="group">
						<label for="board_update_title" class="label">제목</label> <input
							id="board_update_title" name="board_update_title" type="text"
							class="input">
					</div>
					<div class="group">
						<label for="board_update_subject" class="label">내용</label> <input
							id="board_update_subject" name="board_update_subject" type="text"
							class="input">
					</div>
					<!-- <div class="group">
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
						</div> -->
					</div>

				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">Cancel</button>
					<button onclick="boardUpdate()">수정</button>
				</div>
			</div>
		</div>
			<form method="post" action="boardReplyInsert.do">
		<input type="text" id="board_reply_subject" name="board_reply_subject" placeholder="댓글 내용" size="30">
		<input id="board_id" name="board_id" value="${board.board_id}" type="hidden">
		<input type="button" onclick="boardReplyInsert()" value="등록">
	</form>
	<!-- </div> -->
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
function boardUpdate(){
	$.ajax({
		url:"boardUpdate.do",
		method:"post",
		dataType : "json",
		data: {
			"board_id" : $("#board_update_id").val();
			"board_title" : $("#board_update_title").val();
			"board_subject" : $("#board_update_subject").val();
		},
		dataType : "json",
		success:function(result){
			toastr.info("글수정완료");
			$("#boardList").load(location.href+"#boardList");
			$("#boardUpdateModal").modal("hide");
		}
	});
}

</script>
</body>
</html>