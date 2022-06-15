<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
 #clock{
 		 width:600px; height:250px;
 		  line-height:250px;
 		   color:#666;
 		   font-size:100px;
 		    text-align:center;"
 }
</style>
</head>
<script>
function printClock() {
    var clock = document.getElementById("clock");            // 출력할 장소 선택
    var currentDate = new Date();                                     // 현재시간
    var calendar = currentDate.getFullYear() + "-" + (currentDate.getMonth()+1) + "-" + currentDate.getDate() // 현재 날짜
    var amPm = 'AM'; // 초기값 AM
    var currentHours = addZeros(currentDate.getHours(),2);
    var currentMinute = addZeros(currentDate.getMinutes() ,2);
    var currentSeconds =  addZeros(currentDate.getSeconds(),2);
    
    if(currentHours >= 12){
        amPm = 'PM';
        currentHours = addZeros(currentHours - 12,2);
    }

    if(currentSeconds >= 50){
        currentSeconds = '<span style="color:#de1951;">'+currentSeconds+'</span>'
    }

    clock.innerHTML = currentHours+":"+currentMinute+":"+currentSeconds +" <span style='font-size:50px;'>"+ amPm+"</span>"; //날짜를 출력해 줌
    setTimeout("printClock()",1000);
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
	<div id="clock"></div>
	
	<form action="commuteStartInsert.do" method="post" style="display: inline-block;">
		<input type="submit"  value="출근하기">
	</form>
	<form action="commuteEndInsert.do" method="post" style="display: inline-block;">
		<input type="submit" value="퇴근하기">
	</form>



</body>
</html>