package co.prj.Aproject.commute.Impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import co.prj.Aproject.comm.DataSource;
import co.prj.Aproject.commute.service.CommuteMapper;
import co.prj.Aproject.commute.service.CommuteService;
import co.prj.Aproject.commute.vo.CommuteVO;

public class CommuteImpl implements CommuteService{

	private SqlSession sqlSession = DataSource.getInstance().openSession(true);
	private CommuteMapper map = sqlSession.getMapper(CommuteMapper.class);
	
	@Override
	public List<CommuteVO> commuteSelectList() {
		return map.commuteSelectList();
	}


	@Override
	public int commuteStartInsert() {
		return map.commuteStartInsert();
	}

	@Override
	public int commuteEndInsert() {
		return map.commuteEndInsert();
	}


	@Override
	public CommuteVO commuteStartTimeSelect(CommuteVO vo) {
		
		return map.commuteStartTimeSelect(vo);
	}


	@Override
	public CommuteVO commuteEndTimeSelect(CommuteVO vo) {
		return map.commuteEndTimeSelect(vo);
	}


	
	
	
	
	
}
