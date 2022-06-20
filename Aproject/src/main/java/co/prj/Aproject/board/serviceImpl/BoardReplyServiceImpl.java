package co.prj.Aproject.board.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import co.prj.Aproject.board.service.ReplyMapper;
import co.prj.Aproject.board.service.ReplyService;
import co.prj.Aproject.board.vo.ReplyVO;
import co.prj.Aproject.comm.DataSource;

public class BoardReplyServiceImpl implements ReplyService {
	private SqlSession sqlSession = DataSource.getInstance().openSession(true);
	private ReplyMapper map = sqlSession.getMapper(ReplyMapper.class);

	@Override
	public List<ReplyVO> boardReplySelect(ReplyVO vo) {
		
		return map.boardReplySelect(vo);
	}

	@Override
	public int boardReplyInsert(ReplyVO vo) {
		System.out.println(vo.toString());
		return map.boardReplyInsert(vo);
	}

	@Override
	public int boardReplyUpdate(ReplyVO vo) {
		
		return map.boardReplyUpdate(vo);
	}

	@Override
	public int boardReplyDelete(ReplyVO vo) {
		
		return map.boardReplyDelete(vo);
	}

}
