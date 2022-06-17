package co.prj.Aproject.board.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.board.service.CommentService;
import co.prj.Aproject.board.serviceImpl.BoardCommentServiceImpl;
import co.prj.Aproject.board.vo.CommentVO;
import co.prj.Aproject.comm.Command;

public class BoardComment implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		CommentService service = new BoardCommentServiceImpl();
		CommentVO vo = new CommentVO();
		
		vo.setBoard_reply_id(Integer.parseInt(request.getParameter("Board_reply_id")));
		vo.setBoard_reply_subject(request.getParameter("board_reply_subject"));
		
		List<CommentVO> list = service.boardCommentSelect(vo);
		request.setAttribute("list", list);
		return null;
	}

}
