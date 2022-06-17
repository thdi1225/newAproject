package co.prj.Aproject.member.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.member.service.MemberService;
import co.prj.Aproject.member.serviceImpl.MemberServiceImpl;
import co.prj.Aproject.member.vo.MemberVO;

public class MemberUpdateCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		MemberService service = new MemberServiceImpl();
		MemberVO vo = new MemberVO();
		
		vo.setMember_num(Integer.parseInt(request.getParameter("member_num")));
		vo.setSection_id(Integer.parseInt(request.getParameter("section_id")));
		vo.setMember_email(request.getParameter("member_email"));
		vo.setMember_name(request.getParameter("member_name"));
		vo.setMember_phone(request.getParameter("member_phone"));
		vo.setMember_job(request.getParameter("member_job"));
		vo.setMember_auth(Integer.parseInt(request.getParameter("member_auth")));
		
		Gson gson = new GsonBuilder().create();
		service.memberUpdate(vo);
		
		return "ajax:" + gson.toJson(vo);
	}

}
