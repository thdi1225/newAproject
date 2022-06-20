package co.prj.Aproject.board.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.board.service.BoardService;
import co.prj.Aproject.board.service.ReplyService;
import co.prj.Aproject.board.serviceImpl.BoardReplyServiceImpl;
import co.prj.Aproject.board.serviceImpl.BoardServiceImpl;
import co.prj.Aproject.board.vo.BoardVO;
import co.prj.Aproject.board.vo.ReplyVO;
import co.prj.Aproject.comm.Command;

public class BoardDetail implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		BoardService dao = new BoardServiceImpl();
		ReplyService service = new BoardReplyServiceImpl();
		
		BoardVO vo = new BoardVO();
		ReplyVO ReplyVO = new ReplyVO();

		vo.setBoard_id(Integer.parseInt(request.getParameter("board_id")));
		vo = dao.boardDetail(vo);
		
		ReplyVO.setBoard_id(Integer.parseInt(request.getParameter("board_id")));
		List<ReplyVO> list = service.boardReplySelect(ReplyVO);
		dao.boardHitUpdate(vo);
		request.setAttribute("board", vo);
		request.setAttribute("list", list);
		
		return "board/boardDetail";
	}
}
