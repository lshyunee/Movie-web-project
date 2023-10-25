package com.hrd.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hrd.domain.Criteria;
import com.hrd.domain.ReplyVO;

public interface ReplyMapper {
	public int insert(ReplyVO vo);
	
	public ReplyVO read(Long rno);
	
	public int delete (Long rno);
	
	public int update(ReplyVO reply);
	
	public List<ReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("mno") Long mno);
	
	public int getCountByMno(Long mno);
	
}