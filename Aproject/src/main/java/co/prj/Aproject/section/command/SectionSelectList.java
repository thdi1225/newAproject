package co.prj.Aproject.section.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.section.service.SectionService;
import co.prj.Aproject.section.serviceImpl.SectionServiceImpl;
import co.prj.Aproject.section.vo.SectionPage;
import co.prj.Aproject.section.vo.SectionVO;

public class SectionSelectList implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		SectionService service = new SectionServiceImpl();
		
		
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		
		SectionPage page = new SectionPage();
		page.setSearch(request.getParameter("search"));

		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "5";
		}
		
		int totalCount = service.sectionSelectListCount(page);
		
		page = new SectionPage(totalCount, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage), request.getParameter("search"));
		
		List<SectionVO> list = service.sectionSelectList(page);
		
		request.setAttribute("paging", page);
		request.setAttribute("list", list);
		
		return "section/sectionSelectList";
	}

}
