<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>home</title>
<link href='css/home.css' rel='stylesheet' />
<link href='css/calendar/main.css' rel='stylesheet' />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300&family=Nanum+Gothic&display=swap"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/1cb815469f.js"
	crossorigin="anonymous"></script>
<script src="js/calendar/main.js"></script>
<script type="text/javascript">
  </script>

</head>
<body>
	<div id="main_container">
		<!-- 		mia -->
		<div id="box1">
			<div class="sub_tab">
				<span><i class="fa-solid fa-envelope"></i></span>
				<h1>메일함</h1>
				<c:choose>
					<c:when test="${empty memberVO.member_mail_email}">
						<p>메일 계정 로그인이 필요합니다.</p>
					</c:when>
					<c:otherwise>
						<p>회원님께 도착한 메일은 총 ${emailCnt}개 입니다.</p>
					</c:otherwise>
				</c:choose>
			</div>

			<div class="sub_tab">
				<span><i class="fa-solid fa-comments"></i></span>
				<h1>커뮤니티</h1>
				<p>
					<a href="boardList.do">작성한 게시글 보러 가기</a>
				</p>
			</div>

			<!-- yong -->
			<div class="sub_tab">
		        <span><i class="fa-solid fa-user-plus"></i></span>
		        
		        <h1>출퇴근</h1>
		 		<c:if test="${memberVO.member_auth == 0}">
		 			<a href="commuteEmpSelectList.do">출퇴근 확인</a>
		 		</c:if>
		 		<c:if test="${memberVO.member_auth == 1 }">
			        <c:if test="${cn == null}">
			        	<c:if test="${memberVO.member_auth == 1 }">
			        		<a href="commuteSelectList.do">출근하기</a>
			        	</c:if>
			        </c:if>
		        
		        
			        <c:if test="${cn == 1 && homeCk == 1}">
			       	 		<a href="commuteSelectList.do">퇴근하기</a>
			        </c:if>
			        
			        <c:if test="${cn == 2  && homeCk == 1 }">
			        	<p>퇴근을 완료하였습니다.</p>
			        </c:if>
		        </c:if>
	        
	        </div>
		</div>
		<div id="box2">
			<div id='calendar'></div>
		</div>
		<div id="box3">
			<div class="h1_title">
				<p>Community</p>
				<table class="table" id="ta">
					<tr>
						<th>글번호</th>
						<th>작성자</th>
						<th>제목</th>
						<th>작성일자</th>
						<th>조회수</th>
						<th>첨부파일</th>
					</tr>
					<c:forEach items="${boardList }" var="board">
						<tr onclick="boardDetail(${board.board_id })">
							<td align="center">${board.board_id }</td>
							<td align="center">${board.board_writer }</td>
							<td>${board.board_title }</td>
							<td align="center">${board.board_date }</td>
							<td align="center">${board.hit }</td>
							<td>${board.fileName }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div>
				<form>
					<table>

					</table>
				</form>
			</div>
		</div>
	</div>

	<script>
	    /* document.addEventListener('DOMContentLoaded', function() {
	      	var calendarEl = document.getElementById('calendar');
	      	var calendar = new FullCalendar.Calendar(calendarEl, {
		    initialView: 'listDay',
	        height: 300,
	        header: {
	      left: '',
	      center: '',
	      right: 'listDay'
	    },
	        events: 'https://fullcalendar.io/demo-events.json'
	      });
	      calendar.render();
	    });
	     */
	    document.addEventListener('DOMContentLoaded', function() {
			$.ajax({
				url: "calendarList.do",
	    		type: "get",
	    		dataType: "json",
	    		success: function(data) {
	    			fullCalendar(data);
				}
			});
		});
		
	    function fullCalendar(data) {
			var calendarEl = document.getElementById('calendar');
			var calendar = new FullCalendar.Calendar(calendarEl, {
				initialView: 'listDay',
				height: 300,
				header: {
					left: '',
					center: '',
					right: 'listDay'
				},
				events: function (info, successCallback) {
					for(var i = 0; i < data.length; i++) {
						data[i].section_id = data[i].section_id;
						data[i].calendar_id = data[i].calendar_id;
						data[i].title = data[i].calendar_title;
						data[i].start = data[i].calendar_start_date;
						data[i].end = data[i].calendar_end_date;	
					}	
			    	successCallback(data);
	  			} 
			});
		calendar.render();
		}
	</script>


</body>
</html>