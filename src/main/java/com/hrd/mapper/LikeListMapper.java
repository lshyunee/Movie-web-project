package com.hrd.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hrd.domain.Criteria;
import com.hrd.domain.LikeListVO;

public interface LikeListMapper {
	public void addLike(LikeListVO vo);
	public void addLikeSelectKey(LikeListVO vo);

	public LikeListVO listLike(Long lno);
	
	public List<LikeListVO> getLikeList(String userid);

	public int removeLike(@Param("mno") Long mno, @Param("userid") String userid);

	public List<LikeListVO> getListWithPaging(
	@Param("cri") Criteria cri,
	@Param("lno") Long lno);
	
	public int find_like(@Param("mno") Long mno, @Param("userid") String userid);
	
	public int findLike(LikeListVO vo);
	
	public void addLike(@Param("mno") Long mno, @Param("userid") String userid);
}
