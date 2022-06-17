package co.prj.Aproject.calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.prj.Aproject.comm.Command;

public class CalendarDelete implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		CalenderService dao = new CalendarServiceImpl();
		CalendarVO vo = new CalendarVO();
		ObjectMapper mapper = new ObjectMapper();
		
		vo.setCalendar_id(Integer.valueOf(request.getParameter("calendar_id")));
		
		int n = dao.calendarDelete(vo);
		
		String jsonData = "";
		
		try {
			jsonData = mapper.writeValueAsString(vo);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		System.out.println("Delete!!!!!!!!!!!!" + jsonData);
		
		if (n != 0) {
			request.setAttribute("message", "삭제 완료");
		} else {
			request.setAttribute("message", "삭제 실패");
		}

		return "ajax:" + jsonData;
		
	}

}
