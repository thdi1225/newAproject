package co.prj.Aproject.email.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.email.service.EmailService;
import co.prj.Aproject.email.serviceImpl.EmailServiceImpl;
import co.prj.Aproject.email.vo.EmailVO;
import co.prj.Aproject.member.vo.MemberVO;

public class EmailSelectFiveCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		ObjectMapper map = new ObjectMapper();
		EmailService dao = new EmailServiceImpl();
		HttpSession session = request.getSession();
		MemberVO vo = (MemberVO) session.getAttribute("memberVO");
		
		List<EmailVO> emailList = dao.emailSelectFive(vo.getMember_num());
		
		String jsonData = "";
		try {
			jsonData= map.writeValueAsString(emailList);
			
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		return "ajax:"+jsonData;
	}

}
