package co.prj.Aproject.member.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.member.service.MemberService;
import co.prj.Aproject.member.serviceImpl.MemberServiceImpl;
import co.prj.Aproject.member.vo.MemberPage;
import co.prj.Aproject.member.vo.MemberVO;
import co.prj.Aproject.section.service.SectionService;
import co.prj.Aproject.section.serviceImpl.SectionServiceImpl;

public class MemberSelectListCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		MemberService service = new MemberServiceImpl();
		SectionService sectionService = new SectionServiceImpl();
		
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		
		MemberPage page = new MemberPage();
		page.setSearch(request.getParameter("search"));

		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "5";
		}
		
		int totalCount = service.memberSelectListCount(page);
		
		page = new MemberPage(totalCount, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage), request.getParameter("search"));
		
		List<MemberVO> list = service.memberSelectList(page);
		
		request.setAttribute("sectionList", sectionService.sectionSelectList(null));
		request.setAttribute("paging", page);
		request.setAttribute("list", list);
		
		return "member/memberSelectList";
	}

}
