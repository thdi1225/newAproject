package co.prj.Aproject.calendar;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.prj.Aproject.comm.Command;

public class CalendarList implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		CalenderService dao = new CalendarServiceImpl();
		CalendarVO vo = new CalendarVO();
		List<CalendarVO> list = new ArrayList<CalendarVO>();
		ObjectMapper mapper = new ObjectMapper();

		// 목록 불러오기

		list = dao.calendarSelectList();
		request.setAttribute("list", list);
		
		String jsonData = "";
		
		try {
			jsonData = mapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		System.out.println("commend!!!!!!!!!!!" + jsonData);

		return "ajax:" + jsonData;
	}

}
