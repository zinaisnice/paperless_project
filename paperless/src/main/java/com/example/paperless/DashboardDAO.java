package com.example.paperless;

import java.util.List;
import java.util.Map;

public interface DashboardDAO {
	
	// 년-월별 보고서 결재 횟수
	List<Map<String, String>> getApprovalCnt(DashboardDTO dashboardDTO);
	
	
	// 월별 등록한 보고서 결재 상태별 갯수
	List<Map<String, String>> getApprovalState(DashboardDTO dashboardDTO);
	
	
	// 등록한 보고서 업무구분별 개수
	List<Map<String, String>> getTypeNo(DashboardDTO dashboardDTO);
	
	
	// 년-월별 보고서 결재 횟수
	List<Map<String, String>> getAllApprovalCnt(DashboardDTO dashboardDTO);
	
	
	// 월별 등록한 보고서 결재 상태별 갯수
	List<Map<String, String>> getAllApprovalState(DashboardDTO dashboardDTO);
	
	
	// 등록한 보고서 업무구분별 개수
	List<Map<String, String>> getAllTypeNo(DashboardDTO dashboardDTO);
	
	// 보고서 결재 요청 목록
	List<Map<String, String>> approval_list(EmployeeDTO employeeDTO);
}
