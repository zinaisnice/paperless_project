package com.example.paperless;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ApprovalLineServiceImpl implements ApprovalLineService {

	
	@Autowired
	private ApprovalLineDAO approvalLineDAO;
	
	// =================================
	// ApprovalLineProc.do
	// =================================
	
	public int insertNewCompanyApprovalLine(EmployeeDTO employeeDTO) {
		
		// 동일한 회사명 있는지 확인
		int searchCompanyName = this.approvalLineDAO.searchCompanyName(employeeDTO.getCompany_name());
		if(searchCompanyName == 0) {
			// 새로운 회사 등록
			int insertCompanyCnt = this.approvalLineDAO.insertCompany(employeeDTO.getCompany_name());
			if(insertCompanyCnt == 1) {
				// 새로운 회사 관리자 등록
				int insertManagerCnt = this.approvalLineDAO.insertManager(employeeDTO.getCompany_name());
				if(insertManagerCnt == 1) {
					// 새로운 회사 직원 값 나누기
					String company_name = employeeDTO.getCompany_name();
					String[] emp_name = employeeDTO.getEmp_name().split(",");
					String[] id = employeeDTO.getId().split(",");
					String[] pwd = employeeDTO.getPwd().split(",");
					String[] jikup_code = employeeDTO.getJikup_codeList().split(",");
					String[] dept_no = employeeDTO.getDept_codeList().split(",");
					String[] email = employeeDTO.getEmail().split(",");
					String[] phone_num = employeeDTO.getPhone_num().split(",");
					
					
					for(int i = 0; i < emp_name.length; i++) {
						EmployeeDTO emp = new EmployeeDTO();
						emp.setCompany_name(company_name);
						emp.setEmp_name(emp_name[i]);
						emp.setId(id[i]);
						emp.setPwd(pwd[i]);
						emp.setJikup_code(Integer.parseInt(jikup_code[i]));
						emp.setDept_code(Integer.parseInt(dept_no[i]));
						emp.setEmail(email[i]);
						emp.setPhone_num(phone_num[i]);
						emp.setOrder(i+1);
						
						// 새로운 회사 직원 추가
						int insertEmployeeCnt = this.approvalLineDAO.insertEmployee(emp);
						if(insertEmployeeCnt == 1) {
							System.out.println(emp_name[i] + "사원 등록 성공");
							// 새로운 회사 결재라인 추가
							int insertApprovalLineCnt = this.approvalLineDAO.insertApprovalLine(emp);
							if(insertApprovalLineCnt != 1) return insertApprovalLineCnt;
						}
						else {
							System.out.println(emp_name[i] + "사원 등록 실패");
							return -4;
						}
					}
					return 1;
				}
				else {
					return -3;
				}
			}
			else {
				System.out.println(employeeDTO.getCompany_name() + "-회사명 등록 실패");
				return -2;
			}
		}
		else {
			System.out.println(employeeDTO.getCompany_name() + "-회사명 있음");
			return -1;
		}
		
	}
	
	// 기존 회사 결재라인 추가 등록
	public int insertCompanyApprovalLine(EmployeeDTO employeeDTO) {
		// 새로운 회사 직원 값 나누기
		int company_code = employeeDTO.getCompany_code();
		String[] emp_no = employeeDTO.getEmp_noList().split(",");
		
		
		for(int i = 0; i < emp_no.length; i++) {
			EmployeeDTO emp = new EmployeeDTO();
			emp.setCompany_code(company_code);
			emp.setEmp_no(Integer.parseInt(emp_no[i]));
			emp.setOrder(i+1);
			
			int addApprovalLineCnt = this.approvalLineDAO.addApprovalLine(emp);
			if(addApprovalLineCnt != 1) return addApprovalLineCnt;
		}
		
		return 1;
	}
}
