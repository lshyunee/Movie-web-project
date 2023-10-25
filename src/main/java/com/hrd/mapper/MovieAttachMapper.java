package com.hrd.mapper;

import com.hrd.domain.MovieAttachVO;

public interface MovieAttachMapper {
	public void insert(MovieAttachVO vo);
	public void delete(String uuid);
	public MovieAttachVO findByMno(Long mno);
	public void deleteAll(Long mno);
}
