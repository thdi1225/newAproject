package co.prj.Aproject.section.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import co.prj.Aproject.comm.DataSource;
import co.prj.Aproject.section.service.SectionMapper;
import co.prj.Aproject.section.service.SectionService;
import co.prj.Aproject.section.vo.SectionPage;
import co.prj.Aproject.section.vo.SectionVO;

public class SectionServiceImpl implements SectionService{
	private SqlSession sqlSession = DataSource.getInstance().openSession(true);
	private SectionMapper mapper = sqlSession.getMapper(SectionMapper.class);

	@Override
	public List<SectionVO> sectionSelectList(SectionPage page) {
		return mapper.sectionSelectList(page);
	}

	@Override
	public SectionVO sectionSelect(SectionVO vo) {
		return mapper.sectionSelect(vo);
	}

	@Override
	public void sectionInsert(SectionVO vo) {
		mapper.sectionInsert(vo);
	}

	@Override
	public void sectionUpdate(SectionVO vo) {
		mapper.sectionUpdate(vo);
	}

	@Override
	public int sectionDelete(SectionVO vo) {
		return mapper.sectionDelete(vo);
	}

	@Override
	public int sectionSelectListCount(SectionPage page) {
		return mapper.sectionSelectListCount(page);
	}

}
