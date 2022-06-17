<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href='css/calendar/main.css' rel='stylesheet' />
<link href='css/calendar/modal.css' rel='stylesheet' />
<script src='js/calendar/main.js'></script>
<style>
/* .fc-toolbar-chunk{
	display: flex;
}

.fc-next-button, .fc-prev-button{
	background: white!important;
	color: black!important;
	border-color: white!important; 
}
.fc-toolbar-title{
	align-self: center;
}
.fc-placeButton-button{
	color: #fff!important;
    background-color: #1E202D!important;
    border-color: #1E202D!important;
}
.fc-templateButton-button{
	margin-left: 0.2em!important;
	color: #fff!important;
    background-color: #1E202D!important;
    border-color: #1E202D!important;
} */
</style>

</head>
<body>
<!-- Main content -->
<section class="container">
	<div id="app">
		<div id='calendar'></div>
	</div>
	
	<!-- 등록 -->
	<div class="modal fade" id="calendarInsertModal" tabindex="-1" role="dialog" aria-labelledby="imageModalModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="imageModalLabel">일정 등록</h4>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
						<div class="col-md-12">
							<label class="text-lb">일정 제목<i class="xi-check-min ml-1 input-need"></i></label>
							<div>
								<input class="form-control" type="text" id="calendar_title" name="calendar_title" maxlength="50">
								<small>
								<div id="text-info">
									최대 30자 이내 (특수문자 제외)
								</div>
							</small>	
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label class="text-lb">일정 날짜<i class="xi-check-min ml-1 mr-1 input-need"></i></label>
								<div class="input-group">
									<input type="date" class="form-control"value="" id="calendar_start_day" name="calendar_start_day">
									<span class="input-group-addon"> ~ </span>
									<input type="date" class="form-control"value="" id="calendar_end_day" name="calendar_end_day">
								</div>
							</div>
						</div>	
						<div class="col-md-12">
						<div class="form-group">
							<label class="text-lb">일정 시간<i class="xi-check-min ml-1 mr-1 input-need"></i></label>
							<div class="input-group">
								<input type = "time" class="form-control" id="calendar_start_time" name="calendar_start_time" max="HH" min="mm" value="09:00">
								<span class="input-group-addon"> ~ </span>
								<input type = "time" class="form-control" id="calendar_end_time" name="calendar_end_time" max="HH" min="mm" value="10:00">
							</div>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label class="text-lb">일정 내용 입력<i class="xi-check-min ml-1 input-need"></i></label>
								<textarea class="form-control" placeholder="일정 내용 입력" id="calendarContent" name="calendarContent" rows="5" required></textarea>
							</div>
						</div>
					</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onclick="insertFormCheck()"><i class="xi-check mr-1"></i>등록</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal"><i class="xi-close mr-1"></i>취소</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 수정 -->
	<div class="modal fade" id="calendarUpdateModal" tabindex="-1" role="dialog" aria-labelledby="imageModalModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="imageModalLabel">일정 수정</h4>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<input type = "hidden" name = "calendarNumber" id="calendarNumber">
						<div class="col-md-12 mb-2">
                 			<label class="text-lb">일정 분류<i class="xi-check-min ml-1 mr-1 input-need"></i></label>
                 			<br>
							<small>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" id="calendarType4" name="calendarTypeUpdate" value = "일반">
									<label class="form-check-label" for="calendarType4" style="color:#f7507b">일반</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" id="calendarType5" name="calendarTypeUpdate" value = "회의">
									<label class="form-check-label" for="calendarType5" style="color:#18aae2">회의</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" id="calendarType6" name="calendarTypeUpdate" value = "행사">
									<label class="form-check-label" for="calendarType6" style="color:#caca53">행사</label>
								</div>
							</small>
						</div>
						<div class="col-md-12">
							<label class="text-lb">일정 제목<i class="xi-check-min ml-1 input-need"></i></label>
							<div>
								<input class="form-control" type="text" id="calendarTitleUpdate" name="calendarTitle">	
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label class="text-lb">일정 날짜<i class="xi-check-min ml-1 mr-1 input-need"></i></label>
								<div class="input-group">
									<input type="date" class="form-control"value="" id="calendarStartDayUpdate" name="calendarStartDay">
									<span class="input-group-addon"> ~ </span>
									<input type="date" class="form-control"value="" id="calendarEndDayUpdate" name="calendarEndDay">
								</div>
							</div>
						</div>	
						<div class="col-md-12">
						<div class="form-group">
							<label class="text-lb">일정 시간<i class="xi-check-min ml-1 mr-1 input-need"></i></label>
								<div class="input-group">
									<input type = "time" class="form-control" id="calendarStartTimeUpdate" name="calendarStartTime" max="HH" min="mm">
									<span class="input-group-addon"> ~ </span>
									<input type = "time" class="form-control" id="calendarEndTimeUpdate" name="calendarStartTime" max="HH" min="mm">
								</div>
						</div>
						<div class="form-group">
							<label class="text-lb">일정 내용 입력<i class="xi-check-min ml-1 input-need"></i></label>
							<textarea class="form-control" placeholder="일정 내용 입력" id="calendarContentUpdate" name="calendarContent" rows="5" required></textarea>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onclick="updateFormCheck()"><i class="xi-pen mr-1"></i>수정</button>
					<button type="button" class="btn btn-danger" onclick="calendarDelete()"><i class="xi-trash mr-1"></i>삭제</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal"><i class="xi-close mr-1"></i>취소</button>
				</div>
			</div>
		</div>
	</div>
