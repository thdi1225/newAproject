package co.prj.Aproject.board.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.board.service.BoardService;
import co.prj.Aproject.board.serviceImpl.BoardServiceImpl;
import co.prj.Aproject.board.vo.BoardVO;
import co.prj.Aproject.comm.Command;

public class BoardDetail implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		BoardService dao = new BoardServiceImpl();
		BoardVO vo = new BoardVO();
		vo.setBoard_id(Integer.parseInt(request.getParameter("board_id")));
		vo = dao.boardDetail(vo);
		request.setAttribute("board", vo);
		return "board/boardDetail";
	}

}
