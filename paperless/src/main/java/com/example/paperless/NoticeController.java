package com.example.paperless;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class NoticeController {
	
	@Autowired
	private EmployeeDAO employeeDAO;
	
	@Autowired
	private NoticeDAO noticeDAO;
	
	@Autowired
	private NoticeService noticeService;
	
	public String check_NoticeDTO(NoticeDTO noticeDTO, BindingResult bindingResult){
		
		String msg = "";
		
		NoticeValidator noticeValidator = new NoticeValidator();
		noticeValidator.validate(
			noticeDTO
			, bindingResult
		);
		
		if(bindingResult.hasErrors()) {
			msg = bindingResult.getFieldError().getCode();
		}
		return msg;
	}
	
	
	
	// 공지사항 리스트 검색
	@RequestMapping(value="/noticeList.do")
	public ModelAndView noticeList(
		NoticeSearchDTO noticeSearchDTO
		, HttpSession session
	) {
		String login_id = (String)session.getAttribute("id");
		EmployeeDTO employeeDTO = this.employeeDAO.getEmpInfo(login_id);
		
		noticeSearchDTO.setCompany_code(employeeDTO.getCompany_code());
		int noticeAllTotCnt = this.noticeDAO.getNoticeListAllTotCnt(noticeSearchDTO);
		int noticeTotCnt = this.noticeDAO.getNoticeListTotCnt(noticeSearchDTO);
		
		Map<String, Integer> pagingMap = Util.getPagingMap(
			noticeSearchDTO.getSelectPageNo()
			, noticeSearchDTO.getRowCntPerPage()
			, noticeTotCnt
		);
		
		noticeSearchDTO.setSelectPageNo((int)pagingMap.get("selectPageNo"));
		noticeSearchDTO.setBegin_rowNo((int)pagingMap.get("begin_rowNo"));
		noticeSearchDTO.setEnd_rowNo((int)pagingMap.get("end_rowNo"));
		noticeSearchDTO.setCompany_code(employeeDTO.getCompany_code());
		
		List<Map<String,String>> noticeList = this.noticeDAO.getNoticeList(noticeSearchDTO);

		ModelAndView mav = new ModelAndView();
		mav.addObject("employeeDTO",employeeDTO);
		mav.addObject("noticeList",noticeList);
		mav.addObject("noticeAllTotCnt",noticeAllTotCnt);
		mav.addObject("noticeTotCnt",noticeTotCnt);
		mav.addObject("pagingMap",pagingMap);
		
		mav.setViewName("noticeList");
		
		return mav;
	}
	
	
	// 공지사항 입력 폼
	@RequestMapping(value="/noticeRegForm.do")
	public ModelAndView noticeRegForm(HttpSession session) {
		
		String login_id = (String)session.getAttribute("id");
		EmployeeDTO employeeDTO = this.employeeDAO.getEmpInfo(login_id);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("employeeDTO", employeeDTO);
		
		mav.setViewName("noticeRegForm");
		
		return mav;
	}
	
	
	// 공지사항 등록
	@RequestMapping(
			value="/noticeRegProc.do"
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public Map<String,String> noticeRegProc(
		NoticeDTO noticeDTO
		, BindingResult bindingResult
	) {
		
		int noticeRegCnt = 0;
		String msg = check_NoticeDTO(noticeDTO, bindingResult);
		if(msg != null && msg.equals("")) {
			noticeRegCnt = this.noticeDAO.insertNotice(noticeDTO);
		}
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("msg", msg);
		map.put("noticeRegCnt", noticeRegCnt + "");
		
		return map;		
	}
	
	
	// 공지사항 상세화면으로 이동하기
	@RequestMapping(value="/noticeDetail.do")
	public ModelAndView noticeDetailForm(
		@RequestParam(value="n_no") int n_no
		, HttpSession session
	) {
		String login_id = (String)session.getAttribute("id");
		EmployeeDTO employeeDTO = this.employeeDAO.getEmpInfo(login_id);
		
		NoticeDTO noticeDTO = this.noticeService.getNotice(n_no, true);
		NoticeDTO beforeNoticeDTO = this.noticeDAO.getBeforeNotice(n_no);
		NoticeDTO afterNoticeDTO = this.noticeDAO.getAfterNotice(n_no);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("employeeDTO",employeeDTO);
		mav.addObject("noticeDTO", noticeDTO);
		
		mav.addObject("beforeNoticeDTO", beforeNoticeDTO);
		mav.addObject("afterNoticeDTO", afterNoticeDTO);
		
		mav.setViewName("noticeDetailForm");
		return mav;
	}
	
	
	// 공지사항 수정 화면으로 이동하기
	@RequestMapping(value="/noticeUp.do")
	public ModelAndView noticeUpDelForm(
		@RequestParam(value="n_no") int n_no
		, HttpSession session
	) {
		String login_id = (String)session.getAttribute("id");
		EmployeeDTO employeeDTO = this.employeeDAO.getEmpInfo(login_id);
		NoticeDTO noticeDTO = this.noticeService.getNotice(n_no, false);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("employeeDTO", employeeDTO);
		mav.addObject("noticeDTO", noticeDTO);
		mav.setViewName("noticeUpdateForm");
		
		return mav;
	}
	
	// 공지사항 수정화면(/noticeUpProc.do) 로 접속하면 호출되는 메소드 선언	
	@RequestMapping(
			value="/noticeUpProc.do"
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public Map<String,String> noticeUpProc(
		NoticeDTO noticeDTO
		, BindingResult bindingResult
	) {
		int noticeUpCnt = 0;
		String msg = check_NoticeDTO(noticeDTO, bindingResult); //, "up"
		if(msg != null && msg.equals("")) {
			noticeUpCnt = this.noticeService.updateNotice(noticeDTO);
		}
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("msg", msg);
		map.put("noticeUpCnt", noticeUpCnt + "");
		
		return map;
	}
	

	
	
	// 공지사항 삭제화면(/noticeDelProc.do) 로 접속하면 호출되는 메소드 선언
	@RequestMapping(
			value="/noticeDelProc.do"
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int noticeDelProc(
		// 파라미터값을 저장할 [NoticeDTO 객체]를 매개변수로 선언
		NoticeDTO noticeDTO
	) {
		// NoticeService의 deleteNotice 메소드 호출로 공지사항 삭제하고 [삭제된 행의 개수] 얻기
		int deleteNoticeCnt = this.noticeService.deleteNotice(noticeDTO);
		
		return deleteNoticeCnt;
	}
	
}
