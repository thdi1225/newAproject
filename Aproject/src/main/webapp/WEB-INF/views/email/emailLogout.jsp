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
	<div class="box">
		<div class="logo">
			<img src="img/googleLogo.png" alt="google logo">
		</div>
		<h2>Sign Out</h2>
		<p>Good Bye!</p>

		<div class="inputBox">
			<input type="email" id="mailEmail"name="email" value="${memberVO.member_mail_email}" disabled>
			<label>User Email</label>
		</div>
		<div class="inputBox">
			<input type="password" id="mailPw" required value="">
			<label>Password</label>
		</div>
		<input type="button" id="logoutBtn" name="sign-in" value="Sign Out">
	</div>


	<script>
		document.getElementById('logoutBtn').addEventListener('click',e=>{
			$.ajax({
				url:'emailLogoutService.do',
				type:"POST",
				data:{"mailPw":$("#mailPw").val(),"logout":false},
				dataType:"json",
				success : function(res){
					let data = $.trim(res)
					if(data=="true"){
						let re = confirm("정말 로그아웃하시겠습니까?");
						if(re==true){
							$.ajax({
								url:'emailLogoutService.do',
								type:"POST",
								data:{"mailPw":false,"logout":true},
								dataType:"json",
								success:function(r){
									alert("로그아웃되었습니다.");
									location.href='emailLogin.do';
								}
							})
						}else{
							alert("로그아웃을 취소했습니다.")
						}
					}else{
						alert("비밀번호가 틀렸습니다.");
					}
				},
				error : function(){
					console.log("실패");
				}
			})
		})
	</script>
</body>
</html>