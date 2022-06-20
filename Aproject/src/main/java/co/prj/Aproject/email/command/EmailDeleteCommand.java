package co.prj.Aproject.email.command;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.email.service.EmailImapRecieve;
import co.prj.Aproject.email.service.EmailService;
import co.prj.Aproject.email.serviceImpl.EmailServiceImpl;
import co.prj.Aproject.email.vo.EmailVO;
import co.prj.Aproject.member.vo.MemberVO;

public class EmailDeleteCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("memberVO");
		int memberNum = member.getMember_num();
		String user = member.getMember_mail_email();
		String password = member.getMember_mail_pw();
		
		EmailService dao = new EmailServiceImpl();
		EmailImapRecieve eir = new EmailImapRecieve();
		List<Integer> idList = new ArrayList<Integer>();
		
		String emailId = request.getParameter("emailId");
		String toFrom = request.getParameter("toFrom");
		System.out.println(emailId);
		System.out.println(toFrom);
		if(emailId != null) {
			if(emailId.startsWith("[")) {
				emailId = emailId.replace('[', ' ');
				emailId = emailId.replace(']', ' ');
				emailId = emailId.replace('"', ' ');
				emailId = emailId.replace(" ", "");
				String[] emailIdList = emailId.split(",");
				for(int i = 0; i<emailIdList.length;i++) {
					idList.add(Integer.parseInt(emailIdList[i]));
				}
					
			}else { //값 하나만 들어올 때
				idList.add(Integer.parseInt(emailId));
			}
			
			if(toFrom.equals("to")) {//나한테 온 메일함이면 gmail에서도 지우기
				eir.getMailAll(3, idList,memberNum,user,password);				
			}
		}
		//db에서 삭제
		EmailVO vo = new EmailVO();
		vo.setMemberNum(memberNum);
		
		for(int id : idList) {
			vo.setEmailId(id);
			if(!toFrom.equals("to")) {
				vo.setEmailTo("fromMe");
			}
			dao.emailDelete(vo);
			System.out.println("db 삭제 완료");
		}
		
		return "ajax:true";
	}

}
