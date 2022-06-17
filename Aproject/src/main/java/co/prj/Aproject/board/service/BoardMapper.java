package co.prj.Aproject.board.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.prj.Aproject.board.vo.BoardVO;

public interface BoardMapper {
	List<BoardVO> boardSelectList(); // 전체조회 
	List<BoardVO> boardSearchList(@Param("key") String key, @Param("val") String val);
	BoardVO boardSelect(BoardVO vo);
	BoardVO boardDetail(int bno); 
	int boardInsert(BoardVO vo);
	int boardUpdate(BoardVO vo);
	int boardDelete(BoardVO vo);
	
	int boardHitUpdate(int id); // 조회수 증가
}
