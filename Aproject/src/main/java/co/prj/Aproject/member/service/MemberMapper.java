package co.prj.Aproject.member.service;

import java.util.List;

import co.prj.Aproject.member.vo.MemberPage;
import co.prj.Aproject.member.vo.MemberVO;

public interface MemberMapper {
	public MemberVO login(MemberVO vo);
	
	public List<MemberVO> memberSelectList(MemberPage page);
	
	public MemberVO memberSelect(MemberVO vo);
	
	public void memberInsert(MemberVO vo);
	
	public void memberUpdate(MemberVO vo);
	
	public int memberDelete(MemberVO vo);

	public List<MemberVO> memberYnSelectList(MemberPage page);

	public void memberYnUpdate(MemberVO vo);

	public int memberPwReset(MemberVO vo);

	public int memberAdminInput(MemberVO vo);

	public int memberSelectListCount(MemberPage page);

	public void memberMyPage(MemberVO vo);

	public int memberYnSelectListCount(MemberPage page);
}
