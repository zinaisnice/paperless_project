package com.example.paperless;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ReportController {
	
	@Autowired
	private EmployeeDAO employeeDAO;
	
	@Autowired
	private ReportDAO reportDAO;
	
	@Autowired
	private ReportService reportService;
	
	
	@RequestMapping(value="/reportList.do")
	public ModelAndView reportList(ReportSearchDTO reportSearchDTO, HttpSession session) {
		
		String login_id = (String)session.getAttribute("id");
		EmployeeDTO employeeDTO = this.employeeDAO.getEmpInfo(login_id);
		reportSearchDTO.setEmp_no(employeeDTO.getEmp_no());
		reportSearchDTO.setCompany_code(employeeDTO.getCompany_code());
		int reportTotCnt = this.reportDAO.getReportListTotCnt(reportSearchDTO);
		
		
		Map<String, Integer> pagingMap = Util.getPagingMap(
				reportSearchDTO.getSelectPageNo()
				, reportSearchDTO.getRowCntPerPage()
				, reportTotCnt
		);
		
		reportSearchDTO.setSelectPageNo( (int)pagingMap.get("selectPageNo") );
		reportSearchDTO.setBegin_rowNo( (int)pagingMap.get("begin_rowNo") );
		reportSearchDTO.setEnd_rowNo( (int)pagingMap.get("end_rowNo") );
		List<Map<String, String>> reportList = this.reportDAO.getReportList(reportSearchDTO);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("employeeDTO", employeeDTO);
		mav.addObject("reportList", reportList);
		mav.addObject("reportTotCnt", reportTotCnt);
		mav.addObject("pagingMap", pagingMap);
		
		mav.setViewName("reportList");
		
		return mav;
	}
	
	
	@RequestMapping(value="/reportRegForm.do")
	public ModelAndView reportRegForm(
			@RequestParam(value="report_code") int report_code
			, HttpSession session
	) {
		String login_id = (String)session.getAttribute("id");
		EmployeeDTO employeeDTO = this.employeeDAO.getEmpInfo(login_id);
		// 결재라인 완성 시 변경
		List<Map<String,String>> superior_List = this.reportDAO.getSuperiorList(employeeDTO.getEmp_no());
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("employeeDTO", employeeDTO);
		mav.addObject("superior_List", superior_List);
		
		if(report_code == 1) mav.setViewName("reportReg_daily");
		else if(report_code == 2) mav.setViewName("reportReg_expense");
		else if(report_code == 3) mav.setViewName("reportReg_sales");
		else if(report_code == 4) mav.setViewName("reportReg_vacation");
		
		return mav;
	}
	
	
	@RequestMapping(
		value="/reportRegProc.do"
		, method=RequestMethod.POST
		, produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int reportRegProc(ReportDTO reportDTO) {
		
		int reportRegCnt = this.reportService.reportReg(reportDTO);
		return reportRegCnt;
		
	}
	
	
	
	
	@RequestMapping(value="/reportDetail.do")
	public ModelAndView reportDetail(ReportDTO report_no, HttpSession session
	) {
		String login_id = (String)session.getAttribute("id");
		EmployeeDTO employeeDTO = this.employeeDAO.getEmpInfo(login_id);
		
		ReportDTO reportDTO = this.reportDAO.getReport(report_no);
		List<Map<String,String>> approval_List = this.reportDAO.getApprovalList(report_no);
		int approvalListSize = this.reportDAO.approvalListSize(report_no);
		int nextEmpNo = 0; 
		if(reportDTO.getApproval_code() != 4) nextEmpNo = this.reportDAO.getNextEmpNo(report_no);
		
		
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("reportDTO", reportDTO);
		mav.addObject("approval_List", approval_List);
		mav.addObject("employeeDTO", employeeDTO);
		mav.addObject("approvalListSize", approvalListSize);
		mav.addObject("division", "detail");
		mav.addObject("nextEmpNo", nextEmpNo);
		mav.setViewName("reportDetail");
		
		return mav;
	}
	
	
	// 보고서 결재전 or 재결재 올리기위해 보고서 수정 화면 이동
	@RequestMapping(value="/reportUp.do")
	public ModelAndView reportUp(ReportDTO report_no, HttpSession session) {
		String login_id = (String)session.getAttribute("id");
		EmployeeDTO employeeDTO = this.employeeDAO.getEmpInfo(login_id);
		
		ReportDTO reportDTO = this.reportDAO.getReport(report_no);
		int nextEmpNo = this.reportDAO.getNextEmpNo(report_no);
		
		List<Map<String,String>> superior_List = this.reportDAO.getSuperiorList(employeeDTO.getEmp_no());
		
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("emp_no", employeeDTO.getEmp_no());
		map.put("approval_line", reportDTO.getApproval_line());
		Map<String,String> superior = this.reportDAO.getSuperior(map);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("reportDTO", reportDTO);
		mav.addObject("superior_List", superior_List);
		mav.addObject("superior", superior);
		mav.addObject("employeeDTO", employeeDTO);
		mav.addObject("nextEmpNo", nextEmpNo);
		
		if(reportDTO.getReport_code() == 1) {
			mav.setViewName("reportUpdate_daily");
		}
		else if(reportDTO.getReport_code() == 2) {
			mav.setViewName("reportUpdate_expense");
		}
		else if(reportDTO.getReport_code() == 3) {
			mav.setViewName("reportUpdate_sales");
		}
		else if(reportDTO.getReport_code() == 4) {
			mav.setViewName("reportUpdate_vacation");
		}
		
		return mav;
	}
	
	
	
	@RequestMapping(
			value="/reportUpProc.do"
			, method=RequestMethod.POST
			, produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int reportUpProc(ReportDTO reportDTO) {
		int updateReportCnt = this.reportService.updateReport(reportDTO);
		return updateReportCnt;
	}
	
	
	
	@RequestMapping(
			value="/reportDelProc.do"
			, method=RequestMethod.POST
			, produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int reportDelProc(ReportDTO reportDTO) {
		int deleteReportCnt = this.reportService.deleteReport(reportDTO);
		return deleteReportCnt;
	}
	
	
	
	@RequestMapping(value="/reportApproval.do")
	public ModelAndView reportApproval(ReportDTO reportDTO, HttpSession session) {
		String login_id = (String)session.getAttribute("id");
		EmployeeDTO employeeDTO = this.employeeDAO.getEmpInfo(login_id);
		
		ReportDTO report = this.reportDAO.getReport(reportDTO);
		
		
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("emp_no", employeeDTO.getEmp_no());
		map.put("approval_line", report.getApproval_line());
		
		Map<String,String> superior = this.reportDAO.getSuperior(map);
		
		List<Map<String,String>> approval_List = this.reportDAO.getApprovalList(reportDTO);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("employeeDTO", employeeDTO);
		mav.addObject("reportDTO", report);
		mav.addObject("superior", superior);
		mav.addObject("approval_List", approval_List);
		mav.addObject("division", "approval");
		if(superior != null) {
			mav.addObject("no_next", 0);
		}
		else {
			mav.addObject("no_next", 1);
		}
		mav.setViewName("reportDetail");
		
		return mav;
	}
	
	
	
	@RequestMapping(
			value="/reportApprovalProc.do"
			, method=RequestMethod.POST
			, produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int reportApprovalProc(ReportDTO reportDTO) {
		
		System.out.println("---------값이 나오나");
		
		if(reportDTO.getApproval_code() == 2) { // 결재
			int reportApprovalCnt = this.reportService.reportApproval(reportDTO);
			return reportApprovalCnt;
		}
		else if(reportDTO.getApproval_code() == 3) { // 반려
			int reportResignationCnt = this.reportService.reportResignation(reportDTO);
			return reportResignationCnt;
		}
		else if(reportDTO.getApproval_code() == 4) { // 최종 결재
			int reportApprovalFinalCnt = this.reportService.reportApprovalFinal(reportDTO);
			return reportApprovalFinalCnt;
		}
		return -2;
		
	}
	
	
	@RequestMapping(
			value="/reportReApprovalProc.do"
			, method=RequestMethod.POST
			, produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int reportReApprovalProc(ReportDTO reportDTO) {
		
		int reportReApprovalCnt = this.reportService.reportReApproval(reportDTO);
		return reportReApprovalCnt;
		
	}
}
