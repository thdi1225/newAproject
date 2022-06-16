package co.prj.Aproject.calendar;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.prj.Aproject.comm.Command;

public class CalendarSearch implements Command {
	
	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		CalenderService dao = new CalendarServiceImpl();
		List<CalendarVO> list = new ArrayList<CalendarVO>();
		ObjectMapper mapper = new ObjectMapper();
		
		String key = request.getParameter("key");
		list = dao.calendarSearchList(key);
		String jsonData = "";
		
		try {
			jsonData = mapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		System.out.println(jsonData);
		return "ajax:" + jsonData;
	}

}
