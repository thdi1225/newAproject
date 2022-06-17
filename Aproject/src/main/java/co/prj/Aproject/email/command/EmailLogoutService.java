package co.prj.Aproject.email.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.email.service.EmailService;
import co.prj.Aproject.email.serviceImpl.EmailServiceImpl;
import co.prj.Aproject.member.vo.MemberVO;

public class EmailLogoutService implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO)session.getAttribute("memberVO");
		String realPw = member.getMember_mail_pw();
		
		String logBoolean = request.getParameter("logout");
		String pw = request.getParameter("mailPw");
		System.out.println(logBoolean);
		
		String data;
		if(logBoolean.equals("true")) {
			//로그아웃처리
			//session 비우기
			member.setMember_mail_email(null);
			member.setMember_mail_pw(null);
			session.setAttribute("memberVO", member);
			data= "true";
			//db 비우기
			EmailService dao = new EmailServiceImpl();
			dao.emailInfoUpdate(member);
		}else {
			if(pw.equals(realPw)) { //비밀번호 확인됐으면
				data = "true";
			}else {
				data= "false";
			}
		}

		return "ajax:"+data;
	}

}
