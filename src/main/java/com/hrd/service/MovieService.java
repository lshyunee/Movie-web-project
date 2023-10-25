package com.hrd.service;

import java.util.List;

import com.hrd.domain.Criteria;
import com.hrd.domain.MovieAttachVO;
import com.hrd.domain.MovieVO;

public interface MovieService {
	public List<MovieVO> getList(Criteria cri);
	public MovieVO info(Long mno);
	public void register(MovieVO movie);
	public MovieAttachVO getAttach(Long mno);
	public int modify(MovieVO movie);
	public int remove(Long mno);
	public int getTotal(Criteria cri);
	
}
