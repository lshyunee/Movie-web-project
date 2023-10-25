package com.hrd.persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class) // 현재 우리가 만들고 있는 코드가 스프링 실행하는 역할을 할 것이라는 표식
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml") // 우리가 필요한 객체들을 스프링의 객체(bean)로 등록할 것이라는 것
@Log4j // 목록을 사용해서 로그 기록
public class JDBCTests {

	@Test
	public void testConnection() throws SQLException {
		Connection conn = null;
		try {
			String url = "jdbc:oracle:thin:@localhost:1521:orcl";
			String user = "movie";
			String password = "2030";

			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(url, user, password);
			log.info(conn);
			log.info("데이터베이스 연결이 성공했습니다.");
		} catch (Exception e) {
			log.info("데이터베이스 연결이 실패했습니다.");
			e.printStackTrace();
		} finally {
			if (conn != null)
				conn.close();
		}
	}
}
