package co.prj.Aproject.board.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import co.prj.Aproject.board.service.BoardMapper;
import co.prj.Aproject.board.service.BoardService;
import co.prj.Aproject.board.vo.BoardPage;
import co.prj.Aproject.board.vo.BoardVO;
import co.prj.Aproject.comm.DataSource;

public class BoardServiceImpl implements BoardService {
	private SqlSession sqlSession = DataSource.getInstance().openSession(true);
	private BoardMapper map = sqlSession.getMapper(BoardMapper.class);

	@Override
	public List<BoardVO> boardSelectList(BoardPage page) {
		return map.boardSelectList(page);
	}

	@Override
	public List<BoardVO> boardSearchList(String key, String val) {
		return map.boardSearchList(key, val);
	}

	@Override
	public BoardVO boardSelect(BoardVO vo) {
		return map.boardSelect(vo);
	}

	@Override
	public BoardVO boardDetail(BoardVO vo) {
		return map.boardDetail(vo);
	}

	@Override
	public int boardInsert(BoardVO vo) {
		return map.boardInsert(vo);
	}

	@Override
	public int boardUpdate(BoardVO vo) {
		return map.boardUpdate(vo);
	}

	@Override
	public int boardDelete(BoardVO vo) {
		return map.boardDelete(vo);
	}

	@Override
	public int boardHitUpdate(BoardVO vo) {
		return map.boardHitUpdate(vo);
	}

	@Override
	public int boardListCount(BoardPage page) {
		return map.boardListCount(page);
	}

	@Override
	public List<BoardVO> boardSelectFive() {
		
		return map.boardSelectFive();
	}

}