package co.prj.Aproject.member.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.member.service.MemberService;
import co.prj.Aproject.member.serviceImpl.MemberServiceImpl;
import co.prj.Aproject.member.vo.MemberVO;
import co.prj.Aproject.section.service.SectionService;
import co.prj.Aproject.section.serviceImpl.SectionServiceImpl;

public class MemberAdminInput implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		MemberService service = new MemberServiceImpl();
		
		MemberVO vo = new MemberVO();
		
		vo.setSection_id(Integer.parseInt(request.getParameter("section_id")));
		vo.setMember_email(request.getParameter("member_insert_email"));
		vo.setMember_pw(request.getParameter("member_insert_pw"));
		vo.setMember_name(request.getParameter("member_insert_name"));
		vo.setMember_phone(request.getParameter("member_insert_phone"));
		vo.setMember_job(request.getParameter("member_insert_job"));
		vo.setMember_auth(Integer.parseInt(request.getParameter("member_insert_auth")));
		
		int result = service.memberAdminInput(vo);
		Gson gson = new GsonBuilder().create();
		
		return "ajax:" + gson.toJson(result);
	}

}
