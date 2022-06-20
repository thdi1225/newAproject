package co.prj.Aproject.board.service;

import java.util.List;

import co.prj.Aproject.board.vo.ReplyVO;

public interface ReplyService {
	List<ReplyVO> boardReplySelect(ReplyVO vo); 
	int boardReplyInsert(ReplyVO vo);
	int boardReplyUpdate(ReplyVO vo);
	int boardReplyDelete(ReplyVO vo);
}
