<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/all.css">
</head>
<body>
<div>
		<small class="float-right text-underline-bold">커뮤니티 > 게시글 등록</small>
		<h2 class="text-title">
			게시글 등록
		</h2>
		<hr>
	</div>
	<div>
		<form id="frm" action="boardInput.do" method="post" enctype="multipart/form-data">
			<div>
			<input type="hidden" id="member_num" name="member_num" value="${memberVO.member_num}">
				<table class="table">
					<tr>
						<th>작성자</th>
						<td>							
							<input type="text" id="writer" name="writer" required="required">
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td colspan="3">
							<input type="text" size="120" id="title" name="title" required="required">
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="3">
							<textarea rows="10" cols="120" id="subject" name="subject"></textarea>
						</td>
					</tr>
				</table>
			</div><br/>
			<div>
				<input class="table-btn" type="submit" value="저장">&nbsp;&nbsp;
				<input class="table-btn" type="button" value="취소" onclick="location.href='boardList.do'">
			</div>
		</form>
	</div>
</div>
</body> 
</html>