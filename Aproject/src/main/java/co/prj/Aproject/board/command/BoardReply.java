package co.prj.Aproject.board.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.board.service.ReplyService;
import co.prj.Aproject.board.serviceImpl.BoardReplyServiceImpl;
import co.prj.Aproject.board.vo.ReplyVO;
import co.prj.Aproject.comm.Command;

public class BoardReply implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		ReplyService service = new BoardReplyServiceImpl();
		ReplyVO vo = new ReplyVO();
		
		vo.setBoard_reply_id(Integer.parseInt(request.getParameter("Board_reply_id")));
		vo.setBoard_reply_subject(request.getParameter("board_reply_subject"));
		
		List<ReplyVO> list = service.boardReplySelect(vo);
		request.setAttribute("list", list);
		return null;
	}

}
