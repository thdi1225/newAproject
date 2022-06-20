package co.prj.Aproject.member.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.member.service.MemberService;
import co.prj.Aproject.member.serviceImpl.MemberServiceImpl;
import co.prj.Aproject.member.vo.MemberPage;
import co.prj.Aproject.member.vo.MemberVO;

public class MemberYnFormCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		MemberService service = new MemberServiceImpl();
		
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
		
		int totalCount = service.memberYnSelectListCount(page);
		
		page = new MemberPage(totalCount, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage), request.getParameter("search"));
		
		List<MemberVO> list = service.memberYnSelectList(page);

		request.setAttribute("paging", page);
		request.setAttribute("list", list);
		return "member/memberYnForm";
	}

}
