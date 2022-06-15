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
	<div><h3>상세보기</h3></div>
	${board.board_id } : ${board.board_writer } : ${board.board_date } : ${board.hit }<p>
	${board.board_title }<p>
	${board.board_subject } 
	
</div>
</body>
</html>