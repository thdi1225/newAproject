package co.prj.Aproject.board.command;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.board.service.BoardService;
import co.prj.Aproject.board.service.CommentService;
import co.prj.Aproject.board.serviceImpl.BoardCommentServiceImpl;
import co.prj.Aproject.board.serviceImpl.BoardServiceImpl;
import co.prj.Aproject.board.vo.BoardVO;
import co.prj.Aproject.board.vo.CommentVO;
import co.prj.Aproject.comm.Command;

public class BoardDetail implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		BoardService dao = new BoardServiceImpl();
		CommentService service = new BoardCommentServiceImpl();
		
		BoardVO vo = new BoardVO();
		CommentVO commentVO = new CommentVO();

		vo.setBoard_id(Integer.parseInt(request.getParameter("board_id")));
		vo = dao.boardDetail(vo);
		
		commentVO.setBoard_id(Integer.parseInt(request.getParameter("board_id")));
		List<CommentVO> list = service.boardCommentSelect(commentVO);

		request.setAttribute("board", vo);
		request.setAttribute("list", list);
		
		return "board/boardDetail";
	}

}