</section>
<script>
$(document).ready(function(){
	calendarRender();	
})

	function calendarRender(){
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {
			headerToolbar: {
				left: 'today',
				center: 'prev title next',
				right: 'dayGridMonth,dayGridWeek',
			},
			selectable:true,
			select: function(info) {
				var date = new Date(info.endStr);
				
				$("#calendarStartDay").val(info.startStr);
				
				var string = formatDate(date);
				if(string.split('-')[2] == '00'){
					var yy = string.substr(0, 4);
					var mm = string.substr(5, 7);
					
					var intMM = parseInt(mm, 10);
					
					var nd = new Date(2021, intMM-1, 0);
					
					var getFullYear = (nd.getFullYear());
					var getMonth = (nd.getMonth()+1);
					var getDate = (nd.getDate());
					
					if(getMonth < 10){
						var formatEnd = nd.getFullYear() + '-0' + (nd.getMonth()+1) + '-' + nd.getDate()	
					}
					if(getDate < 10){
						var formatEnd = nd.getFullYear() + '-' + (nd.getMonth()+1) + '-0' + nd.getDate()	
					}

					$('#calendarEndDay').val(formatEnd);
				}else{
					$('#calendarEndDay').val(formatDate(date));	
				}
				
				$("#calendarInsertModal").modal("show");
		    },
	         eventDidMount:function(info){
	             info.el.title=info.event.title;
	             $('[data-toggle="tooltip"]').tooltip(info.el.title);
	        },
			displayEventTime: false,
			locale: 'ko',
//	 		editable: true,
			fixedWeekCount:false,
	        eventDisplay: 'block',
			// allow "more" link when too many events
			dayMaxEvents: true, 
	    	//캘린더 이벤트 클릭시 들어가는 function
			eventClick: function(info) {
				var id = info.event.id;
				var title = info.event._def.extendedProps.titleOrg;
				var startDay = info.event._def.extendedProps.startDay;
				var endDay = info.event._def.extendedProps.endDay;
				var startTime = info.event._def.extendedProps.calendarStartTime;
				var endTime = info.event._def.extendedProps.calendarEndTime;
				var content = info.event._def.extendedProps.content;
				var color = info.event.borderColor;
				
				$("#calendarNumber").val(id);
				var colorArray = $("input[name=calendarTypeUpdate]");
				

				if(color == '#f7507b'){
					$(colorArray[0]).prop('checked', true);						
				}else if(color == '#18aae2'){
					$(colorArray[1]).prop('checked', true);						
				}else if(color == '#caca53'){
					$(colorArray[2]).prop('checked', true);						
				}

				$("#calendarTitleUpdate").val(title);
				$("#calendarStartDayUpdate").val(startDay);
				$("#calendarEndDayUpdate").val(endDay);
				$("#calendarStartTimeUpdate").val(startTime).prop("selected", true);
				$("#calendarEndTimeUpdate").val(endTime).prop("selected", true);
				$("#calendarContentUpdate").val(content);
				$("#calendarUpdateModal").modal("show");
			},
			events: function(info, successCallback, failureCallback) {
				$.ajax({
					url : '/calendarboard/calendarList',
					type : 'get',
					dataType : 'json',
					success:function(data){
						for(var i = 0; i<data.length;i++){
							if(data[i].color == '일반'){
								data[i].color = '#f7507b';
							}else if(data[i].color == '회의'){
								data[i].color = '#18aae2';
							}else{
								data[i].color = '#caca53';
							}
							data[i].titleOrg = data[i].title;
							data[i].title = data[i].calendarStartTime + '~' + data[i].calendarEndTime + ' ' + data[i].title;
							data[i].startDay = data[i].start;
							data[i].start = data[i].start + " " + data[i].calendarStartTime;
							data[i].endDay = data[i].end;
							data[i].end = data[i].end + " " + data[i].calendarEndTime;
						}
						
						successCallback(data);
					},
					error:function(xhr, error, status){
						console.log(xhr+ error+ status)
						toastr.options = { "positionClass": "toast-top-center" }
						toastr["error"]("에러가 발생하였습니다.");
					}
				});
			},
			
		});
		calendar.render();
	}
	
