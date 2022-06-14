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

import co.prj.Aproject.calendar.CalendarInput;
import co.prj.Aproject.calendar.command.CalendarCommand;
import co.prj.Aproject.board.command.AjaxSearchList;
import co.prj.Aproject.board.command.BoardInput;
import co.prj.Aproject.board.command.BoardInputForm;
import co.prj.Aproject.board.command.BoardList;
import co.prj.Aproject.comm.Command;
import co.prj.Aproject.email.command.EmailRecieveCommand;
import co.prj.Aproject.email.command.EmailSendCommand;
import co.prj.Aproject.email.command.EmailServiceCommand;
import co.prj.Aproject.home.command.HomeCommand;
import co.prj.Aproject.member.command.LoginCommand;
import co.prj.Aproject.member.command.LoginCommandForm;
import co.prj.Aproject.member.command.MemberAdminInputForm;
import co.prj.Aproject.member.command.MemberDelete;
import co.prj.Aproject.member.command.MemberInsertCommand;
import co.prj.Aproject.member.command.MemberInsertForm;
import co.prj.Aproject.member.command.MemberPwReset;
import co.prj.Aproject.member.command.MemberSelect;
import co.prj.Aproject.member.command.MemberSelectList;
import co.prj.Aproject.member.command.MemberUpdate;
import co.prj.Aproject.member.command.MemberYn;
import co.prj.Aproject.member.command.MemberYnForm;

@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HashMap<String, Command> map = new HashMap<String, Command>();

	public FrontController() {
		super();
	}

	public void init(ServletConfig config) throws ServletException {
		map.put("/loginForm.do", new LoginCommandForm());
		map.put("/login.do", new LoginCommand());
		map.put("/calendar.do", new CalendarCommand());
		map.put("/calendarInput.do", new CalendarInput());
		map.put("/home.do", new HomeCommand());
		
		//이메일
		map.put("/emailRecieve.do", new EmailRecieveCommand());
		map.put("/emailService.do", new EmailServiceCommand());
		map.put("/emailSend.do", new EmailSendCommand());
		
		//로그인
		map.put("/loginForm.do", new LoginCommandForm());
		map.put("/login.do", new LoginCommand());
		
		//회원가입
		map.put("/memberInsert.do", new MemberInsertCommand());
		
		//회원관리
		map.put("/memberYnForm.do", new MemberYnForm());
		map.put("/memberYn.do", new MemberYn());
		map.put("/memberSelectList.do", new MemberSelectList());
		map.put("/memberInsertForm.do", new MemberInsertForm());
		map.put("/memberDelete.do", new MemberDelete());
		map.put("/memberUpdate.do", new MemberUpdate());
		map.put("/memberPwReset.do", new MemberPwReset());
		map.put("/memberSelect.do", new MemberSelect());
		map.put("/memberAdminInputForm.do", new MemberAdminInputForm());
		
		map.put("/boardInputForm.do", new BoardInputForm()); //게시글 입력폼
		map.put("/boardInput.do", new BoardInput()); //게시글 저장
		map.put("/boardList.do", new BoardList()); //게시글 목록
		map.put("/ajaxSearchList.do", new AjaxSearchList()); //게시글 검색

	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String page = uri.substring(contextPath.length());
		
		Command command = map.get(page);
		String viewPage = command.exec(request, response);
		
		if(viewPage == null) {
	         viewPage = "404/404page.tiles";
	      }else if(viewPage.startsWith("ajax:")) {
	         response.setContentType("text/html; charset=UTF-8");
	         viewPage = viewPage.substring(5);
	         response.getWriter().append(viewPage);
	         return;
	      }else {
	         if(viewPage.equals("loginForm")) {
	            viewPage =  "/WEB-INF/views/"+viewPage + ".jsp";
	         }else {
	            viewPage = viewPage + ".tiles";
	         }
	      }

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}

}
