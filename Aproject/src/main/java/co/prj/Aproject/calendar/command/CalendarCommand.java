package co.prj.Aproject.calendar.command;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.calendar.CalendarServiceImpl;
import co.prj.Aproject.calendar.CalendarVO;
import co.prj.Aproject.calendar.CalenderService;
import co.prj.Aproject.comm.Command;

public class CalendarCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		CalenderService dao = new CalendarServiceImpl();
		CalendarVO vo = new CalendarVO();
		List<CalendarVO> list = new ArrayList<CalendarVO>();

		// 목록 불러오기

		list = dao.calendarSelectList();
		request.setAttribute("list", list);

		return "calendar/calendar";
	}

}
