<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/board.css">
</head>
<body>
	<div>
		<small class="float-right text-underline-bold">커뮤니티 > 게시글 상세보기</small>
		<h2 class="text-title">
			게시글 상세보기
		</h2>
	</div>
	<hr>
	<div class="con">
      <p class="floatRight miniFont">${board.board_date }</p>
      <div class="titleCon">
            <p class="inline">작성자 :</p>
            <p class="toBlock inline">${board.board_writer}</p>
            <p class="title">${board.board_title}</p>
      </div>
      <div class="subject">
         <p>${board.board_subject}</p>
      </div>
   </div>
	
	<button type="button" class="table-btn"
			onclick="boardSelect(${board.board_id})" data-toggle="modal"
			data-target="#boardUpdateModal">수정</button>
	<button type="button" class="table-btn"
			onclick="boardDelete(${board.board_id})">삭제</button>
	<button type="button" class="table-btn"
			onclick="location.href='boardList.do'">목록</button>
	<hr>
	<br>
	<div>
		<h2 class="text-title">
			댓글
		</h2>
	</div>
	   
	<table class="table">
			<c:forEach items="${list}" var="boardReply">
			<tbody>
			<tr id="tr_${boardReply.board_reply_id}">
				<td width="500px">${boardReply.board_reply_subject}</td>
				<td width="50px">${boardReply.board_reply_date}</td>
				<td width="10px"><button type="button" onclick="boardReplyId(${boardReply.board_reply_id})" data-toggle="modal" data-target="#boardReplyUpdateModal" class="table-btn">수정</button></td>
				<td width="10px"><button type="button" onclick="boardReplyDelete(${boardReply.board_reply_id})"data-toggle="modal" data-target="#boardReplyDeleteModal" class="table-btn">삭제</button></td>
			</tr>
			</tbody>
			</c:forEach>
	   
	</table>
	<form method="post" action="boardReplyInsert.do">
		<input type="text" id="board_reply_subject" name="board_reply_subject" placeholder="댓글 내용" size="30">
		<input id="board_id" name="board_id" value="${board.board_id}" type="hidden">
		<input class="table-btn" type="button" onclick="boardReplyInsert()" value="등록">
		
	</form>


<!-- 게시글 수정 모달 -->
<div class="modal fade" id="boardUpdateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">게시글 수정</h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
			<input id="board_update_id" name="board_update_id" type="hidden" class="input" value="${board.board_id}">
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
			</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" class="table-btn"
					data-dismiss="modal">취소</button>
				<button onclick="boardUpdate()" class="table-btn">수정</button>
			</div>
		</div>
	</div>
</div>

<!-- 댓글수정모달 -->
<div class="modal fade" id="boardReplyUpdateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">댓글 수정</h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
			<input id="board_reply_update_id" name="board_reply_update_id" type="hidden" class="input">
				<div class="group">
					<label for="board_reply_update_subject" class="label">내용</label> <input
						id="board_reply_update_subject" name="board_reply_update_subject" type="text"
						class="input">
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" class="table-btn"
					data-dismiss="modal">취소</button>
				<button class="table-btn" onclick="boardReplyUpdate(${boardReply.board_reply_subject})">수정</button>
			</div>
		</div>
	</div>
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
			swal({
				title: "댓글을 등록하였습니다.",
				icon: "success"
			}).then((willDelete) => {
				location.reload();
			})
		}
	})	
}

function boardReplyUpdate(){
	$.ajax({
		url:"boardReplyUpdate.do",
		method:"post",
		dataType : "json",
		data: {
			"board_reply_id" : $("#board_reply_update_id").val(),
			"board_reply_subject" : $("#board_reply_update_subject").val(),
		},
		dataType : "json",
		success:function(result){
			swal({
				title: "댓글을 수정하였습니다.",
				icon: "success"
			}).then((willDelete) => {
				location.reload();
				$("#boardReplyUpdateModal").modal("hide");
			})
		}
	});
}

function boardUpdate(){
	$.ajax({
		url:"boardUpdate.do",
		method:"post",
		dataType : "json",
		data: {
			"board_id" : $("#board_update_id").val(),
			"board_title" : $("#board_update_title").val(),
			"board_subject" : $("#board_update_subject").val(),
		},
		dataType : "json",
		success:function(result){
			swal({
				title: "게시글을 수정하였습니다.",
				icon: "success"
			}).then((willDelete) => {
				location.reload();
				$("#boardUpdateModal").modal("hide");
			})
		}
	});
}

function boardDelete(board_id){
	$.ajax({
		url:"boardDelete.do",
		data: {
			"board_id" : board_id
		},
		dataType : "json",
		success:function(result){
			if(result == 1){
				swal({
					title: "게시글을 삭제하였습니다.",
					icon: "success"
				}).then((willDelete) => {
					location.href="boardList.do"
				})
			}	
		}
	});
}

function boardReplyDelete(board_reply_id){
	$.ajax({
		url:"boardReplyDelete.do",
		data: {
			"board_reply_id" : board_reply_id
		},
		dataType : "json",
		success:function(result){
			if(result == 1){
			    swal({
					title: "댓글을 삭제하였습니다.",
					icon: "success"
				}).then((willDelete) => {
					document.getElementById("tr_"+board_reply_id).remove();
				})
			}	
		}
	});
}

function boardReplyId(board_reply_id){
	$("#board_reply_update_id").val(board_reply_id);
}
</script>
</body>
</html>