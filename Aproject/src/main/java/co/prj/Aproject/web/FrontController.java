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

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.email.command.EmailRecieve;
import co.prj.Aproject.email.command.EmailSendCommand;
import co.prj.Aproject.email.command.EmailServiceCommand;
import co.prj.Aproject.home.command.HomeCommand;
import co.prj.Aproject.member.command.LoginCommand;
import co.prj.Aproject.member.command.LoginCommandForm;
import co.prj.Aproject.member.command.MemberInsertCommand;
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
		map.put("/home.do", new HomeCommand());
		map.put("/emailRecieve.do", new EmailRecieve());
		map.put("/emailService.do", new EmailServiceCommand());
		map.put("/emailSend.do", new EmailSendCommand());
		map.put("/login.do", new LoginCommand());
		map.put("/memberInsert.do", new MemberInsertCommand());
		map.put("/memberYnForm.do", new MemberYnForm());
		map.put("/memberYn.do", new MemberYn());
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String page = uri.substring(contextPath.length());

		Command command = map.get(page);
		String viewPage = command.exec(request, response);
		
		if (!viewPage.endsWith(".do") && !viewPage.equals(null)) {
			if(viewPage.equals("loginForm")) {
				viewPage =  "/WEB-INF"+"/views/"+viewPage + ".jsp";
			}else {
				viewPage = viewPage + ".tiles";
			}
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}

}
