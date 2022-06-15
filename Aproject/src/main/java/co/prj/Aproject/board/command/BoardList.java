package co.prj.Aproject.board.command;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.board.service.BoardService;
import co.prj.Aproject.board.serviceImpl.BoardServiceImpl;
import co.prj.Aproject.board.vo.BoardVO;
import co.prj.Aproject.comm.Command;

public class BoardList implements Command {
	
	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 게시글 목록 가져오기
		BoardService dao = new BoardServiceImpl();
		List<BoardVO> list = new ArrayList<BoardVO>();
		list = dao.boardSelectList();
		request.setAttribute("list", list);
		System.out.println("testesttest");
		return "board/boardList";
	}

}



