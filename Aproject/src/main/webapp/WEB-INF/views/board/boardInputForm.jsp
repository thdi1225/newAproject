<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
	<div><h1>게시글 등록</h1></div>
	<div>
		<form id="frm" action="boardInput.do" method="post" enctype="multipart/form-data">
			<div>
				<table border="1">
					<tr>
						<th width="150">작성자</th>
						<td width="150">
							<input type="text" id="writer" name="writer" required="required">
						</td>
						<!-- <th width="150">작성일자</th>
						<td width="150">
							<input type="date" id="wdate" name="wdate" required="required">
						</td> -->
					</tr>
					<tr>
						<th>제목</th>
						<td colspan="3">
							<input type="text" size="66" id="title" name="title" required="required">
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="3">
							<textarea rows="10" cols="66" id="subject" name="subject"></textarea>
						</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td colspan="3">
							<input type="file" id="file" name="file">
						</td>
					</tr>
				</table>
			</div><br/>
			<div>
				<input type="submit" value="저장">&nbsp;&nbsp;
				<input type="button" value="취소" onclick="location.href='boardList.do'">
			</div>
		</form>
	</div>
</div>
</body>
</html>