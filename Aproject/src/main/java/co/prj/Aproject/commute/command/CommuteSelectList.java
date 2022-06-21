package co.prj.Aproject.commute.command;

import java.sql.Date;
import java.text.SimpleDateFormat;
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
		
		int ck = 0;
		List<CommuteVO> list = new ArrayList<CommuteVO>();
		CommuteService dao = new CommuteImpl();
		HttpSession session = request.getSession();
		MemberVO vo = (MemberVO) session.getAttribute("memberVO");
		Date date = new Date(System.currentTimeMillis());
		SimpleDateFormat fm = new SimpleDateFormat("yy/MM/dd");
		list = dao.commuteSelectList(vo);
		request.setAttribute("list", list);
		
		for(CommuteVO commutevo : list) {
			if(fm.format(commutevo.getCommute_date()).equals(fm.format(date))) {
				ck = 1;
			}
			else {
				ck = 0;
			}
		}
		
		if(ck == 1) {
			request.setAttribute("todayCheck", ck);
		}
		
		if(list.size() == 1) {
			request.setAttribute("v", list.get(0).getCommute_num());
		}

		
		return "commute/commute";
	}

}
