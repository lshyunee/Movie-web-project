package com.hrd.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hrd.domain.LikeListVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class LikeListMapperTests {
	
	@Autowired
	private LikeListMapper mapper;
	
	@Test // 테스트를 하기 위한 메소드라는 표시
	public void testGetLikeList() {
		log.info("---------------------");
		mapper.getLikeList("bear");
	}
	
	@Test //
	public void testGetLikeList2() {
		log.info("---------------------");
		mapper.getLikeList("bear");
	}
	
	@Test
	public void test() {
		log.info("===========");
		log.info(mapper);
	}
	
	@Test
	public void testInsertSelect() {
		LikeListVO vo = new LikeListVO();
		vo.setUserid("bear");
		vo.setMno(25L);
		mapper.addLikeSelectKey(vo);
		log.info("==after insertSelect:" + vo.getLno());
	}
	
	@Test
	public void testDelete() {
		int count = mapper.removeLike(24L, "bear"); //long형이니까 뒤에 L
		log.info("=============" + count);
	}
	
	@Test
	public void test22() {
		int find = mapper.find_like(24L, "bear");
		log.info("================" + find);
	}
	
	@Test
	public void test222() {
		LikeListVO vo = new LikeListVO();
		vo.setUserid("bear");
		vo.setMno(24L);
		int find = mapper.findLike(vo);
		log.info("================" + find);
	}
	
}
