package com.example.paperless;

import java.util.List;
import java.util.Map;

public interface ReportDAO {
	// 로그인한 사원이 속해있는 결재라인들의 직속상급자, 결재라인 번호 목록 반환
	List<Map<String,String>> getSuperiorList(int login_empNo);
	
	// 보고서 작성자가 선택한 결재라인의 상급자 반환
	Map<String,String> getSuperior(Map<String,Integer> map);
	
	/* reportList.do */
	// 검색한 보고서 목록 반환
	List<Map<String,String>> getReportList(ReportSearchDTO reportSearchDTO);
	
	// 검색한 보고서 목록의 총 개수 반환
	int getReportListTotCnt(ReportSearchDTO reportSearchDTO);
	
	
	
	/* reportRegProc.do */
	// 각 보고서 테이블에 보고서 정보 삽입
	int insertReport(ReportDTO reportDTO);
	
	// 결재 상황 테이블에 보고서 작성자 (결재완료) 삽입
	int insertReport_approval(ReportDTO reportDTO);
	
	// 결재 상황 테이블에 다음 결재자 (결재대기) 삽입
	int insertReport_approvalNext(ReportDTO reportDTO);
	
	
	/* reportDetail.do */
	// 해당 보고서의 정보 반환
	ReportDTO getReport(ReportDTO reportDTO);
	
	// 해당 보고서의 결재 상황 리스트 반환
	List<Map<String,String>> getApprovalList(ReportDTO reportDTO);
	
	// 다음 결재자(결재 상황 테이블에서의 결재 대기 상태)의 사원번호 반환
	int getNextEmpNo(ReportDTO reportDTO);
	
	// 수정 가능한 상황인지 알 수 있는 결재 상황 갯수 반환
	int approvalListSize(ReportDTO reportDTO);
	
	
	/* reportUpProc.do */
	// 보고서 작성자가 결재 되기 전 보고서 내용 수정
	int updateReport(ReportDTO reportDTO);
	
	// 보고서 작성자가 보고서 수정할 때 다음 결재자 사원코드 변경
	int updateReport_ApprovalNextEmp(ReportDTO reportDTO);
	
	
	/* reportDelProc.do */
	// 보고서 삭제
	int deleteReport(ReportDTO reportDTO);
	
	// 결재 상황 테이블에 삭제된 보고서 정보 삭제
	int deleteApproval(ReportDTO reportDTO);
	
	
	/* reportApprovalProc.do */
	// 결재 상황 테이블에서의 다음 결재자 상태(결재완료/반려) 변경
	int updateReport_approval(ReportDTO reportDTO);
	
	// 결재 상황 테이블에 다다음 결재자(결재) / 최초 작성자(반려) 상태(결재대기)로 삽입
	int insertReport_approvalNext1(ReportDTO reportDTO);
	
	
	
	
	// 보고서 테이블의 상태를 반려로 변경
	int updateReport_approvalCode(ReportDTO reportDTO);
	
	// 반려시 반려사유 저장
	int insertResignationContent(ReportDTO reportDTO);
	
	
	// 반려된 보고서 재결재 올릴 때 보고서 정보 수정
	int updateReport_resignation(ReportDTO reportDTO);
	
}
