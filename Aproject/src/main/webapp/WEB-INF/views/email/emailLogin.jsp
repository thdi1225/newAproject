<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/mail/googleMail.css">
</head>
<body>
	<div>
		<small class="float-right text-underline-bold">메일관리 > 메일 계정 로그인</small>
		<h2 class="text-title">메일 계정 로그인</h2>
	</div>
	<hr>
	<div id="spin" align="center">
		<div class="spinner-border" role="status" align="center" id="loading">
			<span class="visually-hidden"></span>
		</div>
	</div>
	
	<div id="box" class="box">
		<div class="logo">
			<img src="img/googleLogo.png" alt="google logo">
		</div>
		<h2>Sign In</h2>
		<p>Use your Google Account</p>

		<div class="inputBox">
			<input type="email" id="mailEmail" name="mailEmail" value="" required>
			<label>User Email</label>
		</div>
		<div class="inputBox">
			<input type="password" id="mailPw" name="mailPw" required value=""> 
			<label>Password</label>
		</div>
		<input type="button" id="loginBtn" name="sign-in" value="Sign In">
	</div>
	
	<script>
		//로딩 페이지
		var loader = document.getElementById('loading');
		var box = document.getElementById('box');
		loader.style.display="none";
		
		function loadingPageOn(){
			loader.style.display="block";
			box.style.display="none";
		}
		
		function loadingPageOff(){
			loader.style.display="none";
			box.style.display="block";
		}
		document.getElementById('loginBtn').addEventListener('click',e=>{
			loadingPageOn();
			$.ajax({
				url:'emailLoginService.do',
				type:'POST',
				data:{"mailEmail":$("#mailEmail").val(),"mailPw":$("#mailPw").val()},
				dataType:"json",
				success : function(res){
					loadingPageOff();
					let data = $.trim(res);
					if(data=="true"){
						swal({
							title: "메일 계정 로그인되었습니다.",
							icon: "success"
						}).then((willDelete) => {
							location.href='emailSend.do';
						})
					}else{
						swal('아이디 또는 비밀번호를 다시 확인해주세요.', '', "warning");
						document.getElementById('mailEmail').value="";
						document.getElementById('mailPw').value="";
					}
				}
			})
		})
	</script>
</body>
</html>