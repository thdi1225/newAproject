package co.prj.Aproject.email.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.email.service.EmailFunc;
import co.prj.Aproject.email.service.EmailService;
import co.prj.Aproject.email.serviceImpl.EmailServiceImpl;
import co.prj.Aproject.member.vo.MemberVO;

public class EmailLoginServiceCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String mailEmail = request.getParameter("mailEmail");
		String mailPw = request.getParameter("mailPw");
		
		EmailFunc ef = new EmailFunc();
		
		String page;
		boolean flag = ef.gmailSend(mailEmail, "가입요청", "Aproject에서 "+mailEmail+"님의 로그인을 시도했습니다.", mailEmail, mailPw);
		if(flag) {//구글 로그인 가능
			//Session에 저장,
			MemberVO member = (MemberVO) session.getAttribute("memberVO");
			member.setMember_mail_email(mailEmail);
			member.setMember_mail_pw(mailPw);
			session.setAttribute("memberVO", member);
			EmailService dao = new EmailServiceImpl();
			//db에 저장
			dao.emailInfoUpdate(member);
			page = "ajax:"+"true";
		}else {
			page = "ajax:"+"false";
		}
		
		return page;
	}

}
