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



</head>

<body>


<div class="container-box">

<div style="width: 100%; height: 50px">
<h2 style="font-size: 2rem; font-weight: 400; float: left; display: inline; line-height: 50px">출퇴근 관리</h2>
<p style="float: right; display: inline; margin-top: 0px;font-size: 12px">출퇴근 > 사원 전체 출퇴근 관리</p>
</div>
<hr>

		
	

		<div class="bottom-box">
		
		<div class= "emp-list-btn-box">
			<button class="list-btn" onclick="test1();">month-list</button>
			<button class=list-btn onclick="test2();">all-list</button>
		</div>
				<div class="commute-list-location">
				<div id="test2" class="commutelist-box">
				<h1 style="display: inline;  font-family: 'Roboto', sans-serif;">출퇴근 전체 리스트</h1>
				</div>
				<div id="test" style="width: 600px;">
				 <button type="button" onclick="lastMonth();" class="table-btn" >지난 달</button>
			  	<h1 style="display: inline;"><strong><span id="number" style=" font-family: 'Roboto', sans-serif;"></span></strong></h1><h1 style="display: inline;  font-family: 'Roboto', sans-serif;">월</h1>
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
								<th>회원 번호</th>
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
</html>