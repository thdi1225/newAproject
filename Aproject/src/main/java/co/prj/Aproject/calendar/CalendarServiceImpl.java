package co.prj.Aproject.calendar;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import co.prj.Aproject.comm.DataSource;

public class CalendarServiceImpl implements CalenderService {
	private SqlSession sqlSession = DataSource.getInstance().openSession(true);
	private CalendarMapper map = sqlSession.getMapper(CalendarMapper.class);

	@Override
	public List<CalendarVO> calendarSelectList() {
		return map.calendarSelectList();
	}

	@Override
	public List<CalendarVO> calendarSearchList(String key) {
		return map.calendarSearchList(key);
	}

	@Override
	public int calendarInsert(CalendarVO vo) {
		return map.calendarInsert(vo);
	}

	@Override
	public int calendarUpdate(CalendarVO vo) {
		return map.calendarUpdate(vo);
	}

	@Override
	public int calendarDelete(CalendarVO vo) {
		return map.calendarDelete(vo);
	}

	@Override
	public CalendarVO calendarSelect(CalendarVO vo) {
		return map.calendarSelect(vo);
	}

}
