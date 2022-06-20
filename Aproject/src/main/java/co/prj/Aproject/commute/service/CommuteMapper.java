package co.prj.Aproject.commute.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.prj.Aproject.commute.vo.CommuteVO;
import co.prj.Aproject.member.vo.MemberVO;

public interface CommuteMapper {

	
	List<CommuteVO> commuteSelectList(MemberVO vo);
	List<CommuteVO> commuteEmpSelectList(CommuteVO vo);
	List<CommuteVO> commuteSearchList(@Param("key")String key, @Param("val")String val,@Param("member_num") String member_num);
	List<CommuteVO> commuteEmpSearchList(@Param("key")String key, @Param("val")String val);
	CommuteVO commuteSelectDate(MemberVO vo);
	int commuteStartInsert(MemberVO vo);
	int commuteEndUpdate(MemberVO vo);
}
