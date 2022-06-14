package co.prj.Aproject.calendar;

import java.util.List;

public interface CalenderService {
	List<CalendarVO> calendarSelectList(); // 전체 조회
	// 부서별 select 
	List<CalendarVO> calendarSearchList(String key, String val);
	int calendarInsert(CalendarVO vo); // 일정 추가
	int calendarUpdate(CalendarVO vo); // 일정 수정
	int calendarDelete(CalendarVO vo); // 삭제
}
