package co.prj.Aproject.board.service;

import java.util.List;

import co.prj.Aproject.board.vo.BoardVO;
import co.prj.Aproject.board.vo.CommentVO;

public interface CommentMapper {
	List<CommentVO> boardCommentSelect(CommentVO vo); 
	int boardCommentInsert(CommentVO vo);
	int boardCommentUpdate(CommentVO vo);
	int boardCommentDelete(CommentVO vo);
}
