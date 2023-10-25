package com.hrd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hrd.domain.LikeListVO;
import com.hrd.mapper.LikeListMapper;

@Service
public class LikeListServiceImpl implements LikeListService {
	
	@Autowired
	private LikeListMapper mapper;

	@Override
	public List<LikeListVO> getLikeList(String userid) {
		return mapper.getLikeList(userid);
	}

	@Override
	public int find_Like(Long mno, String userid) {
		int findResult = mapper.find_like(mno, userid);
		return findResult;
	}

	@Override
	public void addLikeSelectKey(LikeListVO LikeList) {
		mapper.addLikeSelectKey(LikeList);
		
	}

	@Override
	public int removeLike(Long mno, String userid) {
		return mapper.removeLike(mno, userid);
	}

	@Override
	public void addLike(Long mno, String userid) {
		mapper.addLike(mno, userid);
		
	}

	@Override
	public int findLike(LikeListVO vo) {
		return mapper.findLike(vo);
	}

}
