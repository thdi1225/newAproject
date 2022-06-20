package co.prj.Aproject.member.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.section.service.SectionService;
import co.prj.Aproject.section.serviceImpl.SectionServiceImpl;

public class MyPage implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		SectionService sectionService = new SectionServiceImpl();
		request.setAttribute("sectionList", sectionService.sectionSelectList(null));
		return "member/myPage";
	}

}
