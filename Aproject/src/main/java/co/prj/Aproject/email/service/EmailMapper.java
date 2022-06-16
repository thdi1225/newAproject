package co.prj.Aproject.email.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.prj.Aproject.email.vo.EmailVO;

public interface EmailMapper {
	//sent = 0 : 남들한테 받은거, 1 : 나한테 받은거
	List<EmailVO> emailSelectListAll(@Param("memberNum") int memeberNum,@Param("sent") int sent);
	EmailVO emailSelectOne(EmailVO vo);
		
	int emailInsert(EmailVO vo);
	int emailDelete(EmailVO vo);
}
