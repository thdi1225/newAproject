package co.prj.Aproject.commute.service;

import java.util.List;

import co.prj.Aproject.commute.vo.CommuteVO;

public interface CommuteMapper {

	
	List<CommuteVO> commuteSelectList();
	CommuteVO commuteStartTimeSelect( CommuteVO vo);
	CommuteVO commuteEndTimeSelect(CommuteVO vo);
	int commuteStartInsert();
	int commuteEndInsert();
}
