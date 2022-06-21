<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<link rel="stylesheet" href="css/all.css">
<title>Insert title here</title>
</head>
<style type="text/css">


.table {
  width: 100%;
  max-width: 100%;
  margin-bottom: 2rem;
  background-color: #fff;
  position: absolute;
  top: 100px;
}

.table-btn {
    padding: 3px 15px;
    border: 1px solid #ddd;
    background: #f1f1f1;
    border-radius: 5px;
    margin-bottom: 10px;

}

.table-box{
	overflow: auto;
	height: 60vh;
	width: 60%;
	position: relative;
	left: 50%;
	margin-left: -30%;

}

.month-font{
	display: inline;
	font-size: 50px;
}

.container-box{
	width: 100%;
	margin:auto;
	padding: 10px;
	
}

.table-location{
	width:600px;
	height:100px;
	position: absolute;
	left: 50%;
	margin-left:-200px;
	padding: 10px;
}
</style>
</head>

<body>


<div class="container-box">

	
			<div class="table-box">
				<div class="table-location">
				<div id="test2">
				<h1 style="display: inline; line-height: 100px; margin-right: 10px">사원 전체 리스트</h1>
				<button style="display: inline;" class="table-btn" onclick="test1();">월별 리스트 보기</button>
				</div>
				<div id="test" style="width: 600px;">
				<button type="button" onclick="lastMonth();" class="table-btn" >지난 달</button>
			  	<h1 style="display: inline;"><strong><span id="number" ></span></strong></h1><h1 style="display: inline;">월</h1>
				<button type="button" onclick="nextMonth();"class="table-btn">다음 달</button>
				<button class="table-btn" onclick="test2();">전체 리스트 보기</button>
				</div>
				</div>			
				
				<div id="test3">
				<table class="table" id="ta">
						<thead class="thead-primary">
							<tr>
								<th>순번</th>
								<th>날짜</th>
								<th>출근 시간</th>
								<th>퇴근 시간</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${emp}" var="emp">
							<tr>
								<td>${emp.commute_id}</td>
								<td>${emp.commute_date}</td>
								<td>${emp.commute_start_time}</td>
								<td>${emp.commute_end_time}</td>
								<td>${emp.member_num}</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
					</div>
			</div>
<script type="text/javascript">
	$("#test").hide();
	$("#endButton").hide();
	let today = new Date();
	let month = today.getMonth() + 1;
	document.getElementById("number").textContent = month;

	function test2(){
		$("#test").hide();
		$("#test2").show();
		$("#test3").load(location.href+" #test3")
	}
	
	function test1() {
		$("#test").show();
		$("#test2").hide();
		$.ajax({
			url:"commuteEmpSearchList.do",
			data:{
				"key": document.getElementById("number").textContent,"val":$("#val").val()
			},
			dataType : "json",
			success: function(data){
				 chdate(data)			
			},
		});
		
	}
	
	
	
	function lastMonth(){
		if(document.getElementById("number").textContent > 1){
			document.getElementById("number").textContent--;
		}else{
			document.getElementById("number").textContent = 12;
		}
		
		$.ajax({
			url:"commuteEmpSearchList.do",
			data:{
				"key": document.getElementById("number").textContent,"val":$("#val").val()
			},
			dataType : "json",
			success: function(data){
				 chdate(data)			
			},
		});
	}
	
	function nextMonth(){
		if(document.getElementById("number").textContent < 12){
			document.getElementById("number").textContent++;
		}else{
			document.getElementById("number").textContent = 1;
		}
		
		$.ajax({
			url:"commuteEmpSearchList.do",
			data:{
				"key": document.getElementById("number").textContent,"val":$("#val").val()
			},
			dataType : "json",
			success:function(data){
				 chdate(data)
			},
		});
	}
	
	 function chdate(data){
		$("tbody").remove();
		 tb = $("<tbody />");
		$.each(data, function(index,item){
		let tr = $("<tr />");
			tr.append(
					$("<td/>").text(item.commute_id),
					$("<td/>").text(new Date(item.commute_date).toLocaleDateString()),
					$("<td/>").text(new Date(item.commute_start_time).toTimeString().substr(0,8)),
					$("<td/>").text(new Date(item.commute_end_time).toTimeString().substr(0,8)),
					$("<td/>").text(item.member_num)
			);
			tb.append(tr);
		})
		$("#ta").append(tb);
	} 
	 
	 
	 
		
</script>	
<script src="js/jquery.min.js"></script>
  <script src="js/popper.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/main.js"></script>

