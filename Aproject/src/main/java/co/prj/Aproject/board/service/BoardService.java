package co.prj.Aproject.board.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.prj.Aproject.board.vo.BoardPage;
import co.prj.Aproject.board.vo.BoardVO;

public interface BoardService {
	List<BoardVO> boardSelectList(BoardPage page); // 전체조회 
	List<BoardVO> boardSearchList(@Param("key") String key, @Param("val") String val);
	List<BoardVO> boardSelectFive();
	BoardVO boardSelect(BoardVO vo);
	BoardVO boardDetail(BoardVO vo); 
	int boardInsert(BoardVO vo);
	int boardUpdate(BoardVO vo);
	int boardDelete(BoardVO vo);
	
	int boardHitUpdate(BoardVO vo); // 조회수 증가
	int boardListCount(BoardPage page); // 리스트전체개수

}