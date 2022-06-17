package co.prj.Aproject.email.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.member.vo.MemberVO;

public class EmailSendCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("memberVO");
		
		String memberMailEmail = member.getMember_mail_email();
		String memberMailPw = member.getMember_mail_pw();		
		
		String page;
		if(memberMailEmail != null && memberMailPw != null) {
			page = "email/emailSend";
		}else {
			page = "email/emailLogin";
		}
		
		return page;
	}

}
