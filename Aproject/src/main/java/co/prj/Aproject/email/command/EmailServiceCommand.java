package co.prj.Aproject.email.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.email.service.EmailFunc;
import co.prj.Aproject.email.service.EmailService;
import co.prj.Aproject.email.serviceImpl.EmailServiceImpl;
import co.prj.Aproject.email.vo.EmailVO;
import co.prj.Aproject.member.vo.MemberVO;

public class EmailServiceCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("memberVO");
		int memberNum = member.getMember_num();
		String mailEmail = member.getMember_mail_email();
		String mailPw = member.getMember_mail_pw();
		
		
		EmailFunc es = new EmailFunc();
		String to = request.getParameter("to");
		String title = request.getParameter("title");
		String subject = request.getParameter("subject");
		
		EmailVO vo = new EmailVO();
		EmailService dao = new EmailServiceImpl();
		vo.setEmailTo(to);
		vo.setEmailTitle(title);
		vo.setEmailSubject(subject);
		vo.setMemberNum(memberNum);
		
		boolean flag = es.gmailSend(to, title, subject,mailEmail,mailPw);
		if(flag) {
			System.out.println("전송완료");
			dao.emailInsert(vo);
			return "ajax:1";
		}else {
			System.out.println("전송실패");
			return "ajax:0";
		}
	}

}
