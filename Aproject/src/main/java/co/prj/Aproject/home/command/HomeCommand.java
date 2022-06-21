package co.prj.Aproject.home.command;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.prj.Aproject.board.service.BoardService;
import co.prj.Aproject.board.serviceImpl.BoardServiceImpl;
import co.prj.Aproject.board.vo.BoardVO;
import co.prj.Aproject.comm.Command;
import co.prj.Aproject.commute.Impl.CommuteImpl;
import co.prj.Aproject.commute.service.CommuteService;
import co.prj.Aproject.commute.vo.CommuteVO;
import co.prj.Aproject.email.service.EmailService;
import co.prj.Aproject.email.serviceImpl.EmailServiceImpl;
import co.prj.Aproject.member.vo.MemberVO;

public class HomeCommand implements Command {
	
	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		//메일
		EmailService dao = new EmailServiceImpl();
		HttpSession session = request.getSession();
		MemberVO vo = (MemberVO) session.getAttribute("memberVO");
		int emailCnt = dao.emailCount(vo.getMember_num());
		request.setAttribute("emailCnt", emailCnt);

		//출퇴근 관리
		int ck = 0;
		List<CommuteVO> list = new ArrayList<CommuteVO>();
		CommuteService dao1 = new CommuteImpl();
		Date date = new Date(System.currentTimeMillis());
		SimpleDateFormat fm = new SimpleDateFormat("yy/MM/dd");
		list = dao1.commuteSelectList(vo);
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
			request.setAttribute("homeCk", ck);
		}
		if(list.size() == 1) {
			request.setAttribute("cn", list.get(0).getCommute_num());
		}

		//커뮤니티
		BoardService service = new BoardServiceImpl();
		List<BoardVO> boardList = service.boardSelectFive(); 
		
		request.setAttribute("boardList", boardList);
		
		return "home/home";
	}

}
