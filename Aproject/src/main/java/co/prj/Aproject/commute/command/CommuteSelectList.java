package co.prj.Aproject.commute.command;

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

public class CommuteSelectList implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		

		List<CommuteVO> list = new ArrayList<CommuteVO>();
		CommuteService dao = new CommuteImpl();
		HttpSession session = request.getSession();
		MemberVO vo = (MemberVO) session.getAttribute("memberVO");
		list = dao.commuteSelectList(vo);
//		System.out.println(vo.toString());
		request.setAttribute("list", list);
		
		return "commute/commute";
	}

}
