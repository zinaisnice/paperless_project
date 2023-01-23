package com.example.paperless;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ApprovalLineController {
	
	@Autowired
	private EmployeeDAO employeeDAO;
	
	@Autowired
	private ApprovalLineDAO approvalLineDAO;
	
	@Autowired
	private ApprovalLineService approvalLineService;
	
	@RequestMapping(value="/ApprovalLineReg.do")
	public ModelAndView approvalLineReg() {
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("approvalLineReg");
		return mav;
	}
	
	
	@RequestMapping(
			value="/ApprovalLineProc.do"
			, method=RequestMethod.POST
			, produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int ApprovalLineProc(EmployeeDTO employeeDTO) {
		
		int insertApprovalLineCnt = this.approvalLineService.insertNewCompanyApprovalLine(employeeDTO);
		return insertApprovalLineCnt;
	}
	
	
	@RequestMapping(value="/approvalLineList.do")
	public ModelAndView approvalLineList(HttpSession session) {
		
		String login_id = (String)session.getAttribute("id");
		EmployeeDTO employeeDTO = this.employeeDAO.getEmpInfo(login_id);
		List<Map<String,String>> ApprovalLineNo = this.approvalLineDAO.getApprovalLineNo(employeeDTO.getCompany_code());
		List<Map<String,String>> ApprovalLineInfo = this.approvalLineDAO.getApprovalLineInfo(employeeDTO.getCompany_code());
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("employeeDTO", employeeDTO);
		mav.addObject("ApprovalLineNo", ApprovalLineNo);
		mav.addObject("ApprovalLineInfo", ApprovalLineInfo);
		
		mav.setViewName("approvalLineList");
		return mav;
	}
	
	@RequestMapping(value="/ApprovalLineAdd.do")
	public ModelAndView approvalLineAdd(HttpSession session) {
		
		String login_id = (String)session.getAttribute("id");
		EmployeeDTO employeeDTO = this.employeeDAO.getEmpInfo(login_id);
		//List<Map<String,String>> deptList = this.employeeDAO.getDept(employeeDTO.getCompany_code());
		List<Map<String,String>> allEmployeeList = this.employeeDAO.getAllEmployeeList(employeeDTO.getCompany_code());
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("employeeDTO", employeeDTO);
		//mav.addObject("deptList", deptList);
		mav.addObject("allEmployeeList", allEmployeeList);
		mav.setViewName("approvalLineAdd");
		return mav;
	}
	
	@RequestMapping(
			value="/ApprovalLineAddProc.do"
			, method=RequestMethod.POST
			, produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int ApprovalLineAddProc(EmployeeDTO employeeDTO) {
		
		int insertApprovalLineCnt = this.approvalLineService.insertCompanyApprovalLine(employeeDTO);
		return insertApprovalLineCnt;
	}
}
