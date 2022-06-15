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
	public List<CalendarVO> calendarSearchList(String key, String val) {
		// TODO Auto-generated method stub
		return map.calendarSearchList(key, val);
	}

	@Override
	public int calendarInsert(CalendarVO vo) {
		// TODO Auto-generated method stub
		System.out.println("ㅎㅇㅎㅇ555");
		return map.calendarInsert(vo);
	}

	@Override
	public int calendarUpdate(CalendarVO vo) {
		// TODO Auto-generated method stub
		return map.calendarUpdate(vo);
	}

	@Override
	public int calendarDelete(CalendarVO vo) {
		// TODO Auto-generated method stub
		return map.calendarDelete(vo);
	}

}
