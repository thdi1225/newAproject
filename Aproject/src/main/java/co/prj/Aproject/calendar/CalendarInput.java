package co.prj.Aproject.calendar;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.prj.Aproject.comm.Command;

public class CalendarInput implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		CalenderService dao = new CalendarServiceImpl();
		CalendarVO vo = new CalendarVO();
		ObjectMapper mapper = new ObjectMapper();

		String calendar_title = request.getParameter("calendar_title");
		String calendar_subject = request.getParameter("calendar_subject");
		
		Date calendar_start_date = Date.valueOf(request.getParameter("calendar_start_date"));
		Date calendar_end_date = Date.valueOf(request.getParameter("calendar_end_date"));

		vo.setCalendar_title(calendar_title);
		vo.setCalendar_subject(calendar_subject);
		vo.setCalendar_start_date(calendar_start_date);
		vo.setCalendar_end_date(calendar_end_date);
		vo.setMember_num(Integer.parseInt(request.getParameter("member_num")));
		vo.setSection_id(Integer.parseInt(request.getParameter("section_id")));
		
		int n = dao.calendarInsert(vo);

		String jsonData = "";

		try {
			jsonData = mapper.writeValueAsString(vo);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		System.out.println("Input|||||||||||||||" + jsonData);

		if (n != 0) {
			request.setAttribute("message", "등록 완료");
		} else {
			request.setAttribute("message", "등록 실패");
		}

		// 저장하기

		/*
		 * try { vo.setCalendar_title(request.getParameter("calendar_title"));
		 * vo.setCalendar_subject(request.getParameter("calendar_subject"));
		 * vo.setCalendar_end_date(Date.valueOf(request.getParameter("calendar_end_date"
		 * ))); vo.setCalendar_start_date(Date.valueOf(request.getParameter(
		 * "calendar_start_date")));
		 * 
		 * System.out.println(request.getParameter("calendar_title"));
		 * System.out.println(request.getParameter("calendar_subject"));
		 * 
		 * } catch (Exception e) { e.printStackTrace(); }
		 * 
		 * int n = dao.calendarInsert(vo);
		 * 
		 * if (n != 0) { request.setAttribute("message", "등록 완료"); } else {
		 * request.setAttribute("message", "등록 실패"); }
		 */

		return "ajax:" + jsonData;
	}

}
