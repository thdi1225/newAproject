package co.prj.Aproject.home.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.prj.Aproject.board.service.BoardService;
import co.prj.Aproject.board.serviceImpl.BoardServiceImpl;
import co.prj.Aproject.board.vo.BoardVO;
import co.prj.Aproject.comm.Command;
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
		
		//커뮤니티
		BoardService service = new BoardServiceImpl();
		HttpSession ses = request.getSession();
		List<BoardVO> boardList = service.boardSelectFive(); 
		
		request.setAttribute("boardList", boardList);
		
		return "home/home";
	}

}
