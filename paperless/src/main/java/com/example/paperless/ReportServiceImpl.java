package com.example.paperless;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ReportServiceImpl implements ReportService{
	
	@Autowired
	private ReportDAO reportDAO;
	
	public int reportReg(ReportDTO reportDTO) {
		// 각 보고서 테이블에 보고서 정보 삽입
		int reportRegCnt = this.reportDAO.insertReport(reportDTO);
		if(reportRegCnt == 1) {
			// 결재 상황 테이블에 보고서 작성자 (결재완료) 삽입
			int reportRegCnt1 = this.reportDAO.insertReport_approval(reportDTO);
			if(reportRegCnt1 == 1) {
				// 결재 상황 테이블에 다음 결재자 (결재대기) 삽입
				int reportRegCnt2 = this.reportDAO.insertReport_approvalNext(reportDTO);
				return reportRegCnt2;
			}
			else return -2;
		}
		else return -3;
	}
	
	/* reportUpProc.do */
	// 보고서 작성자가 결재 되기 전 보고서 내용 수정
	public int updateReport(ReportDTO reportDTO) {
		int updateReportCnt = this.reportDAO.updateReport(reportDTO);
		if(updateReportCnt == 1) {
			int updateReportCnt1 = this.reportDAO.updateReport_ApprovalNextEmp(reportDTO);
			return updateReportCnt1;
		}
		return -1;
	}
	
	/* reportDelProc.do */
	// 보고서 삭제
	public int deleteReport(ReportDTO reportDTO) {
		int deleteReportCnt = this.reportDAO.deleteReport(reportDTO);
		if(deleteReportCnt == 1) {
			int deleteReportCnt1 = this.reportDAO.deleteApproval(reportDTO);
			return deleteReportCnt1;
		}
		return -1;
	}
	
	// 보고서 다음 결재자가 결재
	public int reportApproval(ReportDTO reportDTO) {
		// 결재 상황 테이블에서의 다음 결재자 상태(결재완료/반려) 변경
		int reportApprovalCnt = this.reportDAO.updateReport_approval(reportDTO);
		if(reportApprovalCnt == 1) {
			// 결재 상황 테이블에 다다음 결재자(결재) / 최초 작성자(반려) 상태(결재대기)로 삽입
			int reportApprovalCnt1 = this.reportDAO.insertReport_approvalNext1(reportDTO);
			return reportApprovalCnt1;
		}
		return -1;
	}
	
	// 보고서 다음 결재자가 반려
	public int reportResignation(ReportDTO reportDTO) {
		// 결재 상황 테이블에서의 다음 결재자 상태(결재완료/반려) 변경
		int reportApprovalCnt = this.reportDAO.updateReport_approval(reportDTO);
		if(reportApprovalCnt == 1) {
			// 결재 상황 테이블에 다다음 결재자(결재) / 최초 작성자(반려) 상태(결재대기)로 삽입
			int reportApprovalCnt1 = this.reportDAO.insertReport_approvalNext1(reportDTO);
			if(reportApprovalCnt1 == 1) {
				// 결재 반려시 각 보고서 테이블에서의 해당 보고서 결재 상태를 반려로 변경
				int reportApprovalCnt2 = this.reportDAO.updateReport_approvalCode(reportDTO);
				if(reportApprovalCnt2 == 1) {
					// 결재 반려 사유를 반려 테이블에 저장
					int reportApprovalCnt3 = this.reportDAO.insertResignationContent(reportDTO);
					return reportApprovalCnt3;
				}
				return -3;
			}
			return -2;
		}
		return reportApprovalCnt;
	}
	
	// 보고서 최종 결재
	public int reportApprovalFinal(ReportDTO reportDTO) {
		// 결재 상황 테이블에서의 다음 결재자 상태(결재완료/반려) 변경
		int reportApprovalFinalCnt = this.reportDAO.updateReport_approval(reportDTO);
		if(reportApprovalFinalCnt == 1) {
			// 결재 반려시 각 보고서 테이블에서의 해당 보고서 결재 상태를 (반려/최종결재/결재대기)로 변경
			int reportApprovalFinalCnt1 = this.reportDAO.updateReport_approvalCode(reportDTO);
			return reportApprovalFinalCnt1;
		}
		return -1;
	}
	
	// 보고서 재결재 올리기
	public int reportReApproval(ReportDTO reportDTO) {
		int reportReApprovalCnt = this.reportDAO.updateReport_resignation(reportDTO);
		if(reportReApprovalCnt == 1) {
			// 결재 상황 테이블에 작성자(결재완료) 변경
			int reportReApprovalCnt1 = this.reportDAO.updateReport_approval(reportDTO);
			if(reportReApprovalCnt1 == 1) {
				// 결재 상황 테이블에 다음 결재자(결재대기)로 삽입
				int reportReApprovalCnt2 = this.reportDAO.insertReport_approvalNext(reportDTO);
				return reportReApprovalCnt2;
			}
			return reportReApprovalCnt1;
		}
		return reportReApprovalCnt;
	}
}
