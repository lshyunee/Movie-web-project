package com.hrd.persistence;

import java.sql.Connection;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class) // 현재 우리가 만들고 있는 코드가 스프링 실행하는 역할을 할 것이라는 표식
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml") // 우리가 필요한 객체들을 스프링의 객체(bean)로 등록할 것이라는 것
@Log4j // 목록을 사용해서 로그 기록
public class DataSourceTests {
	@Autowired
	private DataSource ds;
	
	@Autowired
	private SqlSessionFactory sessionFactory;
	
	@Test
	public void testConnection() {
		try (Connection con = ds.getConnection()) {
			log.info("========================" +con);
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}
	
	@Test
	public void testConnection2() {
		try (SqlSession session = sessionFactory.openSession();
				Connection con = ds.getConnection()) {
			log.info(sessionFactory);
			log.info(con);
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}
}
