package com.example.paperless;

import java.util.Map;

public interface LoginDAO {
	// 로그인 정보 일치 여부 반환
	int getLoginCnt(Map<String,String> idPwd);
}
