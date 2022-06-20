package co.prj.Aproject.member.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import co.prj.Aproject.comm.DataSource;
import co.prj.Aproject.member.service.MemberMapper;
import co.prj.Aproject.member.service.MemberService;
import co.prj.Aproject.member.vo.MemberPage;
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
	public List<MemberVO> memberSelectList(MemberPage page) {
		return mapper.memberSelectList(page);
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
		mapper.memberUpdate(vo);
	}

	//회원삭제
	@Override
	public int memberDelete(MemberVO vo) {
		return mapper.memberDelete(vo);
	}

	@Override
	public List<MemberVO> memberYnSelectList(MemberPage page) {
		return mapper.memberYnSelectList(page);
	}

	@Override
	public int memberYnSelectListCount(MemberPage page) {
		return mapper.memberYnSelectListCount(page);
	}
	
	@Override
	public void memberYnUpdate(MemberVO vo) {
		mapper.memberYnUpdate(vo);
	}

	@Override
	public int memberPwReset(MemberVO vo) {
		return mapper.memberPwReset(vo);
	}

	@Override
	public int memberAdminInput(MemberVO vo) {
		return mapper.memberAdminInput(vo);
	}

	@Override
	public int memberSelectListCount(MemberPage page) {
		return mapper.memberSelectListCount(page);
	}

	@Override
	public void memberMyPage(MemberVO vo) {
		mapper.memberMyPage(vo);
	}

}
