package com.example.paperless;


import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ApprovalLineDAOImpl implements ApprovalLineDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	// 동일한 회사명 있는지 검색
	public int searchCompanyName(String company_name) {
		int searchCompanyNameCnt = this.sqlSession.selectOne(
				"com.example.paperless.ApprovalLineDAO.searchCompanyName"
				, company_name
		);
		return searchCompanyNameCnt;
	}
	
	// 새로운 회사 추가
	public int insertCompany(String company_name) {
		int insertCompanyCnt = sqlSession.insert("com.example.paperless.ApprovalLineDAO.insertCompany", company_name);
		return insertCompanyCnt;
	}
	
	// 새로운 회사 관리자 추가
	public int insertManager(String company_name) {
		int insertManagerCnt = sqlSession.insert("com.example.paperless.ApprovalLineDAO.insertManager", company_name);
		return insertManagerCnt;
	}
	
	// 새로운 회사 직원 추가
	public int insertEmployee(EmployeeDTO employeeDTO) {
		int insertEmployeeCnt = sqlSession.insert("com.example.paperless.ApprovalLineDAO.insertEmployee", employeeDTO);
		return insertEmployeeCnt;
	}
	
	// 새로운 회사 결재 라인 추가
	public int insertApprovalLine(EmployeeDTO employeeDTO) {
		int insertApprovalLineCnt = sqlSession.insert("com.example.paperless.ApprovalLineDAO.insertApprovalLine", employeeDTO);
		return insertApprovalLineCnt;
	}
	
	// 회사 몇번째 결재라인인지, 해당 결재라인의 인원수 반환
	public List<Map<String,String>> getApprovalLineNo(int company_code){
		List<Map<String,String>> ApprovalLineNo = this.sqlSession.selectList("com.example.paperless.ApprovalLineDAO.getApprovalLineNo", company_code);
		return ApprovalLineNo;
	}
	
	// 회사 결재라인 정보 가져오기
	public List<Map<String,String>> getApprovalLineInfo(int company_code){
		List<Map<String,String>> ApprovalLineInfo = this.sqlSession.selectList("com.example.paperless.ApprovalLineDAO.getApprovalLineInfo", company_code);
		return ApprovalLineInfo;
	}
	
	// 기존 회사 새로운 결재 라인 추가
	public int addApprovalLine(EmployeeDTO employeeDTO) {
		int addApprovalLineCnt = sqlSession.insert("com.example.paperless.ApprovalLineDAO.addApprovalLine", employeeDTO);
		return addApprovalLineCnt;
	}
}
