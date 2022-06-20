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
		<small class="float-right text-underline-bold">메일관리 > 메일 계정 로그아웃</small>
		<h2 class="text-title">메일 계정 로그아웃</h2>
	</div>
	<hr>
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
						swal({
							title: "정말 로그아웃 하시겠습니까?",
							icon: "warning",
							buttons: true,
							dangerMode: true,
						}).then((willDelete) => {
							if (willDelete) {
								$.ajax({
									url:'emailLogoutService.do',
									type:"POST",
									data:{"mailPw":false,"logout":true},
									dataType:"json",
									success:function(r){
										swal({
											title: "로그아웃 되었습니다.",
											icon: "success"
										}).then((willDelete) => {
											location.href='emailSend.do';
										})
									}
								})
							}else{
								toastr.options = { "positionClass": "toast-top-center" }
								toastr["success"]("로그아웃을 취소했습니다.");
							}
						})
					}else{
						toastr.options = { "positionClass": "toast-top-center" }
						toastr["error"]("비밀번호가 틀렸습니다.");
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