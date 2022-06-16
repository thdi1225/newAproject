package co.prj.Aproject.email.service;

import java.util.List;

import co.prj.Aproject.email.vo.EmailVO;

public interface EmailService {
	List<EmailVO> emailSelectListAll(int memeberNum, int sent);
	EmailVO emailSelectOne(EmailVO vo);
	
	int emailInsert(EmailVO vo);
	int emailDelete(EmailVO vo);
}
