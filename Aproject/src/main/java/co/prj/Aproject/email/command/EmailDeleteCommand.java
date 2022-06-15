package co.prj.Aproject.email.command;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.email.service.EmailImapRecieve;

public class EmailDeleteCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		int memberNum = (int) session.getAttribute("memberNum");
		
		String emailId = request.getParameter("emailId");
		System.out.println("emailId : " + emailId);
		
		EmailImapRecieve eir = new EmailImapRecieve();
		List<Integer> idList = new ArrayList<Integer>();
		idList.add(Integer.parseInt(emailId));
		eir.getMailAll(3, idList,memberNum);
		
		return "email/emailRecieve";
	}

}
