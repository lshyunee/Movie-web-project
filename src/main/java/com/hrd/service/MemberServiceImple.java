package com.hrd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hrd.domain.Criteria;
import com.hrd.domain.MemberVO;
import com.hrd.mapper.MemberMapper;

@Service
public class MemberServiceImple implements MemberService {

	@Autowired
	private MemberMapper mapper;
	
	@Override
	public int idCheck(String userid) {
		int result = mapper.idCheck(userid);
		System.out.println("result: " + result);
		return result;
	}

	@Override
	public List<MemberVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}

	@Transactional
	@Override
	public int removeMember(String userid) {
		mapper.deleteAuth(userid);
		return mapper.deleteMember(userid);
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public int modifyMember(MemberVO member) {
		return mapper.updateMember(member);
	}

	@Override
	public MemberVO get(String userid) {
		return mapper.read(userid);
	}

	@Override
	public int pwCheck(String userpw) {
		int result = mapper.pwCheck(userpw);
		System.out.println("result: " + result);
		return result;
	}


}
