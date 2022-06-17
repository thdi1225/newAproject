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
	
	<link rel="stylesheet" href="css/style.css">
<title>Insert title here</title>
<style type="text/css">

/* #end{ */
/* 	display: none; */
/* } */
/* #start{ */
/* 	display: block; */
/* } */

.button {
  background-color: #008CBA;
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}
#clock {
	width: 500px;
	height: 250px;
	line-height: 250px;
	color: #666;
	font-size: 80px;
	text-align: center;
}

.left-box {
	float: left;
}

.container {
	float: right;
	overflow: auto;
}
</style>
</head>
<script>
	function printClock() {
		var clock = document.getElementById("clock");
		var currentDate = new Date();
		var calendar = currentDate.getFullYear() + "-"
				+ (currentDate.getMonth() + 1) + "-" + currentDate.getDate() // 현재 날짜
		var amPm = 'AM';
		var currentHours = addZeros(currentDate.getHours(), 2);
		var currentMinute = addZeros(currentDate.getMinutes(), 2);
		var currentSeconds = addZeros(currentDate.getSeconds(), 2);

		if (currentHours >= 12) {
			amPm = 'PM';
			currentHours = addZeros(currentHours - 12, 2);
		}

		if (currentSeconds >= 50) {
			currentSeconds = '<span style="color:#de1951;">' + currentSeconds
					+ '</span>'
		}

		clock.innerHTML = currentHours + ":" + currentMinute + ":"
				+ currentSeconds + " <span style='font-size:50px;'>" + amPm
				+ "</span>"; //날짜를 출력해 줌
		setTimeout("printClock()", 1000);
	}
	function addZeros(num, digit) {

		var zero = '';
		num = num.toString();
		if (num.length < digit) {
			for (i = 0; i < digit - num.length; i++) {
				zero += '0';
			}
		}

		return zero + num;
	}
</script>

<body onload="printClock()">
	<div class="left-box">
		<div id="clock"></div>
		<div id="sumbit-box" style="margin-left: auto; margin-right: auto;">
		
			<input type="hidden" value="${checkInt}" id="commuteCheck">
		
			<form action="commuteStartInsert.do" method="post" style="display: inline-block;">
				<input type="button" id="startButton" value="출근하기"  onclick="start_button();">
			</form>
			<form action="commuteEndUpdate.do" method="post"
				style="display: inline-block;">
				<input type="button" id="endButton"  value="퇴근하기"  onclick="end_button();">
			</form>
			
			
		</div>
	</div>
	
	<div style="height: 60vh">
	<div class="container" style="height:100%">
		<div class="col-md-6 text-center mb-5"></div>
		<div class="row">
			<div class="col-md-12">
				<div class="table-wrap">
				
				<button type="button" onclick="lastMonth();">지난 달</button>
			  	<h1><span id="number" ></span></h1>
				<button type="button" onclick="nextMonth();">다음 달</button>
				
				
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
						<c:forEach items="${list}" var="li">
							<tr>
								<td>${li.commute_id }</td>
								<td>${li.commute_date}</td>
								<td>${li.commute_start_time}</td>
								<td>${li.commute_end_time}</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	</div>
	
<script type="text/javascript">
		
	$("#endButton").hide();
	let today = new Date();
	let month = today.getMonth() + 1;
	document.getElementById("number").textContent = month;

	
	function lastMonth(){
		if(document.getElementById("number").textContent > 1){
			document.getElementById("number").textContent--;
		}else{
			document.getElementById("number").textContent = 12;
		}
		
		$.ajax({
			url:"commuteSelectDate.do",
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
			url:"commuteSelectDate.do",
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
			tr.append($("<td/>").text(item.commute_id),
					$("<td/>").text(new Date(item.commute_date).toLocaleDateString()),
					$("<td/>").text(new Date(item.commute_start_time).toTimeString().substr(0,8)),
					$("<td/>").text(new Date(item.commute_end_time).toTimeString().substr(0,8)) 
			);
			tb.append(tr);
		})
		$("#ta").append(tb);
	} 
	 
	 
	 function start_button(){
		  $.ajax({
			  url:"commuteStartInsert.do",
				success:function(result){
					if(result == 0){
						$("#ta").load(location.href+" #ta")
						$("#startButton").hide();
						$("#endButton").show();
					}else{
						alert("출근하셨습니다.");
					}
				},
				error: function(){
					console.log("error")
				}
		  });
	 }
		 
	 
	 
	 function end_button(){
		 $.ajax({
			  url:"commuteEndUpdate.do",
			  success: function(){
					$("#ta").load(location.href+" #ta")
					$("#startButton").show();
					$("#endButton").hide();
				},
				error: function(){
					console.log("error")
				}
		});
		
	 }
	 
</script>	
<script src="js/jquery.min.js"></script>
  <script src="js/popper.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/main.js"></script>
  


</body>
</html>