package co.prj.Aproject.board.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import co.prj.Aproject.board.service.ReplyService;
import co.prj.Aproject.board.serviceImpl.BoardReplyServiceImpl;
import co.prj.Aproject.board.vo.ReplyVO;
import co.prj.Aproject.comm.Command;

public class BoardReplyUpdate implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		ReplyService service = new BoardReplyServiceImpl();
		ReplyVO vo = new ReplyVO();
		
		vo.setBoard_reply_id(Integer.parseInt(request.getParameter("board_reply_id")));
		vo.setBoard_reply_subject(request.getParameter("board_reply_subject"));

		Gson gson = new GsonBuilder().create();
		service.boardReplyUpdate(vo);
		
		return "ajax:" + gson.toJson(vo);
	}

}
