package com.hrd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hrd.domain.Criteria;
import com.hrd.domain.MovieAttachVO;
import com.hrd.domain.MovieVO;
import com.hrd.mapper.MovieAttachMapper;
import com.hrd.mapper.MovieMapper;

@Service
public class MovieServiceImpl implements MovieService {

	@Autowired
	private MovieMapper mapper;
	
	@Autowired
	private MovieAttachMapper attachMapper;
	
	@Override
	public List<MovieVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}

	@Override
	public MovieVO info(Long mno) {
		return mapper.info(mno);
	}
	
	@Transactional
	@Override
	public void register(MovieVO movie) {
			mapper.insertSelectKey(movie);
			if(movie.getAttach() == null)
				return;
			
			movie.getAttach().setMno(movie.getMno());
			attachMapper.insert(movie.getAttach());
	}

	@Override
	public MovieAttachVO getAttach(Long mno) {
		return attachMapper.findByMno(mno);
	}
	
	@Override
	public int modify(MovieVO movie) {
		attachMapper.deleteAll(movie.getMno());
		int modifyResult = mapper.update(movie);
		if(modifyResult == 1 && movie.getAttach() != null) {
			movie.getAttach().setMno(movie.getMno());
			attachMapper.insert(movie.getAttach());
		}
		return modifyResult;
	}

	@Transactional
	@Override
	public int remove(Long mno) {
		mapper.delete2(mno);
		attachMapper.deleteAll(mno);
		return mapper.delete(mno);
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}
}
