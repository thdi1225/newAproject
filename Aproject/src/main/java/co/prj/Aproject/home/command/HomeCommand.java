package co.prj.Aproject.home.command;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.commute.Impl.CommuteImpl;
import co.prj.Aproject.commute.service.CommuteService;
import co.prj.Aproject.commute.vo.CommuteVO;
import co.prj.Aproject.member.vo.MemberVO;

public class HomeCommand implements Command {
	
	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		List<CommuteVO> list = new ArrayList<CommuteVO>();
		CommuteService dao = new CommuteImpl();
		HttpSession session = request.getSession();
		MemberVO vo = (MemberVO) session.getAttribute("memberVO");
		list = dao.commuteSelectList(vo);
		request.setAttribute("list", list);
		
		if(list.size() == 1) {
			request.setAttribute("cn", list.get(0).getCommute_num());
		}
		
		return "home/home";
	}

}
