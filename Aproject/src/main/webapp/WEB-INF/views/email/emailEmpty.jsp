<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/mail/mail.css" rel="stylesheet">
</head>
<body>
	<div class="spinner-border" role="status" align="center" id="loading">
	  	<span class="visually-hidden"></span>
	</div>
	<div id="con">
		<input type="button" id="refreshBtn" value="동기화" class="btn-dark refreshBtn">
		<p>메일함이 비었습니다!</p>
	</div>
	<script>
		var loader = document.getElementById('loading');
		var con = document.getElementById('con');
		loadingPageOff();
		
		function loadingPageOn(){
			loader.style.display="block";
			con.style.display="none";
		}
		
		function loadingPageOff(){
			loader.style.display="none";
			con.style.display="block";
		}
		document.getElementById('refreshBtn').addEventListener('click',e=>{
	    	loadingPageOn();
			$.ajax({
	    		url:'emailRecieve.do',
	    		type:"POST",
	    		data:{"type":"refresh"},
	    		dataType:"json",
	    		success:function(){
	    			console.log("데이터 있음")
	    			location.href='emailRecieve.do';
	    		},
	    		error:function(){
	    			console.log("data 없음");
	    			loadingPageOff();
	    		}
	    	})
	    })
	</script>
</body>
</html>