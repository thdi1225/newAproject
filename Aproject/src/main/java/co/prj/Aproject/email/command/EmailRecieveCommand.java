package co.prj.Aproject.email.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.email.service.EmailFunc;
import co.prj.Aproject.email.service.EmailService;
import co.prj.Aproject.email.serviceImpl.EmailServiceImpl;
import co.prj.Aproject.email.vo.EmailVO;
import co.prj.Aproject.member.vo.MemberVO;

public class EmailRecieveCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		EmailService dao = new EmailServiceImpl();
		String type = request.getParameter("type");
		HttpSession session = request.getSession();
		
		MemberVO member = (MemberVO) session.getAttribute("memberVO");
		int memberNum = member.getMember_num();
		System.out.println("memberNum : "+memberNum);
		if(type.equals("refresh")) {
			EmailFunc f = new EmailFunc();
			f.saveEmailsInDB(memberNum);
		}		
		//기본 동작
		List<EmailVO> emails = dao.emailSelectListAll(memberNum);
		request.setAttribute("memberNum", memberNum);
		request.setAttribute("emails", emails);
		
		return "email/emailRecieve";
	}

}