$('.modal').on('hidden.bs.modal', function (e) {
	$('input[name="calendarType"]')[0].checked = true;
	$("#calendarTitle").val("")
	$("#calendarContent").val("")
	$("#calendarStartTime").val("09:00");
	$("#calendarEndTime").val("10:00");
});

function insert(){
	$.ajax({
		url : "/calendarboard/insert",
		type : 'post',
		data : {
			calendarType : $('input[name="calendarType"]:checked').val(),
			calendarTitle : $("#calendarTitle").val(),
			calendarStartDay : $("#calendarStartDay").val(),
			calendarEndDay : $("#calendarEndDay").val(),
			calendarStartTime : $("#calendarStartTime").val(),
			calendarEndTime : $("#calendarEndTime").val(),
			calendarContent : $("#calendarContent").val()
		},
		success:function(){
			toastr.options = { "positionClass": "toast-top-center" }
			toastr["success"]("등록 되었습니다.");
			calendarRender();
			$("#calendarInsertModal").modal("hide");
		},
		error:function(error){
			toastr.options = { "positionClass": "toast-top-center" }
			toastr["error"]("에러가 발생하였습니다.");
		}
		
	})
}

function update(){
	var color = $('input[name="calendarTypeUpdate"]:checked').val()
	$.ajax({
		url : "/calendarboard/update",
		type : 'post',
		data : {
			calendarNumber : $('#calendarNumber').val(),
			calendarType : color,
			calendarTitle : $("#calendarTitleUpdate").val(),
			calendarStartDay : $("#calendarStartDayUpdate").val(),
			calendarEndDay : $("#calendarEndDayUpdate").val(),
			calendarStartTime : $("#calendarStartTimeUpdate").val(),
			calendarEndTime : $("#calendarEndTimeUpdate").val(),
			calendarContent : $("#calendarContentUpdate").val()
		},
		success:function(){
			toastr.options = { "positionClass": "toast-top-center" }
			toastr["success"]("수정 되었습니다.");
			calendarRender();
			$("#calendarUpdateModal").modal("hide");
		},
		error:function(error){
			toastr.options = { "positionClass": "toast-top-center" }
			toastr["error"]("에러가 발생하였습니다.");
		}
		
	})
}

function calendarDelete(){
	if(confirm('삭제하시겠습니까?')){
		$.ajax({
			url : "/calendarboard/delete",
			type : "post",
			data : {
				calendarNumber : $("#calendarNumber").val()
			},
			success:function(){
				toastr.options = { "positionClass": "toast-top-center" }
				toastr["success"]("삭제 되었습니다.");
				calendarRender();
				$("#calendarUpdateModal").modal("hide");
			},
			error:function(xhr, error, status){
				toastr.options = { "positionClass": "toast-top-center" }
				toastr["error"]("에러가 발생하였습니다.");
			}
		});
	}
}

function formatDate(date){
	var year = date.getFullYear();
	var month = date.getMonth()+1;
	var day = date.getDate()-1;
		
	if(month < 10){
		month = '0'+month;
	}
	if(day < 10) {
		day = '0'+day;
	}

	return year + '-' + month + '-' + day;
}

