package com.example.paperless;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DashboardController {
	
	@Autowired
	private EmployeeDAO employeeDAO;
	
	@Autowired
	private DashboardDAO dashboardDAO;
	
	@RequestMapping(value="/dashBoard.do")
	public ModelAndView dashBoard(DashboardDTO dashboardDTO, HttpSession session) {
		
		String login_id = (String)session.getAttribute("id");
		EmployeeDTO employeeDTO = this.employeeDAO.getEmpInfo(login_id);
		
		dashboardDTO.setCompany_code(employeeDTO.getCompany_code());
		dashboardDTO.setEmp_no(employeeDTO.getEmp_no());
		
		ModelAndView mav = new ModelAndView();
		
		if(employeeDTO.getRole().equals("USER")) {
			List<Map<String, String>> ApprovalCnt = this.dashboardDAO.getApprovalCnt(dashboardDTO);
			List<Map<String, String>> ApprovalState = this.dashboardDAO.getApprovalState(dashboardDTO);
			List<Map<String, String>> TypeNo = this.dashboardDAO.getTypeNo(dashboardDTO);
			List<Map<String, String>> approvalList = this.dashboardDAO.approval_list(employeeDTO);
			
			int approvalListSize = approvalList.size();
			
			mav.addObject("employeeDTO", employeeDTO);
			mav.addObject("ApprovalCnt", ApprovalCnt);
			mav.addObject("ApprovalState", ApprovalState);
			mav.addObject("TypeNo", TypeNo);
			mav.addObject("approvalList", approvalList);
			mav.addObject("approvalListSize", approvalListSize);
		}
		else if(employeeDTO.getRole().equals("MANAGER")) {
			List<Map<String, String>> ApprovalCnt = this.dashboardDAO.getAllApprovalCnt(dashboardDTO);
			List<Map<String, String>> ApprovalState = this.dashboardDAO.getAllApprovalState(dashboardDTO);
			List<Map<String, String>> TypeNo = this.dashboardDAO.getAllTypeNo(dashboardDTO);
			List<Map<String, String>> approvalList = this.dashboardDAO.approval_list(employeeDTO);
			
			int approvalListSize = approvalList.size();
			
			mav.addObject("employeeDTO", employeeDTO);
			mav.addObject("ApprovalCnt", ApprovalCnt);
			mav.addObject("ApprovalState", ApprovalState);
			mav.addObject("TypeNo", TypeNo);
			mav.addObject("approvalList", approvalList);
			mav.addObject("approvalListSize", approvalListSize);
		}
		mav.setViewName("dashBoard");
		
		return mav;
	}
	
	
}
