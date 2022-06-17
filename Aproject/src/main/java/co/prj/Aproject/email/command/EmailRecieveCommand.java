package co.prj.Aproject.email.command;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.email.service.EmailFunc;
import co.prj.Aproject.email.service.EmailService;
import co.prj.Aproject.email.serviceImpl.EmailServiceImpl;
import co.prj.Aproject.email.vo.EmailVO;

public class EmailRecieveCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		EmailFunc f = new EmailFunc();
		EmailService dao = new EmailServiceImpl();
		
		//추후에 백그라운드에서 계속 반복되게 바꿀 것
		f.saveEmailsInDB();
		
		//기본 동작
		List<EmailVO> emails = dao.emailSelectListAll();
		request.setAttribute("emails", emails);
		//Date형식 변경
		SimpleDateFormat date = new SimpleDateFormat();
		
		return "email/emailRecieve";
	}

}
