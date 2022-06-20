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
import freemarker.template.SimpleDate;

public class CommuteSelectDate implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		
		CommuteService dao = new CommuteImpl();
		List<CommuteVO> list = new ArrayList<CommuteVO>();
		HttpSession session = request.getSession();
		MemberVO vo = (MemberVO) session.getAttribute("memberVO");
		ObjectMapper mapper = new ObjectMapper();
		String key = request.getParameter("key");
		String val = request.getParameter("val");
		list = dao.commuteSearchList(key,val,String.valueOf(vo.getMember_num()));
		String jsonData = "";
		
		try {
			jsonData = mapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		return "ajax:"+ jsonData;
	}


}
