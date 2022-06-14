package co.prj.Aproject.board.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import co.prj.Aproject.board.service.BoardMapper;
import co.prj.Aproject.board.service.BoardService;
import co.prj.Aproject.board.vo.BoardVO;
import co.prj.Aproject.comm.DataSource;

public class BoardServiceImpl implements BoardService {
	private SqlSession sqlSession = DataSource.getInstance().openSession(true);
	private BoardMapper map = sqlSession.getMapper(BoardMapper.class);

	@Override
	public List<BoardVO> boardSelectList() {
		// TODO Auto-generated method stub
		return map.boardSelectList();
	}

	@Override
	public List<BoardVO> boardSearchList(String key, String val) {
		// TODO Auto-generated method stub
		return map.boardSearchList(key, val);
	}

	@Override
	public BoardVO boardSelect(BoardVO vo) {
		// TODO Auto-generated method stub
		return map.boardSelect(vo);
	}

	@Override
	public BoardVO boardDetail(int bno) {
		// TODO Auto-generated method stub
		return map.boardDetail(bno);
	}

	@Override
	public int boardInsert(BoardVO vo) {
		// TODO Auto-generated method stub
		return map.boardInsert(vo);
	}

	@Override
	public int boardUpdate(BoardVO vo) {
		// TODO Auto-generated method stub
		return map.boardUpdate(vo);
	}

	@Override
	public int boardDelete(BoardVO vo) {
		// TODO Auto-generated method stub
		return map.boardDelete(vo);
	}

	@Override
	public int boardHitUpdate(int id) {
		// TODO Auto-generated method stub
		return map.boardHitUpdate(id);
	}

}
