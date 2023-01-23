package com.example.paperless;

import java.util.List;
import java.util.Map;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EmployeeDAOImpl implements EmployeeDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 로그인한 사원의 정보 반환
	public EmployeeDTO getEmpInfo(String login_id){
		EmployeeDTO employeeDTO = this.sqlSession.selectOne("com.example.paperless.EmployeeDAO.getEmpInfo", login_id);
		return employeeDTO;
	}
	
	// 회사 부서 목록 반환
	public List<Map<String,String>> getDept(int company_code){
		List<Map<String,String>> deptList = this.sqlSession.selectList("com.example.paperless.EmployeeDAO.getDept", company_code);
		return deptList;
	}
	
	// 회사내의 모든 직원 목록 반환
	public List<Map<String,String>> getAllEmployeeList(int company_code) {
		
		List<Map<String,String>> employeeList = this.sqlSession.selectList(
				"com.example.paperless.EmployeeDAO.getAllEmployeeList"
				, company_code
		);
		return employeeList;
	}
	
	/* employeeList.do */
	//검색한 직원 목록 리턴 하는 메소드
	public List<Map<String,String>> getEmployeeList(EmployeeSearchDTO employeeSearchDTO) {
		
		List<Map<String,String>> employeeList = this.sqlSession.selectList(
				"com.example.paperless.EmployeeDAO.getEmployeeList"
				, employeeSearchDTO
		);
		return employeeList;
	}
	
	// [직원 목록]의 총개수 리턴하는 메소드 선언	
	public int  getEmployeeListAllTotCnt(int company_code) {
		int employeeListAllTotCnt = this.sqlSession.selectOne(
				"com.example.paperless.EmployeeDAO.getEmployeeListAllTotCnt"
				, company_code
		);
		return employeeListAllTotCnt;
	}
		
	// [검색한 직원 목록]의 총개수 리턴하는 메소드 선언	
	public int  getEmployeeListTotCnt( EmployeeSearchDTO employeeSearchDTO ) {
		int employeeListTotCnt = this.sqlSession.selectOne(
				"com.example.paperless.EmployeeDAO.getEmployeeListTotCnt"
				, employeeSearchDTO
		);
		return employeeListTotCnt;
	}
	
	
	
	/* employeeRegProc.do */
	// 새로운 직원 추가
	public int insertEmployee(EmployeeDTO employeeDTO) {
		int insertEmployeeCnt = this.sqlSession.insert(
				"com.example.paperless.EmployeeDAO.insertEmployee"
				, employeeDTO
		);
		return insertEmployeeCnt;
	}
	
	
	
	/* employeeUpProc.do */
	// 직원 정보 수정
	public int updateEmployee(EmployeeDTO employeeDTO) {
		int updateEmployeeCnt = this.sqlSession.update(
				"com.example.paperless.EmployeeDAO.updateEmployee"
				, employeeDTO
		);
		return updateEmployeeCnt;
	}
	
	// 내 정보 수정
	public int updateMyEmployee(EmployeeDTO employeeDTO) {
		int updateMyEmployeeCnt = this.sqlSession.update(
				"com.example.paperless.EmployeeDAO.updateMyEmployee"
				, employeeDTO
		);
		return updateMyEmployeeCnt;
	}
}
