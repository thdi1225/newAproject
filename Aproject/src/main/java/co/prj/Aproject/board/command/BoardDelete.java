package co.prj.Aproject.board.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import co.prj.Aproject.board.service.BoardService;
import co.prj.Aproject.board.serviceImpl.BoardServiceImpl;
import co.prj.Aproject.board.vo.BoardVO;
import co.prj.Aproject.comm.Command;

public class BoardDelete implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		BoardService service = new BoardServiceImpl();
		BoardVO vo = new BoardVO();
		
		vo.setBoard_id(Integer.parseInt(request.getParameter("board_id")));
		
		int result = service.boardDelete(vo);
		
		Gson gson = new GsonBuilder().create();
		
		return "ajax:" + gson.toJson(result);
	}

}
