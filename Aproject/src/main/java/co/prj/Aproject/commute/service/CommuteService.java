package co.prj.Aproject.commute.service;
import java.util.List;


import co.prj.Aproject.commute.vo.CommuteVO;
import co.prj.Aproject.member.vo.MemberVO;

public interface CommuteService {

	
	List<CommuteVO> commuteSelectList(MemberVO vo);
	List<CommuteVO> commuteEmpSelectList(CommuteVO vo);
	List<CommuteVO> commuteSearchList(String key, String val, String member_num);
	List<CommuteVO> commuteEmpSearchList(String key,String val);
	CommuteVO commuteSelectDate(MemberVO vo);
	int commuteStartInsert(MemberVO vo);
	int commuteEndUpdate(MemberVO vo);

	
}
