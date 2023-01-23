package com.example.paperless;

import java.util.List;
import java.util.Map;

public interface ApprovalLineDAO {
	
	// 동일한 회사명 있는지 검색
	int searchCompanyName(String company_name);
	
	// 새로운 회사 추가
	int insertCompany(String company_name);
	
	// 새로운 회사 관리자 추가
	int insertManager(String company_name);
	
	// 새로운 회사 직원 추가
	int insertEmployee(EmployeeDTO employeeDTO);
	
	// 새로운 회사 결재 라인 추가
	int insertApprovalLine(EmployeeDTO employeeDTO);
	
	// 회사 몇번째 결재라인인지, 해당 결재라인의 인원수 반환
	List<Map<String,String>> getApprovalLineNo(int company_code);
	
	// 회사 결재라인 정보 가져오기
	List<Map<String,String>> getApprovalLineInfo(int company_code);
	
	// 기존 회사 새로운 결재 라인 추가
	int addApprovalLine(EmployeeDTO employeeDTO);
}
