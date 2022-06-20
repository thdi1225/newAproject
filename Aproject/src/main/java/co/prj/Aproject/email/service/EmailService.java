package co.prj.Aproject.email.service;

import java.util.List;

import co.prj.Aproject.email.vo.EmailPage;
import co.prj.Aproject.email.vo.EmailVO;
import co.prj.Aproject.member.vo.MemberVO;

public interface EmailService {
//	List<EmailVO> emailSelectListAll(int memeberNum, int sent);
	EmailVO emailSelectOne(EmailVO vo);
	List<EmailVO> emailSelectFive(int memberNum);
	int emailCount(int memberNum);
	
	int emailInfoUpdate(MemberVO vo);
	int emailInsert(EmailVO vo);
	int emailDelete(EmailVO vo);
	List<EmailVO> emailSelectListAll(EmailPage paging);

	int emailSelectListAllCount(EmailPage paging);
}
