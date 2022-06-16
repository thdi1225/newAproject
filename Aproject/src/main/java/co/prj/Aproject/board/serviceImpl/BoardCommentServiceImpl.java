package co.prj.Aproject.board.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import co.prj.Aproject.board.service.CommentMapper;
import co.prj.Aproject.board.service.CommentService;
import co.prj.Aproject.board.vo.CommentVO;
import co.prj.Aproject.comm.DataSource;

public class BoardCommentServiceImpl implements CommentService {
	private SqlSession sqlSession = DataSource.getInstance().openSession(true);
	private CommentMapper map = sqlSession.getMapper(CommentMapper.class);

	@Override
	public List<CommentVO> boardCommentSelect(CommentVO vo) {
		
		return map.boardCommentSelect(vo);
	}

	@Override
	public int boardCommentInsert(CommentVO vo) {
		System.out.println(vo.toString());
		return map.boardCommentInsert(vo);
	}

	@Override
	public int boardCommentUpdate(CommentVO vo) {
		
		return map.boardCommentUpdate(vo);
	}

	@Override
	public int boardCommentDelete(CommentVO vo) {
		
		return map.boardCommentDelete(vo);
	}

}
