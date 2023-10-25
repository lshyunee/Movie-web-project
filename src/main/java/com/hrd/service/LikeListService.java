package com.hrd.service;

import java.util.List;

import com.hrd.domain.LikeListVO;

public interface LikeListService {
	public List<LikeListVO> getLikeList(String userid);
	public int find_Like(Long mno, String userid);
	public int findLike(LikeListVO vo);
	public void addLikeSelectKey(LikeListVO LikeList);
	public int removeLike(Long mno, String userid);
	public void addLike(Long mno, String userid);
}
