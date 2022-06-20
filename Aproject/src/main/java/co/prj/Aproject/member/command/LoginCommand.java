package co.prj.Aproject.member.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.member.service.MemberService;
import co.prj.Aproject.member.serviceImpl.MemberServiceImpl;
import co.prj.Aproject.member.vo.MemberVO;

public class LoginCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		MemberService service = new MemberServiceImpl();
		MemberVO vo = new MemberVO();
		
		vo.setMember_email(request.getParameter("member_email"));
		vo.setMember_pw(request.getParameter("member_pw"));
		
		vo = service.login(vo);
		HttpSession session = request.getSession();
		
		if(vo != null && vo.getMember_yn().equals("Y")) {
			session.setAttribute("memberVO", vo);
			
			return "home.do";
		}else if(vo != null && vo.getMember_yn().equals("N")){
			request.setAttribute("message", "승인 받지 못한 회원입니다. 관리자에게 문의하여 주세요.");
			return "loginForm.do";
		}else {
			request.setAttribute("message", "아이디 또는 비밀번호가 일치하지 않습니다.");
			return "loginForm.do";
		}
	}

}
