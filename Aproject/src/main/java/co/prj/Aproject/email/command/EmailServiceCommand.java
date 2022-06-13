package co.prj.Aproject.email.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.email.service.EmailService;

public class EmailServiceCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		EmailService es = new EmailService();
		String to = request.getParameter("to");
		String title = request.getParameter("title");
		String subject = request.getParameter("subject");
		
		boolean flag = es.gmailSend(to, title, subject);
		System.out.println(flag);
		if(flag) {
			System.out.println("전송완료");
		}else {
			System.out.println("전송실패");
		}
		return "email/emailService";
	}

}
