package co.prj.Aproject.email.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.email.service.EmailService;

public class EmailRecieve implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		EmailService es = new EmailService();
		es.gmailRecieve();
		return "email/emailRecieve";
	}

}
