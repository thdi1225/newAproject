package co.prj.Aproject.member.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.member.service.MemberService;
import co.prj.Aproject.member.serviceImpl.MemberServiceImpl;
import co.prj.Aproject.member.vo.MemberVO;
import co.prj.Aproject.section.service.SectionService;
import co.prj.Aproject.section.serviceImpl.SectionServiceImpl;

public class MemberInsertCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		MemberService service = new MemberServiceImpl();
		SectionService sectionService = new SectionServiceImpl();
		MemberVO vo = new MemberVO();
		
		vo.setSection_id(Integer.parseInt(request.getParameter("section_id")));
		vo.setMember_email(request.getParameter("member_insert_email"));
		vo.setMember_pw(request.getParameter("member_insert_pw"));
		vo.setMember_name(request.getParameter("member_insert_name"));
		vo.setMember_phone(request.getParameter("member_insert_phone"));
		vo.setMember_job(request.getParameter("member_insert_job"));
		
		request.setAttribute("sectionList", sectionService.sectionSelectList(null));
		
		try {
			service.memberInsert(vo);
			request.setAttribute("success", "회원가입을 완료하였습니다.");
		} catch (Exception e) {
			request.setAttribute("message", "이미 등록된 이메일입니다.");
			return "loginForm";
		}
		
		return "loginForm";
	}

}
