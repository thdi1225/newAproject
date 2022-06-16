package co.prj.Aproject.web;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.calendar.CalendarDelete;
import co.prj.Aproject.calendar.CalendarInput;
import co.prj.Aproject.calendar.CalendarList;
import co.prj.Aproject.calendar.CalendarSearch;
import co.prj.Aproject.calendar.CalendarSelect;
import co.prj.Aproject.calendar.CalendarUpdate;
import co.prj.Aproject.calendar.command.CalendarCommand;
import co.prj.Aproject.comm.Command;
import co.prj.Aproject.home.command.HomeCommand;
import co.prj.Aproject.member.command.LoginCommand;

@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HashMap<String, Command> map = new HashMap<String, Command>();

	public FrontController() {
		super();
	}

	public void init(ServletConfig config) throws ServletException {
		map.put("/login.do", new LoginCommand());
		map.put("/calendar.do", new CalendarCommand());
		map.put("/calendarList.do", new CalendarList());
		map.put("/calendarInput.do", new CalendarInput());
		map.put("/calendarUpdate.do", new CalendarUpdate());
		map.put("/calendarDelete.do", new CalendarDelete());
		map.put("/calendarSelect.do", new CalendarSelect());
		map.put("/calendarSearch.do", new CalendarSearch());
		map.put("/home.do", new HomeCommand());
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String page = uri.substring(contextPath.length());

		Command command = map.get(page);
		String viewPage = command.exec(request, response);
		
		if (!viewPage.endsWith(".do") && !viewPage.equals(null)) {
			if(viewPage.equals("login")) {
				viewPage =  "/WEB-INF"+"/views/"+viewPage + ".jsp";
			} else if(viewPage.startsWith("ajax:")) {
				response.setContentType("text/html; charset=UTF-8");
				viewPage = viewPage.substring(5);
				response.getWriter().append(viewPage);
				return;
			} else {
				viewPage = viewPage + ".tiles";
			}
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}

}
