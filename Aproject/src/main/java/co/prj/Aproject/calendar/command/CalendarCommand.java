package co.prj.Aproject.calendar.command;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.calendar.CalendarServiceImpl;
import co.prj.Aproject.calendar.CalendarVO;
import co.prj.Aproject.calendar.CalenderService;
import co.prj.Aproject.comm.Command;
import co.prj.Aproject.section.service.SectionService;
import co.prj.Aproject.section.serviceImpl.SectionServiceImpl;

public class CalendarCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		CalenderService dao = new CalendarServiceImpl();

		List<CalendarVO> list = new ArrayList<CalendarVO>();
		// 목록 불러오기
		list = dao.calendarSelectList();
		SectionService sectionService = new SectionServiceImpl();
		
		request.setAttribute("sectionList", sectionService.sectionSelectList(null));
		request.setAttribute("list", list);
		return "calendar/calendar";
	}

}
