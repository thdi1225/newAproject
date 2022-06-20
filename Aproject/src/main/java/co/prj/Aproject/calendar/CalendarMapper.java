package co.prj.Aproject.calendar;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface CalendarMapper {
	List<CalendarVO> calendarSelectList(); // 전체 조회
	CalendarVO calendarSelect(CalendarVO vo);
	// 부서별 select 
	List<CalendarVO> calendarSearchList(@Param("key") String key);
	int calendarInsert(CalendarVO vo); // 일정 추가
	int calendarUpdate(CalendarVO vo); // 일정 수정
	int calendarDelete(CalendarVO vo); // 삭제
}
