package co.prj.Aproject.email.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.email.service.EmailService;
import co.prj.Aproject.email.serviceImpl.EmailServiceImpl;
import co.prj.Aproject.email.vo.EmailVO;
import co.prj.Aproject.member.vo.MemberVO;

public class EmailDetailCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("memberVO");
		
		String toFromObj = request.getParameter("toFromObj");
		//emailId에 해당하는 내용을 가져와서 페이지에 뿌려주기
		EmailService dao = new EmailServiceImpl();
		EmailVO vo = new EmailVO();
		vo.setMemberNum(mvo.getMember_num());
		vo.setEmailId(Integer.parseInt(request.getParameter("emailId")));
		
		if(Integer.parseInt(toFromObj) == 1) { //0이면 to값 null
			vo.setEmailTo("toSomeone");
		}
		
		vo = dao.emailSelectOne(vo);
		
		request.setAttribute("email", vo);
		return "email/emailDetail";
	}

}
