package co.prj.Aproject.board.command;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.board.service.CommentService;
import co.prj.Aproject.board.serviceImpl.BoardCommentServiceImpl;
import co.prj.Aproject.board.vo.CommentVO;
import co.prj.Aproject.comm.Command;

public class BoardCommentList implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		CommentService service = new BoardCommentServiceImpl();
		List<CommentVO> list = new ArrayList<CommentVO>();
		CommentVO vo = new CommentVO();
		vo.setBoard_id(0);
		service.boardCommentSelect(vo);
		
		return null;
	}

}
