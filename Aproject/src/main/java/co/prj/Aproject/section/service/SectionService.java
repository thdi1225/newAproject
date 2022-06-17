package co.prj.Aproject.section.service;

import java.util.List;

import co.prj.Aproject.section.vo.SectionPage;
import co.prj.Aproject.section.vo.SectionVO;

public interface SectionService {
	public List<SectionVO> sectionSelectList(SectionPage page);
	
	public SectionVO sectionSelect(SectionVO vo);
	
	public void sectionInsert(SectionVO vo);
	
	public void sectionUpdate(SectionVO vo);
	
	public int sectionDelete(SectionVO vo);

	public int sectionSelectListCount(SectionPage page);

}
