package com.example.paperless;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DashboardDAOImpl implements DashboardDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 년도별 보고서 결재 횟수
	public List<Map<String, String>> getApprovalCnt(DashboardDTO dashboardDTO){
		List<Map<String, String>> ApprovalCnt = this.sqlSession.selectList("com.example.paperless.DashboardDAO.getApprovalCnt", dashboardDTO);
		return ApprovalCnt;
	}
	
	
	// 월별 등록한 보고서 결재 상태별 갯수
	public List<Map<String, String>> getApprovalState(DashboardDTO dashboardDTO){
		List<Map<String, String>> ApprovalState = this.sqlSession.selectList("com.example.paperless.DashboardDAO.getApprovalState", dashboardDTO);
		return ApprovalState;
	}
	
	
	// 년도별 등록한 보고서 업무구분별 개수
	public List<Map<String, String>> getTypeNo(DashboardDTO dashboardDTO){
		List<Map<String, String>> TypeNo = this.sqlSession.selectList("com.example.paperless.DashboardDAO.getTypeNo", dashboardDTO);
		return TypeNo;
	}
	
	// 년도별 보고서 결재 횟수
	public List<Map<String, String>> getAllApprovalCnt(DashboardDTO dashboardDTO){
		List<Map<String, String>> ApprovalCnt = this.sqlSession.selectList("com.example.paperless.DashboardDAO.getAllApprovalCnt", dashboardDTO);
		return ApprovalCnt;
	}
	
	
	// 월별 등록한 보고서 결재 상태별 갯수
	public List<Map<String, String>> getAllApprovalState(DashboardDTO dashboardDTO){
		List<Map<String, String>> ApprovalState = this.sqlSession.selectList("com.example.paperless.DashboardDAO.getAllApprovalState", dashboardDTO);
		return ApprovalState;
	}
	
	
	// 년도별 등록한 보고서 업무구분별 개수
	public List<Map<String, String>> getAllTypeNo(DashboardDTO dashboardDTO){
		List<Map<String, String>> TypeNo = this.sqlSession.selectList("com.example.paperless.DashboardDAO.getAllTypeNo", dashboardDTO);
		return TypeNo;
	}
	
	// 보고서 결재 요청 목록
	public List<Map<String, String>> approval_list(EmployeeDTO employeeDTO){
		List<Map<String, String>> approval_list = this.sqlSession.selectList("com.example.paperless.DashboardDAO.approvalList", employeeDTO);
		return approval_list;
	}
}
