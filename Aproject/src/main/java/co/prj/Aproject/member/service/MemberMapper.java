package co.prj.Aproject.member.service;

import java.util.List;

import co.prj.Aproject.member.vo.MemberVO;

public interface MemberMapper {
	public MemberVO login(MemberVO vo);
	
	public List<MemberVO> memberSelectList();
	
	public MemberVO memberSelect(MemberVO vo);
	
	public void memberInsert(MemberVO vo);
	
	public void memberUpdate(MemberVO vo);
	
	public void memberDelete(MemberVO vo);

	public List<MemberVO> memberYnSelectList();

	public void memberYnUpdate(MemberVO vo);
}
