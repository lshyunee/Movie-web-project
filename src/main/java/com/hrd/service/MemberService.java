package com.hrd.service;

import java.util.List;

import com.hrd.domain.Criteria;
import com.hrd.domain.MemberVO;


public interface MemberService {
	public int idCheck(String userid);
	public int pwCheck(String userpw);
	public List<MemberVO> getList(Criteria cri);
	public int removeMember(String userid);
	public int modifyMember(MemberVO member);
	public int getTotal(Criteria cri);
	public MemberVO get(String userid);
}
