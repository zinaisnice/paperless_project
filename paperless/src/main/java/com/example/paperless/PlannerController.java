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
public class PlannerController {

	@Autowired
	private EmployeeDAO employeeDAO;
	
	@Autowired
	private PlannerDAO plannerDAO;
	
	@RequestMapping(value="/plannerList.do")
	public ModelAndView plannerList( PlannerDTO plannerDTO, HttpSession session) { 
		
		String login_id = (String)session.getAttribute("id");
		EmployeeDTO employeeDTO = this.employeeDAO.getEmpInfo(login_id);
		plannerDTO.setEmp_no(employeeDTO.getEmp_no());
		List<Map<String,String>> planList = this.plannerDAO.getPlanList(plannerDTO);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("planList", planList);
		mav.addObject("employeeDTO", employeeDTO);
		
		mav.setViewName("plannerList");
		
		return mav;
	}
	
	@RequestMapping(
			value="/planRegProc.do"
			, method=RequestMethod.POST
			, produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int planRegProc(PlannerDTO plannerDTO){
		
		int planRegCnt = this.plannerDAO.insertPlan(plannerDTO);
		return planRegCnt;
	}
	
	
	
	@RequestMapping(
			value="/updatePlanProc.do"
			, method=RequestMethod.POST
			, produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int updatePlanProc(PlannerDTO plannerDTO) {
		int updatePlanCnt = this.plannerDAO.updatePlan(plannerDTO);
		return updatePlanCnt;
	}
	
	
	@RequestMapping(
			value="/delPlanProc.do"
			, method=RequestMethod.POST
			, produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int delPlanProc(PlannerDTO plannerDTO) {
		int deletePlanCnt = this.plannerDAO.deletePlan(plannerDTO);
		return deletePlanCnt;
	}
}
