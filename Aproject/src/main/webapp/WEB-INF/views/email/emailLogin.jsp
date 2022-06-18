<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/all.css" rel="stylesheet">
</head>
<body>
	<h1>이메일 로그인 페이지</h1>
	<input type="email" id="mailEmail" name = "mailEmail" placeholder="구글 이메일 입력">
	<input type="password" id="mailPw" name ="mailPw" placeholder="비밀번호 입력">
	<button type="button" id="loginBtn">로그인</button>
	<script>
		document.getElementById('loginBtn').addEventListener('click',e=>{
			$.ajax({
				url:'emailLoginService.do',
				type:'POST',
				data:{"mailEmail":$("#mailEmail").val(),"mailPw":$("#mailPw").val()},
				dataType:"json",
				success : function(res){
					let data = $.trim(res);
					if(data=="true"){
						alert("메일 계정 로그인되었습니다.");
						location.href='emailSend.do';
					}else{
						alert("아이디 또는 비밀번호를 다시 확인해주세요.");
						document.getElementById('mailEmail').value="";
						document.getElementById('mailPw').value="";
						
					}
				}
			})
		})
	</script>
</body>
</html>