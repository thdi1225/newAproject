package co.prj.Aproject.commute.command;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.commute.Impl.CommuteImpl;
import co.prj.Aproject.commute.service.CommuteService;
import co.prj.Aproject.commute.vo.CommuteVO;
import co.prj.Aproject.member.vo.MemberVO;

public class CommuteStartInsert implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		int check = 0;
		CommuteService dao = new CommuteImpl();
		HttpSession session = request.getSession();
		MemberVO vo = (MemberVO) session.getAttribute("memberVO");
		Date date = new Date(System.currentTimeMillis());
		SimpleDateFormat fm = new SimpleDateFormat("yy/MM/dd");
		List<CommuteVO> list = dao.commuteSelectList(vo);
		for(CommuteVO commuteVO : list) {
			if(fm.format(commuteVO.getCommute_date()).equals(fm.format(date))) {
				check = 1;
				
			}else {
				check = 0;
			}
		}
		if(check == 0) {
			dao.commuteStartInsert(vo);
		}
		request.setAttribute("list", list);
		request.setAttribute("checkInt", check);
		
		return "ajax:"+check;
	}

}