</body>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<link rel="stylesheet" href="css/all.css">
<title>Insert title here</title>
</head>
<style type="text/css">


.table {
  width: 100%;
  max-width: 100%;
  margin-bottom: 2rem;
  background-color: #fff;
  position: absolute;
  top: 100px;
}

.table-btn {
    padding: 3px 15px;
    border: 1px solid #ddd;
    background: #f1f1f1;
    border-radius: 5px;
    margin-bottom: 10px;

}

.table-box{
	overflow: auto;
	height: 60vh;
	width: 60%;
	position: relative;
	left: 50%;
	margin-left: -30%;

}

.month-font{
	display: inline;
	font-size: 50px;
}

.container-box{
	width: 100%;
	margin:auto;
	padding: 10px;
	
}

.table-location{
	width:600px;
	height:100px;
	position: absolute;
	left: 50%;
	margin-left:-200px;
	padding: 10px;
}
</style>
</head>

<body>


<div class="container-box">

	
			<div class="table-box">
				<div class="table-location">
				<div id="test2">
				<h1 style="display: inline; line-height: 100px; margin-right: 10px">사원 전체 리스트</h1>
				<button style="display: inline;" class="table-btn" onclick="test1();">월별 리스트 보기</button>
				</div>
				<div id="test" style="width: 600px;">
				<button type="button" onclick="lastMonth();" class="table-btn" >지난 달</button>
			  	<h1 style="display: inline;"><strong><span id="number" ></span></strong></h1><h1 style="display: inline;">월</h1>
				<button type="button" onclick="nextMonth();"class="table-btn">다음 달</button>
				<button class="table-btn" onclick="test2();">전체 리스트 보기</button>
				</div>
				</div>			
				
				<div id="test3">
				<table class="table" id="ta">
						<thead class="thead-primary">
							<tr>
								<th>순번</th>
								<th>날짜</th>
								<th>출근 시간</th>
								<th>퇴근 시간</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${emp}" var="emp">
							<tr>
								<td>${emp.commute_id}</td>
								<td>${emp.commute_date}</td>
								<td>${emp.commute_start_time}</td>
								<td>${emp.commute_end_time}</td>
								<td>${emp.member_num}</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
					</div>
			</div>
<script type="text/javascript">
	$("#test").hide();
	$("#endButton").hide();
	let today = new Date();
	let month = today.getMonth() + 1;
	document.getElementById("number").textContent = month;

	function test2(){
		$("#test").hide();
		$("#test2").show();
		$("#test3").load(location.href+" #test3")
	}
	
	function test1() {
		$("#test").show();
		$("#test2").hide();
		$.ajax({
			url:"commuteEmpSearchList.do",
			data:{
				"key": document.getElementById("number").textContent,"val":$("#val").val()
			},
			dataType : "json",
			success: function(data){
				 chdate(data)			
			},
		});
		
	}
	
	
	
	function lastMonth(){
		if(document.getElementById("number").textContent > 1){
			document.getElementById("number").textContent--;
		}else{
			document.getElementById("number").textContent = 12;
		}
		
		$.ajax({
			url:"commuteEmpSearchList.do",
			data:{
				"key": document.getElementById("number").textContent,"val":$("#val").val()
			},
			dataType : "json",
			success: function(data){
				 chdate(data)			
			},
		});
	}
	
	function nextMonth(){
		if(document.getElementById("number").textContent < 12){
			document.getElementById("number").textContent++;
		}else{
			document.getElementById("number").textContent = 1;
		}
		
		$.ajax({
			url:"commuteEmpSearchList.do",
			data:{
				"key": document.getElementById("number").textContent,"val":$("#val").val()
			},
			dataType : "json",
			success:function(data){
				 chdate(data)
			},
		});
	}
	
	 function chdate(data){
		$("tbody").remove();
		 tb = $("<tbody />");
		$.each(data, function(index,item){
		let tr = $("<tr />");
			tr.append(
					$("<td/>").text(item.commute_id),
					$("<td/>").text(new Date(item.commute_date).toLocaleDateString()),
					$("<td/>").text(new Date(item.commute_start_time).toTimeString().substr(0,8)),
					$("<td/>").text(new Date(item.commute_end_time).toTimeString().substr(0,8)),
					$("<td/>").text(item.member_num)
			);
			tb.append(tr);
		})
		$("#ta").append(tb);
	} 
	 
	 
	 
		
</script>	
<script src="js/jquery.min.js"></script>
  <script src="js/popper.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/main.js"></script>

</body>
>>>>>>> branch 'main' of https://github.com/thdi1225/newAproject.git
</html>