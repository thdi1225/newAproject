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
<link href='css/all.css' rel='stylesheet' />
<script src='js/calendar/main.js'></script>
<style>
#calendar {
	max-width: 1100px;
	margin: 0 auto;
	padding: 10px 30px 0 30px;
	margin-bottom: 20px;
	background: #fff;
}

.frm-div {
	background: #fff;
	max-width: 1100px;
	margin: auto;
	margin-top: 30px;
	flex-direction: row;
}

.frm-div form {
	display: flex;
	flex-direction: row;
	justify-content: flex-start;
	align-items: center;
	flex-wrap: wrap;
}

.select-box {
	margin-right: 10px;
	width: 93.56px;
}

.btn-dark {
	width: 63.16px;
}
</style>
</head>
<body>
	<div class="modal fade" id="calendar_insert_modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">일정 등록</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="frm" action="calendarInput.do" method="post"
						enctype="application/x-www-form-urlencoded">
						<input type="hidden" id="member_num" name="member_num"
							value="${memberVO.member_num}"> <input type="hidden"
							id="section_id" name="section_id" value="${memberVO.section_id}">
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
							<input type="date" id="calendar_end_date"
								name="calendar_end_date" required="required">
						</div>
						<br />
						<div class="modal-footer">
							<input type="button" id="add" class="btn-dark"
								onclick="calendarInsert();" value="등록"> <input
								type="button" class="btn-dark modal_close" value="취소">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="calendar_update_modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">일정 수정</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="frm" action="calendarUpdate.do" method="post"
						enctype="application/x-www-form-urlencoded">
						<input type="hidden" id="calendar_id" name="calendar_id">
						<input type="hidden" id="member_num2" name="member_num"
							value="${memberVO.member_num}"> <input type="hidden"
							id="section_id2" name="section_id" value="${memberVO.section_id}">
						<div>
							<h6>title</h6>
							<input type="text" id="calendar_title2" name="calendar_title"
								required="required">
						</div>
						<br />
						<div>
							<h6>subject</h6>
							<input type="text" id="calendar_subject2" name="calendar_subject"
								required="required">
						</div>
						<br />
						<div>
							<h6>start-date</h6>
							<input type="date" id="calendar_start_date2"
								name="calendar_start_date" required="required">
						</div>
						<br />
						<div>
							<h6>end-date</h6>
							<input type="date" id="calendar_end_date2"
								name="calendar_end_date" required="required">
						</div>
						<br />
						<div class="modal-footer">
							<input type="button" class="btn-dark" id="update"
								onclick="calendarUpdate();" value="수정"> <input
								type="reset" class="modal_close btn-dark"
								onclick="calendarDelete();" value="삭제">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%-- 	<table border="1" id="ta">
		<thead>
			<tr>
				<th width="150">0</th>
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
					<td align="center">${calendar.section_id }</td>
					<td align="center">${calendar.calendar_id }</td>
					<td align="center">${calendar.calendar_title }</td>
					<td>${calendar.calendar_subject }</td>
					<td align="center">${calendar.calendar_start_date }</td>
					<td align="center">${calendar.calendar_end_date }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
 --%>

<!-- 	<div class="frm-div"> -->
		<c:if test="${memberVO.member_auth == 0}">
			<form id="frm">
				<div class="form-group row">
					<label for="key" class="col-sm-1 col-form-label">부서</label>
					<select id="key" name="key" class="col-sm-5 form-control" style="margin-right: 10px;">
						<option value="0">전체</option>
						<c:forEach items="${sectionList}" var="list">
							<option value="${list.section_id}">${list.section_name}</option>
						</c:forEach>
					</select>
					<input type="button" id="search" class="btn-dark" onclick="calendarSearch()" value="검색">
				</div>
				<%-- <select class="select-box" id="key" name="key">
					<c:forEach items="${sectionList}" var="section">
						<option value="${section.section_id}">${section.section_name}</option>
					</c:forEach>
				</select>  --%>
			</form>
		</c:if>
		<c:if test="${memberVO.member_auth == 1}">
			<form id="frm">
				<input type="hidden" id="key" name="key"
					value="${memberVO.section_id}">
			</form>
			<input type="hidden" id="search" class="btn-dark"
				onclick="calendarSearch();" value="검색">
		</c:if>
