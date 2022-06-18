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
	<h1>이메일 로그아웃 페이지입니다.</h1>
	<div >
		<a>현재 로그인 이메일 : ${memberVO.member_mail_email}</a>
		<input type="password" id="mailPw" name="mailPw" placeholder="비밀번호">
		<input type="button" id="logoutBtn" value="구글 계정 로그아웃">
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