function insertFormCheck(){
	if(confirm('등록하시겠습니까?')){
		$.ajax({
			url : "/calendarboard/formatCheck",
			type : 'get',
			data : {
				calendarStartDay : $("#calendarStartDay").val(),
				calendarEndDay : $("#calendarEndDay").val(),
				calendarStartTime : $("#calendarStartTime").val(),
				calendarEndTime : $("#calendarEndTime").val()
			},
			success:function(date){
				if(date == 'success'){
					if($("#calendarTitle").val()==null || $("#calendarTitle").val()==""){
						toastr.options = { "positionClass": "toast-top-center" }
						toastr["warning"]("일정 제목을 입력하세요.");
					}else if($("#calendarStartDay").val()==null || $("#calendarStartDay").val()==""){
						toastr.options = { "positionClass": "toast-top-center" }
						toastr["warning"]("시작 날짜을 입력하세요.");
					}else if($("#calendarEndDay").val()==null || $("#calendarEndDay").val()==""){
						toastr.options = { "positionClass": "toast-top-center" }
						toastr["warning"]("종료 날짜을 입력하세요.");
					}else if($("#calendarContent").val()==null || $("#calendarContent").val()==""){
						toastr.options = { "positionClass": "toast-top-center" }
						toastr["warning"]("일정 내용을 입력하세요.");
					}else{
						insert();	
					}
				}else if(date == 'fail'){
					toastr.options = { "positionClass": "toast-top-center" }
					toastr["error"]("시작 시간이 종료 시간보다 같거나 빠를 수 없습니다.");
				}else if(date == 'dayFail'){
					toastr.options = { "positionClass": "toast-top-center" }
					toastr["error"]("시작 날짜가 종료 날짜보다 같거나 빠를 수 없습니다.");
				}else{
					if($("#calendarStartTime").val()==null || $("#calendarStartTime").val()==""){
						toastr.options = { "positionClass": "toast-top-center" }
						toastr["warning"]("시작 시간을 입력하세요.");
					}else if($("#calendarEndTime").val()==null || $("#calendarEndTime").val()==""){
						toastr.options = { "positionClass": "toast-top-center" }
						toastr["warning"]("종료 시간을 입력하세요.");
					}
				}
			},
			error:function(xhr, error, status){
				toastr.options = { "positionClass": "toast-top-center" }
				toastr["error"]("에러가 발생하였습니다.");
			}
		})
	}
}

function updateFormCheck(){
	if(confirm('수정하시겠습니까?')){
		$.ajax({
			url : "/calendarboard/formatCheck",
			type : 'get',
			data : {
				calendarStartDay : $("#calendarStartDayUpdate").val(),
				calendarEndDay : $("#calendarEndDayUpdate").val(),
				calendarStartTime : $("#calendarStartTimeUpdate").val(),
				calendarEndTime : $("#calendarEndTimeUpdate").val()
			},
			success:function(date){
				if(date == 'success'){
					if($("#calendarTitleUpdate").val()==null || $("#calendarTitleUpdate").val()==""){
						toastr.options = { "positionClass": "toast-top-center" }
						toastr["warning"]("일정 제목을 입력하세요.");
					}else if($("#calendarStartDayUpdate").val()==null || $("#calendarStartDayUpdate").val()==""){
						toastr.options = { "positionClass": "toast-top-center" }
						toastr["warning"]("시작 날짜을 입력하세요.");
					}else if($("#calendarEndDayUpdate").val()==null || $("#calendarEndDayUpdate").val()==""){
						toastr.options = { "positionClass": "toast-top-center" }
						toastr["warning"]("종료 날짜을 입력하세요.");
					}else if($("#calendarContentUpdate").val()==null || $("#calendarContentUpdate").val()==""){
						toastr.options = { "positionClass": "toast-top-center" }
						toastr["warning"]("일정 내용을 입력하세요.");
					}else{
						update();	
					}
				}else if(date == 'fail'){
					toastr.options = { "positionClass": "toast-top-center" }
					toastr["error"]("시작 시간이 종료 시간보다 같거나 빠를 수 없습니다.");
				}else if(date == 'dayFail'){
					toastr.options = { "positionClass": "toast-top-center" }
					toastr["error"]("시작 날짜가 종료 날짜보다 같거나 빠를 수 없습니다.");
				}else{
					if($("#calendarStartTimeUpdate").val()==null || $("#calendarStartTimeUpdate").val()==""){
						toastr.options = { "positionClass": "toast-top-center" }
						toastr["warning"]("시작 시간을 입력하세요.");
					}else if($("#calendarEndTimeUpdate").val()==null || $("#calendarEndTimeUpdate").val()==""){
						toastr.options = { "positionClass": "toast-top-center" }
						toastr["warning"]("종료 시간을 입력하세요.");
					}
				}
			},
			error:function(xhr, error, status){
				toastr.options = { "positionClass": "toast-top-center" }
				toastr["error"]("에러가 발생하였습니다.");
			}
		})
	}
}

$("#calendarStartTime").change(function() {
	timeChange();
});

$("#calendarStartDay").change(function() {
	timeChange();
});

function timeChange(){
	$.ajax({
		url:"/calendarboard/calendarChangeTime",
		data:{
			calendarEndDay : $("#calendarEndDay").val(),
			calendarStartTime : $("#calendarStartTime").val(),
			calendarEndTime : $("#calendarEndTime").val()
		},success:function(data){
			$("#calendarEndTime").val(data);
			var startHH = $("#calendarStartTime").val();
			var starthh = startHH.substr(0, 2);

			if(starthh == '23'){
				var date = new Date($("#calendarStartDay").val());
				var day = date.getDate();
				date.setDate(date.getDate()+2);
				$('#calendarEndDay').val(formatDate(date));
				
			}
		},error:function(){
			
		}
	})
}

</script>
</body>
</html>