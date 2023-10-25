package com.hrd.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hrd.domain.Criteria;
import com.hrd.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberMapperTests {
	
	@Autowired
	private MemberMapper mapper;
	
	@Test
	public void memberIdChk() throws Exception{
		String id = "bear";	// 존재하는 아이디
		String id2 = "test123";	// 존재하지 않는 아이디
		mapper.idCheck(id);
		mapper.idCheck(id2);
	}
	
	@Test
	public void memberPwChk() throws Exception{
		String pw = "jhj";	// 비밀번호
		String pw2 = "jhj";	// 비교 비밀번호
		mapper.idCheck(pw);
		mapper.idCheck(pw2);
	}

	@Test
	public void getList() {
		log.info("===========");
		mapper.getList();
	}
	
	@Test
	public void testPaging() {
		log.info("---------------------");
		mapper.getListWithPaging(new Criteria());
	}
	
	@Test
	public void testSearch() {
		log.info("---------------------");
		Criteria cri = new Criteria();
		cri.setKeyword("bear");
		cri.setType("I");
		mapper.getListWithPaging(cri);
	}
	
	@Test
	public void testUpdate() {
		MemberVO member = mapper.read("bear");
		member.setUserName("bear");
		member.setUserpw("tt");
		int count = mapper.updateMember(member);
		log.info("=============" + count);
	}
}