<!-- 	</div> -->

	<div id='calendar'></div>

	<script>
	window.onload = function() {
	 	if(${memberVO.member_auth} == 1){
	 		document.getElementById('search').click();
	 	}
	}
 	
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

	function fullCalendar(data){
		var calendarEl = document.getElementById('calendar');

	    var calendar = new FullCalendar.Calendar(calendarEl, {
	      headerToolbar: {
	        left: 'prev,next today',
	        center: 'title',
	        right: 'dayGridMonth'
	      },
	      initialDate: '2022-06-15',
	      selectable: true,
	      selectMirror: true,
	      select: function(arg) { // 등록 이벤트
	      	$("#calendar_insert_modal").modal("show");
	      
	    	  var start = arg.startStr;
	    	  $("#calendar_start_date").val(start);
	    
	      },
	      eventClick: function(info) { // 수정 이벤트
	    	  console.log(info);
	    	  calendarSelect(info.event._def.extendedProps.calendar_id);
	    	  calendarUpdate(info.event._def.extendedProps.calendar_id);
	    	  calendarDelete(info.event._def.extendedProps.calendar_id);
	    	  
	    	  $("#calendar_update_modal").modal("show");
	      },
	      dateClick: function(info) {
	    	    info.dayEl.style.backgroundColor = '#DAEAF1'; // 클릭 시 배경색 바꾸는 속성
	    	},
	      dayMaxEvents: true, // allow "more" link when too many events
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
	
 	function calendarInsert(startDate) {
  		$.ajax({
  			url: "calendarInput.do",
  			type: "post",
  			data: $('#frm').serialize(),
  			dataType: "json",
  			success: function(data) {
  				swal({
					title: "일정이 등록되었습니다.",
					icon: "success"
				}).then((willDelete) => {
					location.href="calendar.do";
				})
  			}, 
  			error: function() {
  			}
  		});
  	} 
 	
 	function calendarUpdate() {
  		$.ajax({
  			url: "calendarUpdate.do",
  			type: "post",
  			dataType: "json",
  			data: {
  				"member_num": $("#member_num2").val(),
  				"section_id": $("#section_id2").val(),
  				"calendar_id": $("#calendar_id").val(),
  				"calendar_title": $("#calendar_title2").val(),
  				"calendar_subject": $("#calendar_subject2").val(),
   				"calendar_start_date": $("#calendar_start_date2").val(),
  				"calendar_end_date": $("#calendar_end_date2").val()
  			},
  			success: function(result) {
  				swal({
					title: "일정이 수정되었습니다.",
					icon: "success"
				}).then((willDelete) => {
  					location.href="calendar.do";
				})
  				
  			}, 
  			error: function() {
  			}
  		});
  	} 
 	
 	function calendarSelect(calendar_id) {
 		$.ajax({
 			url: "calendarSelect.do",
 			type: "post",
 			data: {
 				"calendar_id" : calendar_id
 			},
 			dataType: "json",
 			success: function(result) {
 				
 				$("#calendar_id").val(result.calendar_id);
 				$("#calendar_title2").val(result.calendar_title);
 				$("#calendar_subject2").val(result.calendar_subject);
 				$("#calendar_start_date2").val(result.calendar_start_date);
 				$("#calendar_end_date2").val(result.calendar_end_date);
 			}
 		});
 	}
 	
 	function calendarDelete(calendar_id) {
 		$.ajax({
 			url: "calendarDelete.do",
 			type: "get",
 			data: {
 				"calendar_id": $("#calendar_id").val()
 			},
 			dataType: "json",
 			success: function(result) {
 				swal({
					title: "일정이 삭제되었습니다.",
					icon: "success"
				}).then((willDelete) => {
					location.href="calendar.do";
				})
 				
 			}
 		});
 	}
 	
 	function calendarSearch() {
 		$.ajax({
 			url: "calendarSearch.do",
 			type: "post",
 			data: {
 				"key": $("#key").val()
 				},
 			dataType: "json",
 			success: function(data) {
 				let key_id = $("#key").val();
 				fullCalendar(data);
 			}
 		});
 	}
 	
/*  	function htmlConvert(data) {
 		$("tbody").remove();
 		let tb = $("<tbody />");
 		$.each(data, function(index, item) {
 			let tr = $("<tr />").append(
 				$("<td align = 'center' />").text(item.section_id),
 				$("<td align = 'center' />").text(item.calendar_id),
 				$("<td align = 'center' />").text(item.calendar_title),
 				$("<td align = 'center' />").text(item.calendar_subject),
 				$("<td align = 'center' />").text(item.calendar_start_date),
 				$("<td align = 'center' />").text(item.calendar_end_date)
 			);
 			tb.append(tr);
 		});
 		$("#ta").append(tb);
 	} */
 	
  
</script>
</body>
</html>
