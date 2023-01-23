package com.example.paperless;

public interface ReportService {
	
	/* reportRegProc.do */
	// 보고서 등록
	int reportReg(ReportDTO reportDTO);
	
	/* reportUpProc.do */
	// 보고서 작성자가 결재 되기 전 보고서 내용 수정
	int updateReport(ReportDTO reportDTO);
	
	/* reportDelProc.do */
	// 보고서 삭제
	int deleteReport(ReportDTO reportDTO);
	
	/* reportApprovalProc.do */
	// 보고서 다음 결재자가 결재
	int reportApproval(ReportDTO reportDTO);
	
	// 보고서 반려
	int reportResignation(ReportDTO reportDTO);
	
	// 보고서 최종 결재
	int reportApprovalFinal(ReportDTO reportDTO);
	
	// 보고서 재결재 올리기
	int reportReApproval(ReportDTO reportDTO);
}
