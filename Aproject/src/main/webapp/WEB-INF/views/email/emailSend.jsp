<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	
	<link href="css/all.css" rel="stylesheet">
	<link href="css/mail/mailSend.css" rel="stylesheet">
</head>
<body>
	<div>
		<small class="float-right text-underline-bold">메일관리 > 메일 전송</small>
		<h2 class="text-title">메일 전송</h2>
	</div>
	<hr>
	<div class="spinner-border" role="status" align="center" id="loading">
	  	<span class="visually-hidden"></span>
	</div>
	
	<div id="con">
		<div class="title">
			<a>New Message</a>
		</div>
		<form id="frm" action="emailService.do" method="post">
			<ul class="subject">
				<li class="line marginBot">
					<p>받는 사람</p>
					<input type="email" id="to" name="to" required placeholder="example@gmail.com"/>
				</li>
				<li class="line">
					<p>제목</p>
					<input type="text" id="title" name="title" required placeholder="example"/>
				</li>
			</ul>
			<textarea id="subject" name="subject" rows="17" cols="30"></textarea><br>
			
			<input type="reset" value="취소">
			<input id="sendBtn" type="button" value="전송">
		</form>
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
			if($("#to").val().trim()=='' || $("#title").val().trim()=='' || $("#subject").val().trim()==''){
				alert("빈 칸을 입력해주세요.");
			}else{
				loadingPageOn();
				$.ajax({
					url:'emailService.do',
					data:{"to":$("#to").val(),"title":$("#title").val(),"subject":$("#subject").val()},
					dataType:"json",
					type:"POST",
					success:function(res){
						loadingPageOff();
						if(res==0){
							toastr.options = { "positionClass": "toast-top-center" }
							toastr["error"]("전송에 실패했습니다. 이메일 주소를 다시 확인해주세요.");
						}else{
							toastr.options = { "positionClass": "toast-top-center" }
							toastr["success"]("전송에 성공했습니다.");
							document.getElementById('to').value='';
							document.getElementById('title').value='';
							document.getElementById('subject').value='';
						}
						
					},
					error:function(res){
						loadingPageOff();
						toastr.options = { "positionClass": "toast-top-center" }
						toastr["error"]("전송에 실패했습니다. 이메일 주소를 다시 확인해주세요.");
					}
				})
			}
			
		})
	</script>
</body>
</html>