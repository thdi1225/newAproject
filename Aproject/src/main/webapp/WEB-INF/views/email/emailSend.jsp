<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="spinner-border" role="status" align="center" id="loading">
	  	<span class="visually-hidden"></span>
	</div>
	
	<div id="con" align="center">
		<form id="frm" action="emailService.do" method="post">
			받는 사람<input type="email" id="to" name="to" placeholder="이메일"><br>
			제목<input type="text" id="title" name="title" placeholder="제목"><br>
			<textarea id="subject" name="subject" rows="10" cols="30"></textarea><br>
			
			<button id="sendBtn" type="button">전송</button>
		</form>
		<input type="button" value="메일 목록" onClick="location.href='emailRecieve.do'">
	</div>
	<script>
		//로딩 페이지
		var loader = document.getElementById('loading');
		var con = document.getElementById('con');
		loader.style.display="none";
		
		function loadingPageOn(){
			loader.style.display="block";
			con.style.display="none";
		}
		
		function loadingPageOff(){
			loader.style.display="none";
			con.style.display="block";
		}
		document.getElementById('sendBtn').addEventListener('click',e=>{
			loadingPageOn();
			document.forms.frm.submit();
		})
	</script>
</body>
</html>