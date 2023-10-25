package com.hrd.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hrd.domain.Criteria;
import com.hrd.domain.MovieVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MovieMapperTests {
	
	@Autowired
	private MovieMapper mapper;
	
	@Test
	public void getList() {
		log.info("===========");
		mapper.getList();
	}
	
	@Test
	public void info() {
		MovieVO vo = mapper.info(21L);
		log.info("=======" + vo);
	}
	
	@Test
	public void testSearch() {
		log.info("---------------------");
		Criteria cri = new Criteria();
		cri.setKeyword("아바타");
		cri.setType("T");
		mapper.getListWithPaging(cri);
	}
	
}
