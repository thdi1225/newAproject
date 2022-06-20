package co.prj.Aproject.commute.command;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.commute.Impl.CommuteImpl;
import co.prj.Aproject.commute.service.CommuteService;
import co.prj.Aproject.commute.vo.CommuteVO;
import co.prj.Aproject.member.vo.MemberVO;

public class CommuteEmpSearchList implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		
		System.out.println("실행");
		CommuteService dao = new CommuteImpl();
		List<CommuteVO> list = new ArrayList<CommuteVO>();
		ObjectMapper mapper = new ObjectMapper();
		String key = request.getParameter("key");
		String val = request.getParameter("val");
		System.out.println(key);
		list = dao.commuteEmpSearchList(key,val);
		String jsonData = "";
		
		try {
			jsonData = mapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		
		return "ajax:"+ jsonData;
	}

}
