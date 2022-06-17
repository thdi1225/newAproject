package co.prj.Aproject.email.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import co.prj.Aproject.comm.DataSource;
import co.prj.Aproject.email.service.EmailMapper;
import co.prj.Aproject.email.service.EmailService;
import co.prj.Aproject.email.vo.EmailVO;

public class EmailServiceImpl implements EmailService {
	private SqlSession sqlSession = DataSource.getInstance().openSession(true);
	private EmailMapper map = sqlSession.getMapper(EmailMapper.class);

	@Override
	public int emailInsert(EmailVO vo) {
		return map.emailInsert(vo);
	}

	@Override
	public int emailDelete(EmailVO vo) {
		return map.emailDelete(vo);
	}

	@Override
	public List<EmailVO> emailSelectListAll(int memeberNum,int sent) {
		return map.emailSelectListAll(memeberNum,sent);
	}

	@Override
	public EmailVO emailSelectOne(EmailVO vo) {
		return map.emailSelectOne(vo);
	}

	

}
