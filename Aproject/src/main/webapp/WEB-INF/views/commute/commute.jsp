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
	<link rel="stylesheet" href="css/commute.css">
<title>Insert title here</title>
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

	<div class="top-box">
		<div id="clock"></div>
		<div class= "list-btn-box">
			<button class="list-btn" onclick="test1();">month-list</button>
			<button class=list-btn onclick="test2();">all-list</button>
		</div>
		
		<div id="sumbit-box">
		
			<input type="hidden" value="${checkInt}" id="commuteCheck">
			<input type= "hidden" value="${timeCheck}"  id ="timeCheck">

			<c:if test="${v != 1 }">
			<form action="commuteStartInsert.do" method="post">
				<input type="button" id="startButton" value="출근하기"  onclick="start_button();" class="commutebutton">
			</form>
			</c:if>
			
			<c:if test="${v == 1}">
			<form action="commuteEndUpdate.do" method="post"
				style="display: inline-block;">
				<input type="button" id="endButton"  value="퇴근하기"  onclick="end_button();" class="commutebutton">
			</form>
			</c:if>
			
			
		</div>
	</div>
	
			<div class="bottom-box">
				<div class="commute-list-location">
				<div id="test2" class="commutelist-box">
				<h1 style="display: inline;">출퇴근 전체 리스트</h1>
				</div>
				<div id="test" style="width: 600px;">
				 <button type="button" onclick="lastMonth();" class="table-btn" >지난 달</button>
			  	<h1 style="display: inline;"><strong><span id="number" ></span></strong></h1><h1 style="display: inline;">월</h1>
				<button type="button" onclick="nextMonth();"class="table-btn">다음 달</button>
				</div>
				</div>			
				
				<div id="test3">
				<table class="tables" id="ta" style="top: 80px;">
						<thead>
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
	$("#test").hide();
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
						$("#sumbit-box").load(location.href+" #sumbit-box")
						alert("좋은 아침입니다");
						
					}else{
						alert("이미 출근하셨습니다.");
					}
				},
				error: function(){
					console.log("error")
				}
		  });
	 }
		 
	 
	 
	 function end_button(){
		 let chk	= document.getElementById("timeCheck").value
		 $.ajax({
			  url:"commuteEndUpdate.do",
			  success: function(chk){
				  if(chk == 1){
					$("#ta").load(location.href+" #ta")
					$("#sumbit-box").load(location.href+" #sumbit-box")
					alert("오늘 하루도 수고하셨습니다.");
					
				  }
				  else if(chk == 0){
						alert("이미 퇴근체크 완료 되어있습니다")
				  }
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