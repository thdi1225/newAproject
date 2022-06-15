<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="co.prj.Aproject.calendar.CalendarVO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<link href='css/calendar/main.css' rel='stylesheet' />
<link href='css/calendar/modal.css' rel='stylesheet' />
<script src='js/calendar/main.js'></script>
<style>
#calendar {
	max-width: 1100px;
	margin: 0 auto;
}
</style>
</head>
<body>
	<div id="calendar_input_modal" class="hidden">
		<div id="calendar_input_modal_body">
			<div>
				<h1>${message }</h1>
			</div>
			<h1>일정 등록</h1>
			<form id="frm" action="calendarInput.do" method="post"
				enctype="application/x-www-form-urlencoded">
				<div>
					<h6>title</h6>
					<input type="text" id="calendar_title" name="calendar_title"
						required="required">
				</div>
				<br />
				<div>
					<h6>subject</h6>
					<input type="text" id="calendar_subject" name="calendar_subject"
						required="required">
				</div>
				<br />
				<div>
					<h6>start-date</h6>
					<input type="date" id="calendar_start_date"
						name="calendar_start_date" required="required">
				</div>
				<br />
				<div>
					<h6>end-date</h6>
					<input type="date" id="calendar_end_date" name="calendar_end_date"
						required="required">
				</div>
				<br />
				<div>
					<input type="button" id="add" onclick="insert();" value="등록">
					<input type="reset" class="modal_close" value="취소">
				</div>
			</form>
		</div>
	</div>

	<%-- 	<table border="1" id="ta">
		<thead>
			<tr>
				<th width="150">1</th>
				<th width="250">2</th>
				<th width="150">3</th>
				<th width="100">4</th>
				<th width="200">5</th>
			</tr>
		</thead>
		<tbody id="tb">
			<c:forEach items="${list }" var="calendar">
				<tr>
					<td align="center">${calendar.calendar_id }</td>
					<td align="center">${calendar.calendar_title }</td>
					<td>${calendar.calendar_subject }</td>
					<td align="center">${calendar.calendar_start_date }</td>
					<td align="center">${calendar.calendar_end_date }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table> --%>


	<form id="frm">
		<select id="key" name="key">
			<option value="1">부서1</option>
			<option value="2">부서2</option>
			<option value="3">부서3</option>
			<option value="4">부서4</option>
		</select> <input type="button" onclick="search();" value="검색">
	</form>
	<div id='calendar'></div>
	<script>

 	function insert() {
  		$.ajax({
  			url: "calendarInput.do",
  			type: "post",
  			data: $('#frm').serialize(),
  			dataType: "json",
  			success: function(data) {
  				location.href="calendar.do";
  			}, 
  			error: function() {
  			}
  		});
  	} 


  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth'
      },
      initialDate: '2022-06-13',
      selectable: true,
      selectMirror: true,
      select: function(arg) { // 등록 이벤트
    	 const modal = document.getElementById("calendar_input_modal");
    	 const close = document.querySelector(".modal_close");
      		 modal.style.display = 'block';
      
      	close.addEventListener('click', function() {
      	 	modal.style.display = 'none';
      	 });
    
      },
      eventClick: function(event) {
		console.log("ㅇㄴㅇㅁㄻㅎㅇ");
      },
      dayMaxEvents: true, // allow "more" link when too many events
      events: [
			<%List<CalendarVO> list = (List<CalendarVO>) request.getAttribute("list");%>
			<%if (list != null) {%>
			<%for (CalendarVO vo : list) {%>
			{
				title: '<%=vo.getCalendar_title()%>',
				start: '<%=vo.getCalendar_start_date()%>',
				end: '<%=vo.getCalendar_end_date()%>'
			},
			<%}
}%>
      ]
    });

    calendar.render();
  });
  
</script>
</body>
</html>
