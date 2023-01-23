package com.example.paperless;

import java.util.List;
import java.util.Map;

public interface EmployeeDAO {
	
	// 로그인한 사원의 정보 반환
	EmployeeDTO getEmpInfo(String login_id);
	
	// 회사 부서 목록 반환
	List<Map<String,String>> getDept(int company_code);
	
	//검색한 직원 목록 리턴 하는 메소드
	List<Map<String,String>> getAllEmployeeList(int company_code);
	
	/* employeeList.do */
	//검색한 직원 목록 리턴 하는 메소드
	List<Map<String,String>> getEmployeeList(EmployeeSearchDTO employeeSearchDTO);
	
	// [직원 목록]의 총개수 리턴하는 메소드 선언	
	int  getEmployeeListAllTotCnt(int company_code);
		
	// [검색한 직원 목록]의 총개수 리턴하는 메소드 선언	
	int  getEmployeeListTotCnt( EmployeeSearchDTO employeeSearchDTO );
	
	
	
	/* employeeRegProc.do */
	// 새로운 직원 추가
	int insertEmployee(EmployeeDTO employeeDTO);
	
	
	
	/* employeeUpProc.do */
	// 직원 정보 수정
	int updateEmployee(EmployeeDTO employeeDTO);
	
	// 내 정보 수정
	int updateMyEmployee(EmployeeDTO employeeDTO);
}
