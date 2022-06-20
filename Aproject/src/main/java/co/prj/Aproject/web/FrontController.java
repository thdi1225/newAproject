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
import javax.servlet.http.HttpSession;

import co.prj.Aproject.board.command.AjaxSearchList;
import co.prj.Aproject.board.command.BoardDelete;
import co.prj.Aproject.board.command.BoardDetail;
import co.prj.Aproject.board.command.BoardInput;
import co.prj.Aproject.board.command.BoardInputForm;
import co.prj.Aproject.board.command.BoardList;
import co.prj.Aproject.board.command.BoardReplyDelete;
import co.prj.Aproject.board.command.BoardReplyInsert;
import co.prj.Aproject.board.command.BoardReplyUpdate;
import co.prj.Aproject.board.command.BoardUpdate;
import co.prj.Aproject.calendar.CalendarDelete;
import co.prj.Aproject.calendar.CalendarInput;
import co.prj.Aproject.calendar.CalendarList;
import co.prj.Aproject.calendar.CalendarSearch;
import co.prj.Aproject.calendar.CalendarSelect;
import co.prj.Aproject.calendar.CalendarUpdate;
import co.prj.Aproject.calendar.command.CalendarCommand;
import co.prj.Aproject.comm.Command;
import co.prj.Aproject.commute.command.CommuteEmpSearchList;
import co.prj.Aproject.commute.command.CommuteEmpSelectList;
import co.prj.Aproject.commute.command.CommuteEndUpdate;
import co.prj.Aproject.commute.command.CommuteSelectDate;
import co.prj.Aproject.commute.command.CommuteSelectList;
import co.prj.Aproject.commute.command.CommuteStartInsert;
import co.prj.Aproject.email.command.EmailDeleteCommand;
import co.prj.Aproject.email.command.EmailDetailCommand;
import co.prj.Aproject.email.command.EmailEmptyCommand;
import co.prj.Aproject.email.command.EmailLoginCommand;
import co.prj.Aproject.email.command.EmailLoginServiceCommand;
import co.prj.Aproject.email.command.EmailLogoutCommand;
import co.prj.Aproject.email.command.EmailLogoutService;
import co.prj.Aproject.email.command.EmailRecieveCommand;
import co.prj.Aproject.email.command.EmailSendCommand;
import co.prj.Aproject.email.command.EmailSentMailCommand;
import co.prj.Aproject.email.command.EmailServiceCommand;
import co.prj.Aproject.email.command.EmailSelectFiveCommand;
import co.prj.Aproject.home.command.HomeCommand;
import co.prj.Aproject.member.command.LoginCommand;
import co.prj.Aproject.member.command.LoginFormCommand;
import co.prj.Aproject.member.command.LogoutCommand;
import co.prj.Aproject.member.command.MemberAdminInput;
import co.prj.Aproject.member.command.MemberAdminInputForm;
import co.prj.Aproject.member.command.MemberDeleteCommand;
import co.prj.Aproject.member.command.MemberInsertCommand;
import co.prj.Aproject.member.command.MemberInsertFormCommand;
import co.prj.Aproject.member.command.MemberMyPage;
import co.prj.Aproject.member.command.MemberPwResetCommand;
import co.prj.Aproject.member.command.MemberSelectCommand;
import co.prj.Aproject.member.command.MemberSelectListCommand;
import co.prj.Aproject.member.command.MemberUpdateCommand;
import co.prj.Aproject.member.command.MemberYnCommand;
import co.prj.Aproject.member.command.MemberYnFormCommand;
import co.prj.Aproject.member.command.MyPage;
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

		//로그인
		map.put("/loginForm.do", new LoginFormCommand());
		map.put("/login.do", new LoginCommand());
		map.put("/logout.do", new LogoutCommand());

		//메인화면
		map.put("/home.do", new HomeCommand());
		
		//회원관리
		map.put("/memberInsert.do", new MemberInsertCommand());
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
		map.put("/myPage.do", new MyPage());
		map.put("/memberMyPage.do", new MemberMyPage());
		
		//부서관리
		map.put("/sectionSelectList.do", new SectionSelectList());
		map.put("/sectionSelect.do", new SectionSelect());
		map.put("/sectionUpdate.do", new SectionUpdate());
		map.put("/sectionDelete.do", new SectionDelete());
		map.put("/sectionInsertForm.do", new SectionInsertForm());
		map.put("/sectionInsert.do", new SectionInsert());
		
		//이메일
		map.put("/emailRecieve.do", new EmailRecieveCommand());
		map.put("/emailService.do", new EmailServiceCommand());
		map.put("/emailSend.do", new EmailSendCommand());
		map.put("/emailDelete.do", new EmailDeleteCommand());
		map.put("/emailDetail.do", new EmailDetailCommand());
		map.put("/emailSentMail.do", new EmailSentMailCommand());
		map.put("/emailLogin.do", new EmailLoginCommand());
		map.put("/emailLoginService.do", new EmailLoginServiceCommand());
		map.put("/emailLogout.do", new EmailLogoutCommand());
		map.put("/emailLogoutService.do", new EmailLogoutService());
		map.put("/emailEmpty.do", new EmailEmptyCommand());
		map.put("/emailSelectFive.do", new EmailSelectFiveCommand());
		
		//일정관리
		map.put("/calendar.do", new CalendarCommand());
		map.put("/calendarList.do", new CalendarList());
		map.put("/calendarInput.do", new CalendarInput());
		map.put("/calendarUpdate.do", new CalendarUpdate());
		map.put("/calendarDelete.do", new CalendarDelete());
		map.put("/calendarSelect.do", new CalendarSelect());
		map.put("/calendarSearch.do", new CalendarSearch());
		
		//게시판 관리
		map.put("/boardDetail.do", new BoardDetail()); 		
		map.put("/boardReplyInsert.do", new BoardReplyInsert()); 
		map.put("/boardUpdate.do", new BoardUpdate());
		map.put("/boardInputForm.do", new BoardInputForm());
		map.put("/boardInput.do", new BoardInput());
		map.put("/boardList.do", new BoardList()); 
		map.put("/ajaxSearchList.do", new AjaxSearchList());
		map.put("/boardReplyUpdate.do", new BoardReplyUpdate()); // 댓글수정
		map.put("/boardReplyDelete.do", new BoardReplyDelete()); // 댓글삭제
		map.put("/boardDelete.do", new BoardDelete()); // 게시글 삭제
		
		//출퇴근 관리
		map.put("/commuteSelectList.do", new CommuteSelectList());
		map.put("/commuteStartInsert.do", new CommuteStartInsert());
		map.put("/commuteEndUpdate.do", new CommuteEndUpdate());
		map.put("/commuteSelectDate.do", new CommuteSelectDate());
		map.put("/commuteEmpSelectList.do", new CommuteEmpSelectList());
		map.put("/commuteEmpSearchList.do", new CommuteEmpSearchList());

	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String page = uri.substring(contextPath.length());
		
		Command command = map.get(page);
		String viewPage = command.exec(request, response);
		if(viewPage == null) {
	         viewPage = "404/404page.tiles";
	    }else if(viewPage.startsWith("ajax:")) {
	        if(session.getAttribute("memberVO") == null) {
	            viewPage =  "/WEB-INF/views/loginForm.jsp";	        	
	        } else {
	        	response.setContentType("text/html; charset=UTF-8");
		        viewPage = viewPage.substring(5);
		        response.getWriter().append(viewPage);
		        return;
	        }
	    }else if(!viewPage.endsWith(".do")){
	       if(viewPage.equals("loginForm")) {
	           viewPage =  "/WEB-INF/views/loginForm.jsp";
	       }else {
	    	   if(session.getAttribute("memberVO") == null) {
	    		   viewPage =  "/WEB-INF/views/loginForm.jsp";
	    	   }else {
	    		   viewPage = viewPage + ".tiles";   
	    	   }
	       }         
	    }
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
        dispatcher.forward(request, response);
	}

}
