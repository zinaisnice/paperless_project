package com.example.paperless;

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
public class EmployeeController {
	
	@Autowired
	private EmployeeDAO employeeDAO;
	
	@RequestMapping(value="/employeeList.do")
	public ModelAndView employeeList(EmployeeSearchDTO employeeSearchDTO, HttpSession session) {
		String login_id = (String)session.getAttribute("id");
		EmployeeDTO employeeDTO = this.employeeDAO.getEmpInfo(login_id);
		employeeSearchDTO.setCompany_code(employeeDTO.getCompany_code());
		
		int employeeAllTotCnt = this.employeeDAO.getEmployeeListAllTotCnt(employeeDTO.getCompany_code());
		int employeeTotCnt = this.employeeDAO.getEmployeeListTotCnt(employeeSearchDTO);
		
		Map<String,Integer> pagingMap = Util.getPagingMap(
				employeeSearchDTO.getSelectPageNo()
				, employeeSearchDTO.getRowCntPerPage()
				, employeeTotCnt
		);
		
		employeeSearchDTO.setSelectPageNo( (int)pagingMap.get("selectPageNo") );
		employeeSearchDTO.setBegin_rowNo( (int)pagingMap.get("begin_rowNo") ); 
		employeeSearchDTO.setEnd_rowNo( (int)pagingMap.get("end_rowNo") );
		
		List<Map<String,String>> employeeList = this.employeeDAO.getEmployeeList(employeeSearchDTO);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("employeeDTO", employeeDTO);
		mav.addObject("employeeAllTotCnt", employeeAllTotCnt);
		mav.addObject("employeeTotCnt", employeeTotCnt);
		mav.addObject("employeeList", employeeList);
		mav.addObject("pagingMap", pagingMap);
		
		mav.setViewName("employeeList");
		
		return mav;
		
	}
	
	
	@RequestMapping(value="/employeeRegForm.do")
	public ModelAndView employeeRegForm(
			@RequestParam(value="company_code") int company_code
	) {
		// 직급 리스트
		// 부서 리스트
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("company_code", company_code);
		
		mav.setViewName("employeeReg");
		
		return mav;
	}
	
	@RequestMapping(
			value="/employeeRegProc.do"
			, method=RequestMethod.POST
			, produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int employeeRegProc(EmployeeDTO employeeDTO) {
		int employeeRegCnt = this.employeeDAO.insertEmployee(employeeDTO);
		return employeeRegCnt;
	}
	
	
	@RequestMapping(value="/employeeDetail.do")
	public ModelAndView employeeDetail(
			@RequestParam(value="id") String id
			, HttpSession session
	) {
		String login_id = (String)session.getAttribute("id");
		EmployeeDTO employeeDTO = this.employeeDAO.getEmpInfo(login_id);
		EmployeeDTO empDTO = this.employeeDAO.getEmpInfo(id);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("employeeDTO", employeeDTO);
		mav.addObject("empDTO", empDTO);
		mav.addObject("role", "MANAGER");
		mav.setViewName("employeeDetail");
		
		return mav;
	}
	
	
	@RequestMapping(
			value="/employeeUpProc.do"
			, method=RequestMethod.POST
			, produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int employeeUpProc(EmployeeDTO employeeDTO) {
		int updateEmployeeCnt = this.employeeDAO.updateEmployee(employeeDTO);
		return updateEmployeeCnt;
	}
	
	
	@RequestMapping(value="/myPage.do")
	public ModelAndView myPage(HttpSession session) {
		
		String login_id = (String)session.getAttribute("id");
		EmployeeDTO employeeDTO = this.employeeDAO.getEmpInfo(login_id);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("employeeDTO", employeeDTO);
		mav.addObject("role", "USER");
		mav.setViewName("employeeDetail");
		
		return mav;
	}
	
	@RequestMapping(
			value="/myEmployeeUpProc.do"
			, method=RequestMethod.POST
			, produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int myEmployeeUpProc(EmployeeDTO employeeDTO) {
		int updateEmployeeCnt = this.employeeDAO.updateMyEmployee(employeeDTO);
		return updateEmployeeCnt;
	}
}
