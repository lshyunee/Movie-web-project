package com.hrd.service;

import java.util.List;

import com.hrd.domain.Criteria;
import com.hrd.domain.ReplyDTO;
import com.hrd.domain.ReplyVO;

public interface ReplyService {
	public int register(ReplyVO vo);
	
	public ReplyVO get(Long rno);
	
	public int modify(ReplyVO vo);
	
	public int remove(Long rno);
	
	public List<ReplyVO> getList(Criteria cri, Long mno);
	
	public ReplyDTO getListPage(Criteria cri, Long mno);
}