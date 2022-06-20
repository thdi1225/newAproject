package co.prj.Aproject.email.service;

import java.util.List;

import co.prj.Aproject.email.vo.EmailPage;
import co.prj.Aproject.email.vo.EmailVO;
import co.prj.Aproject.member.vo.MemberVO;

public interface EmailMapper {
	//sent = 0 : 남들한테 받은거, 1 : 나한테 받은거
//	List<EmailVO> emailSelectListAll(@Param("memberNum") int memeberNum,@Param("sent") int sent);
	EmailVO emailSelectOne(EmailVO vo);
	List<EmailVO> emailSelectFive(int memberNum);
	int emailCount(int memberNum);
	
	int emailInfoUpdate(MemberVO vo);
	int emailInsert(EmailVO vo);
	int emailDelete(EmailVO vo);
	List<EmailVO> emailSelectListAll(EmailPage paging);

	int emailSelectListAllCount(EmailPage paging);
	
}
