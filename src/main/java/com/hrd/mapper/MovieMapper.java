package com.hrd.mapper;

import java.util.List;

import com.hrd.domain.Criteria;
import com.hrd.domain.MovieVO;

public interface MovieMapper {
	public List<MovieVO> getList();
	public List<MovieVO> getListWithPaging(Criteria cri);
	public MovieVO info(Long mno);
	public void insert(MovieVO movie);
	public void insertSelectKey(MovieVO movie);
	public int delete(Long mno);
	public int delete2(Long mno);
	public int update(MovieVO movie);
	public int getTotalCount(Criteria cri);
	public int getLikeTotalCount(Criteria cri);
}
