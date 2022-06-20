package co.prj.Aproject.commute.Impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import co.prj.Aproject.comm.DataSource;
import co.prj.Aproject.commute.service.CommuteMapper;
import co.prj.Aproject.commute.service.CommuteService;
import co.prj.Aproject.commute.vo.CommuteVO;
import co.prj.Aproject.member.vo.MemberVO;

public class CommuteImpl implements CommuteService{

	private SqlSession sqlSession = DataSource.getInstance().openSession(true);
	private CommuteMapper map = sqlSession.getMapper(CommuteMapper.class);
	
	@Override
	public List<CommuteVO> commuteSelectList(MemberVO vo) {
		return map.commuteSelectList(vo);
	}

	@Override
	public List<CommuteVO> commuteEmpSelectList(CommuteVO vo) {
		return map.commuteEmpSelectList(vo);
	}
	
	@Override
	public List<CommuteVO> commuteEmpSearchList(String key, String val) {
		return map.commuteEmpSearchList(key, val);
	}
	
	@Override
	public List<CommuteVO> commuteSearchList(String key, String val,String member_num) {
		
		return map.commuteSearchList(key, val,member_num);
	}
	
	@Override
	public CommuteVO commuteSelectDate(MemberVO vo) {
		
		return map.commuteSelectDate(vo);
	}

	@Override
	public int commuteStartInsert(MemberVO vo) {
		return map.commuteStartInsert(vo);
	}

	@Override
	public int commuteEndUpdate(MemberVO vo) {
		return map.commuteEndUpdate(vo);
	}












	
	
	
	
	
}
