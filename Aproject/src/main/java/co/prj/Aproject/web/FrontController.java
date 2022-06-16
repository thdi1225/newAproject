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
import co.prj.Aproject.comm.Command;
import co.prj.Aproject.email.command.EmailRecieve;
import co.prj.Aproject.email.command.EmailSendCommand;
import co.prj.Aproject.email.command.EmailServiceCommand;
import co.prj.Aproject.home.command.HomeCommand;
import co.prj.Aproject.member.command.LoginCommand;
import co.prj.Aproject.member.command.LoginCommandForm;
import co.prj.Aproject.member.command.MemberInsertCommand;

@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HashMap<String, Command> map = new HashMap<String, Command>();

	public FrontController() {
		super();
	}

	public void init(ServletConfig config) throws ServletException {
		map.put("/loginForm.do", new LoginCommandForm());
		map.put("/home.do", new HomeCommand());
		map.put("/emailRecieve.do", new EmailRecieve());
		map.put("/emailService.do", new EmailServiceCommand());
		map.put("/emailSend.do", new EmailSendCommand());
		map.put("/login.do", new LoginCommand());
		map.put("/memberInsert.do", new MemberInsertCommand());
		
		map.put("/boardInputForm.do", new BoardInputForm()); //게시글 입력폼
		map.put("/boardInput.do", new BoardInput()); //게시글 저장
		map.put("/boardList.do", new BoardList()); //게시글 목록
		map.put("/ajaxSearchList.do", new AjaxSearchList()); //게시글 검색
		map.put("/boardDetail.do", new BoardDetail()); // 게시글 상세		
		map.put("/boardReplyInsert.do", new BoardReplyInsert()); // 댓글등록
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String page = uri.substring(contextPath.length());
		System.out.println(uri);
		System.out.println(contextPath);
		System.out.println(page);
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
