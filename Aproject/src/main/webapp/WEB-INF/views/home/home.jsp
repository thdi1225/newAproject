<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300&family=Nanum+Gothic&display=swap" rel="stylesheet">
  <script src="https://kit.fontawesome.com/1cb815469f.js" crossorigin="anonymous"></script>
  <script src="js/calendar/main.js"></script>
</head>
<body>
  <div id="main_container">
    <div id="box1">
      <div class="sub_tab">
        <span><i class="fa-solid fa-envelope"></i></span>
        <h1>메일함</h1>
        <p>회원님께 도착한 메일이 총 00개 입니다.</p>
      </div>
      <div class="sub_tab">
        <span><i class="fa-solid fa-table-list"></i></span>
        <h1>커뮤니티</h1>
        <p><a href="#">작성한 게시글 보러 가기</a></p>
      </div>
      <div class="sub_tab">
        <span><i class="fa-brands fa-flipboard"></i></span>
        <h1>출퇴근</h1>
        <p>출근 완료/출근하러 가기</p>
      </div>
    </div>
    <div id="box2">
      <div id='calendar'></div>
    </div>
    <div id="box3">
      <div class="h1_title"><p>Community</p></div>
      <div>
        <form>
          <table>
            
          </table>
        </form>
      </div>
    </div>
  </div>

  <script>

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
        initialView: 'listWeek',
        height: 300,
        header: {
      left: '',
      center: '',
      right: 'listWeek'
    },
        events: function(info, successCallback) {
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