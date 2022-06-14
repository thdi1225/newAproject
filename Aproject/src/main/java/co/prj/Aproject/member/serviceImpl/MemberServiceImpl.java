package co.prj.Aproject.member.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import co.prj.Aproject.comm.DataSource;
import co.prj.Aproject.member.service.MemberMapper;
import co.prj.Aproject.member.service.MemberService;
import co.prj.Aproject.member.vo.MemberVO;

public class MemberServiceImpl implements MemberService{
	private SqlSession sqlSession = DataSource.getInstance().openSession(true);
	private MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);

	//로그인 기능
	@Override
	public MemberVO login(MemberVO vo) {
		return mapper.login(vo);
	}

	//목록조회
	@Override
	public List<MemberVO> memberSelectList() {
		return mapper.memberSelectList();
	}

	//단건조회
	@Override
	public MemberVO memberSelect(MemberVO vo) {
		return mapper.memberSelect(vo);
	}

	//회원등록
	@Override
	public void memberInsert(MemberVO vo) {
		mapper.memberInsert(vo);
	}

	//회원수정
	@Override
	public void memberUpdate(MemberVO vo) {
		
	}

	//회원삭제
	@Override
	public void memberDelete(MemberVO vo) {
		
	}

	@Override
	public List<MemberVO> memberYnSelectList() {
		return mapper.memberYnSelectList();
	}

	@Override
	public void memberYnUpdate(MemberVO vo) {
		mapper.memberYnUpdate(vo);
	}

}
