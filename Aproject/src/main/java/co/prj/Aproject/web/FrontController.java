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

import co.prj.Aproject.board.command.AjaxSearchList;
import co.prj.Aproject.board.command.BoardDetail;
import co.prj.Aproject.board.command.BoardInput;
import co.prj.Aproject.board.command.BoardInputForm;
import co.prj.Aproject.board.command.BoardList;
import co.prj.Aproject.board.command.BoardReplyInsert;
import co.prj.Aproject.calendar.CalendarDelete;
import co.prj.Aproject.calendar.CalendarInput;
import co.prj.Aproject.calendar.CalendarList;
import co.prj.Aproject.calendar.CalendarSearch;
import co.prj.Aproject.calendar.CalendarSelect;
import co.prj.Aproject.calendar.CalendarUpdate;
import co.prj.Aproject.calendar.command.CalendarCommand;
import co.prj.Aproject.comm.Command;
import co.prj.Aproject.commute.command.CommuteEndUpdate;
import co.prj.Aproject.commute.command.CommuteSelectDate;
import co.prj.Aproject.commute.command.CommuteSelectList;
import co.prj.Aproject.commute.command.CommuteStartInsert;
import co.prj.Aproject.email.command.EmailDeleteCommand;
import co.prj.Aproject.email.command.EmailDetailCommand;
import co.prj.Aproject.email.command.EmailRecieveCommand;
import co.prj.Aproject.email.command.EmailSendCommand;
import co.prj.Aproject.email.command.EmailSentMailCommand;
import co.prj.Aproject.email.command.EmailServiceCommand;
import co.prj.Aproject.home.command.HomeCommand;
import co.prj.Aproject.member.command.LoginCommand;
import co.prj.Aproject.member.command.LoginFormCommand;
import co.prj.Aproject.member.command.LogoutCommand;
import co.prj.Aproject.member.command.MemberAdminInput;
import co.prj.Aproject.member.command.MemberAdminInputForm;
import co.prj.Aproject.member.command.MemberDeleteCommand;
import co.prj.Aproject.member.command.MemberInsertCommand;
import co.prj.Aproject.member.command.MemberInsertFormCommand;
import co.prj.Aproject.member.command.MemberPwResetCommand;
import co.prj.Aproject.member.command.MemberSelectCommand;
import co.prj.Aproject.member.command.MemberSelectListCommand;
import co.prj.Aproject.member.command.MemberUpdateCommand;
import co.prj.Aproject.member.command.MemberYnCommand;
import co.prj.Aproject.member.command.MemberYnFormCommand;
import co.prj.Aproject.section.command.SectionDelete;
import co.prj.Aproject.section.command.SectionInsert;
import co.prj.Aproject.section.command.SectionInsertForm;
import co.prj.Aproject.section.command.SectionSelect;
import co.prj.Aproject.section.command.SectionSelectList;
import co.prj.Aproject.section.command.SectionUpdate;

@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HashMap<String, Command> map = new HashMap<String, Command>();

	public FrontController() {
		super();
	}

	public void init(ServletConfig config) throws ServletException {
		map.put("/loginForm.do", new LoginFormCommand());
		map.put("/login.do", new LoginCommand());
		map.put("/logout.do", new LogoutCommand());
		
		map.put("/calendar.do", new CalendarCommand());
		map.put("/calendarList.do", new CalendarList());
		map.put("/calendarInput.do", new CalendarInput());
		map.put("/calendarUpdate.do", new CalendarUpdate());
		map.put("/calendarDelete.do", new CalendarDelete());
		map.put("/calendarSelect.do", new CalendarSelect());
		map.put("/calendarSearch.do", new CalendarSearch());
		map.put("/home.do", new HomeCommand());
		
		//이메일
		map.put("/emailRecieve.do", new EmailRecieveCommand());
		map.put("/emailService.do", new EmailServiceCommand());
		map.put("/emailSend.do", new EmailSendCommand());
		map.put("/emailDelete.do", new EmailDeleteCommand());
		map.put("/emailDetail.do", new EmailDetailCommand());
		map.put("/emailSentMail.do", new EmailSentMailCommand());
		
		//로그인
		map.put("/loginForm.do", new LoginFormCommand());
		map.put("/login.do", new LoginCommand());
		
		//회원가입
		map.put("/memberInsert.do", new MemberInsertCommand());
		
		//회원관리
		map.put("/memberYnForm.do", new MemberYnFormCommand());
		map.put("/memberYn.do", new MemberYnCommand());
		map.put("/memberSelectList.do", new MemberSelectListCommand());
		map.put("/memberInsertForm.do", new MemberInsertFormCommand());
		map.put("/memberDelete.do", new MemberDeleteCommand());
		map.put("/memberUpdate.do", new MemberUpdateCommand());
		map.put("/memberPwReset.do", new MemberPwResetCommand());
		map.put("/memberSelect.do", new MemberSelectCommand());
		map.put("/memberAdminInputForm.do", new MemberAdminInputForm());
		map.put("/memberAdminInput.do", new MemberAdminInput());
		
		//부서관리
		map.put("/sectionSelectList.do", new SectionSelectList());
		map.put("/sectionSelect.do", new SectionSelect());
		map.put("/sectionUpdate.do", new SectionUpdate());
		map.put("/sectionDelete.do", new SectionDelete());
		map.put("/sectionInsertForm.do", new SectionInsertForm());
		map.put("/sectionInsert.do", new SectionInsert());
	
		map.put("/boardInputForm.do", new BoardInputForm()); //게시글 입력폼
		map.put("/boardInput.do", new BoardInput()); //게시글 저장
		map.put("/boardList.do", new BoardList()); //게시글 목록
		map.put("/ajaxSearchList.do", new AjaxSearchList()); //게시글 검색

		
		map.put("/commuteSelectList.do", new CommuteSelectList());
		map.put("/commuteStartInsert.do", new CommuteStartInsert());
		map.put("/commuteEndUpdate.do", new CommuteEndUpdate());
		map.put("/commuteSelectDate.do", new CommuteSelectDate());
		

		map.put("/boardDetail.do", new BoardDetail()); // 게시글 상세		
		map.put("/boardReplyInsert.do", new BoardReplyInsert()); // 댓글등록

	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String page = uri.substring(contextPath.length());
		
		Command command = map.get(page);
		String viewPage = command.exec(request, response);
		System.out.println(viewPage);
		if(viewPage == null) {
	         viewPage = "404/404page.tiles";
	    }else if(viewPage.startsWith("ajax:")) {
	         response.setContentType("text/html; charset=UTF-8");
	         viewPage = viewPage.substring(5);
	         response.getWriter().append(viewPage);
	         return;
	    }else if(!viewPage.endsWith(".do")){
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
