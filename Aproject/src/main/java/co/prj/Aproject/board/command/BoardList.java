package co.prj.Aproject.board.command;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.board.service.BoardService;
import co.prj.Aproject.board.serviceImpl.BoardServiceImpl;
import co.prj.Aproject.board.vo.BoardPage;
import co.prj.Aproject.board.vo.BoardVO;
import co.prj.Aproject.comm.Command;

public class BoardList implements Command {
	
	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 게시글 목록 가져오기
		BoardService dao = new BoardServiceImpl();
		List<BoardVO> list = new ArrayList<BoardVO>();
		
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		
		BoardPage page = new BoardPage();
		page.setSearch(request.getParameter("search"));
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "10";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "10";
		}
		
		int totalCount = dao.boardListCount(page);
		page = new BoardPage(totalCount, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage), request.getParameter("search"));
		list = dao.boardSelectList(page);
		
		request.setAttribute("paging", page);
		request.setAttribute("list", list);
		
		return "board/boardList";
	}

}