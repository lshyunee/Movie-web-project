package com.hrd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hrd.domain.Criteria;
import com.hrd.domain.ReplyDTO;
import com.hrd.domain.ReplyVO;
import com.hrd.mapper.ReplyMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService{
	@Autowired
	private ReplyMapper mapper;
	
	@Override
	public int register(ReplyVO vo) {
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno) {
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long mno) {
		return mapper.getListWithPaging(cri, mno);
	}

	@Override
	public ReplyDTO getListPage(Criteria cri, Long mno) {
		return new ReplyDTO(
				 mapper.getCountByMno(mno),
				 mapper.getListWithPaging(cri, mno));
	}
}