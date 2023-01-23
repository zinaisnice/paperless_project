package com.example.paperless;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDAOImpl implements LoginDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 로그인 정보 일치 여부 반환
	public int getLoginCnt(Map<String,String> idPwd) {
		int login_Cnt = this.sqlSession.selectOne("com.example.paperless.LoginDAO.getLoginCnt", idPwd);
		return login_Cnt;
	}
}
