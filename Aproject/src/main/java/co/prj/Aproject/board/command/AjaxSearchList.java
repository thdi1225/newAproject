package co.prj.Aproject.board.command;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.prj.Aproject.board.service.BoardService;
import co.prj.Aproject.board.serviceImpl.BoardServiceImpl;
import co.prj.Aproject.board.vo.BoardVO;
import co.prj.Aproject.comm.Command;

public class AjaxSearchList implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 게시글 검색
		BoardService dao = new BoardServiceImpl();
		List<BoardVO> list = new ArrayList<BoardVO>();
		ObjectMapper mapper = new ObjectMapper();  //json string으로 만들기 위해
		String key = request.getParameter("key");
		String val = request.getParameter("val");
		list = dao.boardSearchList(key, val);
		String jsonData ="";
		try {
			jsonData = mapper.writeValueAsString(list);  //리스트를 json String 으로
		} catch (JsonProcessingException e) {
				e.printStackTrace();
		}
		System.out.println(jsonData);
				
		return "ajax:" + jsonData;
	}

}
