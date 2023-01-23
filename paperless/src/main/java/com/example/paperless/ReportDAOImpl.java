package com.example.paperless;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReportDAOImpl implements ReportDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 상급자 목록 반환
	public List<Map<String,String>> getSuperiorList(int login_empNo) {
		List<Map<String,String>> superiorList = this.sqlSession.selectList("com.example.paperless.ReportDAO.getSuperiorList", login_empNo);
		return superiorList;
	}
	// 보고서 작성자가 선택한 결재라인의 상급자 반환
	public Map<String,String> getSuperior(Map<String,Integer> map){
		Map<String,String> superior = this.sqlSession.selectOne("com.example.paperless.ReportDAO.getSuperior", map);
		return superior;
	}
		
		
	
	/* reportList.do */
	// 검색한 보고서 목록 반환
	public List<Map<String,String>> getReportList(ReportSearchDTO reportSearchDTO){
		List<Map<String,String>> reportList = this.sqlSession.selectList( "com.example.paperless.ReportDAO.getReportList", reportSearchDTO);
		return reportList;		
	}
	
	// 검색한 보고서 목록의 총 개수 반환
	public int getReportListTotCnt(ReportSearchDTO reportSearchDTO) {
		int ReportListTotCnt = this.sqlSession.selectOne("com.example.paperless.ReportDAO.getReportListTotCnt", reportSearchDTO);
		return ReportListTotCnt;
	}
	
	
	
	
	/* reportRegProc.do */
	// 각 보고서 테이블에 보고서 정보 삽입
	public int insertReport(ReportDTO reportDTO) {
		int reportRegCnt = sqlSession.insert("com.example.paperless.ReportDAO.insertReport", reportDTO);
		return reportRegCnt;
	}
	
	// 결재 상황 테이블에 보고서 작성자 (결재완료) 삽입
	public int insertReport_approval(ReportDTO reportDTO) {
		int reportRegCnt = sqlSession.insert("com.example.paperless.ReportDAO.insertReport_approval", reportDTO);
		return reportRegCnt;
	}
	
	// 결재 상황 테이블에 다음 결재자 (결재대기) 삽입
	public int insertReport_approvalNext(ReportDTO reportDTO) {
		int reportRegCnt = sqlSession.insert("com.example.paperless.ReportDAO.insertReport_approvalNext", reportDTO);
		return reportRegCnt;
	}
	
	
	
	/* reportDetail.do */
	// 해당 보고서의 정보 반환
	public ReportDTO getReport(ReportDTO reportDTO) {
		ReportDTO report = this.sqlSession.selectOne("com.example.paperless.ReportDAO.getReport", reportDTO);
		return report;
	}
	
	// 해당 보고서의 결재 상황 리스트 반환
	public List<Map<String,String>> getApprovalList(ReportDTO reportDTO){
		List<Map<String,String>> ApprovalList = this.sqlSession.selectList("com.example.paperless.ReportDAO.getApprovalList", reportDTO);
		return ApprovalList;
	}
	
	// 다음 결재자(결재 상황 테이블에서의 결재 대기 상태)의 사원번호 반환
	public int getNextEmpNo(ReportDTO reportDTO) {
		int nextEmpNo = this.sqlSession.selectOne("com.example.paperless.ReportDAO.getNextEmpNo", reportDTO);
		return nextEmpNo;
	}
	// 수정 가능한 상황인지 알 수 있는 결재 상황 갯수 반환
	public int approvalListSize(ReportDTO reportDTO) {
		int approvalListSize = this.sqlSession.selectOne("com.example.paperless.ReportDAO.approvalListSize", reportDTO);
		return approvalListSize;
	}
	
	
	
	
	
	/* reportUpProc.do */
	public int updateReport(ReportDTO reportDTO) {
		int updateReportCnt = this.sqlSession.update("com.example.paperless.ReportDAO.updateReport", reportDTO);
		return updateReportCnt;
	}
	
	// 보고서 작성자가 보고서 수정할 때 다음 결재자 사원코드 변경
	public int updateReport_ApprovalNextEmp(ReportDTO reportDTO) {
		int updateReport_ApprovalNextEmpCnt = this.sqlSession.update("com.example.paperless.ReportDAO.updateReport_ApprovalNextEmp", reportDTO);
		return updateReport_ApprovalNextEmpCnt;
	}
	
	
	
	
	/* reportDelProc.do */
	// 보고서 삭제
	public int deleteReport(ReportDTO reportDTO) {
		int deleteReportCnt = this.sqlSession.update("com.example.paperless.ReportDAO.deleteReport", reportDTO);
		return deleteReportCnt;
	}
	
	public int deleteApproval(ReportDTO reportDTO) {
		int deleteApprovalCnt = this.sqlSession.update("com.example.paperless.ReportDAO.deleteApproval", reportDTO);
		return deleteApprovalCnt;
	}
	
	
	
	/* reportApprovalProc.do */
	// 결재 상황 테이블에서의 다음 결재자 상태(결재완료/반려) 변경
	public int updateReport_approval(ReportDTO reportDTO) {
		int updatereportCnt = this.sqlSession.update("com.example.paperless.ReportDAO.updateReport_approval", reportDTO);
		return updatereportCnt;
	}
	
	// 결재 상황 테이블에 다다음 결재자(결재) / 최초 작성자(반려) 상태(결재대기)로 삽입
	public int insertReport_approvalNext1(ReportDTO reportDTO) {
		int reportRegCnt = sqlSession.insert("com.example.paperless.ReportDAO.insertReport_approvalNext1", reportDTO);
		return reportRegCnt;
	}
	
	
	
	// 결재 반려시 각 보고서 테이블에서의 해당 보고서 결재 상태를 (반려/최종결재/결재대기)로 변경
	public int updateReport_approvalCode(ReportDTO reportDTO) {
		int updatereportCnt = this.sqlSession.update("com.example.paperless.ReportDAO.updateReport_approvalCode", reportDTO);
		return updatereportCnt;
	}
	
	// 결재 반려 사유를 반려 테이블에 저장
	public int insertResignationContent(ReportDTO reportDTO) {
		int insertResignationContentCnt = sqlSession.insert("com.example.paperless.ReportDAO.insertResignationContent", reportDTO);
		return insertResignationContentCnt;
	}
	
	
	
	/* reportReApprovalProc.do */
	// 반려된 보고서 재결재 올릴 때 보고서 정보 수정
	public int updateReport_resignation(ReportDTO reportDTO) {
		int updateReportCnt = this.sqlSession.update("com.example.paperless.ReportDAO.updateReport_resignation", reportDTO);
		return updateReportCnt;
	}
	
}