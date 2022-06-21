package co.prj.Aproject.calendar.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.prj.Aproject.calendar.service.CalenderService;
import co.prj.Aproject.calendar.serviceImpl.CalendarServiceImpl;
import co.prj.Aproject.calendar.vo.CalendarVO;
import co.prj.Aproject.comm.Command;

public class CalendarSelect implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		
		CalenderService dao = new CalendarServiceImpl();
		CalendarVO vo = new CalendarVO();
		ObjectMapper mapper = new ObjectMapper();

		vo.setCalendar_id(Integer.valueOf(request.getParameter("calendar_id")));
		vo = dao.calendarSelect(vo);
		request.setAttribute("calendar", vo);
		
		String jsonData = "";
		
		try {
			jsonData = mapper.writeValueAsString(vo);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		System.out.println("SELECT::::::::::" + jsonData);

		return "ajax:" + jsonData;
	}

}
