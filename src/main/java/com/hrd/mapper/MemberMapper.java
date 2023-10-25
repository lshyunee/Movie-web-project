package com.hrd.mapper;

import java.util.List;

import com.hrd.domain.AuthVO;
import com.hrd.domain.Criteria;
import com.hrd.domain.MemberVO;

public interface MemberMapper {
	public MemberVO read(String userid);
	public void joinMember(MemberVO member);
	public void checkAuthority(AuthVO auth);
	public int idCheck(String userid);
	public int pwCheck(String userpw);
	public List<MemberVO> getList();
	public List<MemberVO> getListWithPaging(Criteria cri);
	public int deleteMember(String userid);
	public int deleteAuth(String userid);
	public int updateMember(MemberVO member);
	public int getTotalCount(Criteria cri);
}
