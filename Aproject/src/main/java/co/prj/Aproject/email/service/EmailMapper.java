package co.prj.Aproject.email.service;

import java.util.List;

import co.prj.Aproject.email.vo.EmailVO;

public interface EmailMapper {
	List<EmailVO> emailSelectListAll(int memeberNum);
		
	int emailInsert(EmailVO vo);
	int emailDelete(EmailVO vo);
}
