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
<style type="text/css">

.select-box {
	display: block;
	font-size: 18px;
	color: #60666d;
	border: 2px solid #60666d;
	border-radius: 5px;
	padding: 5px;
	font-size: 14px;
	position: absolute;
	left:50%;
	width: 100px;
	margin-left: -50px;
	
	
}
.select-box:hover{
background: #68718b;
	color: #fff;
}
.table {
  width: 100%;
  max-width: 100%;
  margin-bottom: 2rem;
  background-color: #fff;
  position: absolute;
  top: 70px;
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

}
#clock {
	width: 500px;
	height: 250px;
	line-height: 250px;
	color: #666;
	font-size: 80px;
	text-align: center;
	margin-left: auto;
	margin-right: auto;
}

.left-box {
	width: 40%;
	height:400px;
	position: relative;
}



.month-font{
	display: inline;
	font-size: 50px;
}

.container-box{
	width: 100%;
	margin: 0;
	padding: 10px;
	display: flex;
	
}
.table-location{
	width:600px;
	position: absolute;
	left: 50%;
	margin-left:-150px;
	padding: 10px;
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
		
		if(currentHours == 00){
			currentHours = '<span style="color:#3b61d0;">' + currentHours
			+ '</span>'
		}

		if (currentSeconds >= 50) {
			currentSeconds = '<span style="color:#3b61d0;">' + currentSeconds
					+ '</span>'
		}

		clock.innerHTML = currentHours + ":" + currentMinute + ":"
				+ currentSeconds + " <span style='font-size:50px;'>" + amPm
				+ "</span>"; 
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

<div class="container-box">

	<div class="left-box">
		<div id="clock"></div>
		
		
<div class="sec7-text-box" id ="timer">
  <p class="font15 time-title"></p>
  <div class="time font40">
    <span class="hours"></span>
    <span class="col">:</span>
    <span class="minutes"></span>
    <span class="col">:</span>
    <span class="seconds"></span>
  </div>

</div>
		
		
		<div id="sumbit-box">
		
			<input type="hidden" value="${checkInt}" id="commuteCheck">
		
			<form action="commuteStartInsert.do" method="post">
				<input type="button" id="startButton" value="출근하기"  onclick="start_button();" class="select-box">
			</form>
			
			<form action="commuteEndUpdate.do" method="post"
				style="display: inline-block;">
				<input type="button" id="endButton"  value="퇴근하기"  onclick="end_button();" class="select-box">
			</form>
			
			
		</div>
	</div>
	
			<div class="table-box">
				<div class="table-location">
				<div id="test2">
				<h1 style="display: inline;">전체 리스트</h1>
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
						<c:forEach items="${list}" var="li">
							<tr>
								<td>${li.commute_id}</td>
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
<script type="text/javascript">
	$("#timer").hide();
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
			tr.append(
					$("<td/>").text(item.commute_id),
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
						alert("좋은 아침입니다");
						$("#startButton").hide();
						$("#endButton").hide();
						$("#clock").hide();
						$("#timer").show();
						
						setTimeout(function(){
							$("#endButton").show();
							$("#timer").hide();
							$("clock").show();
							
						}, 9000*60*60);
					}else{
						alert("이미 출근하셨습니다.");
						$("#endButton").hide();
						$("#startButton").hide();
						$("#clock").hide();
						$("#timer").show();
						
						setTimeout(function(){
							$("#endButton").show();
							$("#timer").hide();
							$("clock").show();
						}, 9000*60*60);
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
			  success: function(result){
				  if(result == 1){
					$("#ta").load(location.href+" #ta")
					$("#startButton").show();
					$("#endButton").hide();
					alert("오늘 하루도 수고하셨습니다.");
				  }
				  else{
						$("#startButton").hide();
						$("#endButton").hide();
						alert("퇴근체크 완료 되어있습니다")
				  }
				},
				error: function(){
					console.log("error")
				}
		});
		
	 }
	 
	 function remaindTime() {
		    var now = new Date();
		    var end = new Date(now.getFullYear(),now.getMonth(),now.getDate(),18,00,00);
		    var open = new Date(now.getFullYear(),now.getMonth(),now.getDate(),09,00,00);
		  
		    var nt = now.getTime();
		    var ot = open.getTime();
		    var et = end.getTime();
		  
		  
		    if(nt>et){
		    $("p.time-title").html("퇴근 시간");
		    $(".time").fadeOut();
		   }else {
		       $(".time").fadeIn();
		     $("p.time-title").html("퇴근까지 남은 시간");
		     sec =parseInt(et - nt) / 1000;
		     day  = parseInt(sec/60/60/24);
		     sec = (sec - (day * 60 * 60 * 24));
		     hour = parseInt(sec/60/60);
		     sec = (sec - (hour*60*60));
		     min = parseInt(sec/60);
		     sec = parseInt(sec-(min*60));
		     if(hour<10){hour="0"+hour;}
		     if(min<10){min="0"+min;}
		     if(sec<10){sec="0"+sec;}
		      $(".hours").html(hour);
		      $(".minutes").html(min);
		      $(".seconds").html(sec);
		   }
		 }
		 setInterval(remaindTime,1000);
	 
	 
</script>	
<script src="js/jquery.min.js"></script>
  <script src="js/popper.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/main.js"></script>
  


</body>
</html>