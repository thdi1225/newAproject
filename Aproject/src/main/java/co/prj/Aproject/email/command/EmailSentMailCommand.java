package co.prj.Aproject.email.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.email.service.EmailService;
import co.prj.Aproject.email.serviceImpl.EmailServiceImpl;
import co.prj.Aproject.email.vo.EmailPage;
import co.prj.Aproject.email.vo.EmailVO;
import co.prj.Aproject.member.vo.MemberVO;

public class EmailSentMailCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		EmailService dao = new EmailServiceImpl();
//		String type = request.getParameter("type");
		HttpSession session = request.getSession();
		
		MemberVO member = (MemberVO) session.getAttribute("memberVO");
		int memberNum = member.getMember_num();
		String memberMailEmail = member.getMember_mail_email();
		String memberMailPw = member.getMember_mail_pw();

		String page;
		if(memberMailEmail != null && memberMailPw != null) {
			//보낸 메일 db에서 가져오기
			String nowPage = request.getParameter("nowPage");
			String cntPerPage = request.getParameter("cntPerPage");
			
			if (nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "5";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if (cntPerPage == null) { 
				cntPerPage = "5";
			}
			
			EmailPage paging = new EmailPage();
			
			paging.setSearch(request.getParameter("search"));
			paging.setMemberNum(memberNum);
			paging.setSent(1);
			
			int totalCount = dao.emailSelectListAllCount(paging);
			
			paging = new EmailPage(totalCount, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage), request.getParameter("search"), memberNum, 1);
			List<EmailVO> emails = dao.emailSelectListAll(paging);
			if(emails.size()!=0) {
				request.setAttribute("emails", emails);
				request.setAttribute("paging", paging);
				page = "email/emailSentMail";
			}else {
				page = "email/emailEmpty";
			}
		}else {
			page = "email/emailLogin";
			
		}

		return page;
	}

}
