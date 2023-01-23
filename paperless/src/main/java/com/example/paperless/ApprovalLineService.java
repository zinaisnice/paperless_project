package com.example.paperless;

public interface ApprovalLineService {
	
	
	// 새로운 회사 등록
	 int insertNewCompanyApprovalLine(EmployeeDTO employeeDTO);
	 
	// 기존 회사 결재라인 추가 등록
	 int insertCompanyApprovalLine(EmployeeDTO employeeDTO);
}
