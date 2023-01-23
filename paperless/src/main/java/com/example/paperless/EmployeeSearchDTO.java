package com.example.paperless;

import java.util.List;

public class EmployeeSearchDTO {
	
	private int company_code;
	private List<String> dept;
	private List<String> jikup;
	
	private String keyword;
	private int selectPageNo;
	private int rowCntPerPage;
	private int begin_rowNo;   
	private int end_rowNo;
	private int pageNoCntPerPage;
	
	
	public int getCompany_code() {
		return company_code;
	}
	public void setCompany_code(int company_code) {
		this.company_code = company_code;
	}
	
	public List<String> getDept() {
		return dept;
	}
	public void setDept(List<String> dept) {
		this.dept = dept;
	}
	public List<String> getJikup() {
		return jikup;
	}
	public void setJikup(List<String> jikup) {
		this.jikup = jikup;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public int getSelectPageNo() {
		return selectPageNo;
	}
	public void setSelectPageNo(int selectPageNo) {
		this.selectPageNo = selectPageNo;
	}
	public int getRowCntPerPage() {
		return rowCntPerPage;
	}
	public void setRowCntPerPage(int rowCntPerPage) {
		this.rowCntPerPage = rowCntPerPage;
	}
	public int getBegin_rowNo() {
		return begin_rowNo;
	}
	public void setBegin_rowNo(int begin_rowNo) {
		this.begin_rowNo = begin_rowNo;
	}
	public int getEnd_rowNo() {
		return end_rowNo;
	}
	public void setEnd_rowNo(int end_rowNo) {
		this.end_rowNo = end_rowNo;
	}
	public int getPageNoCntPerPage() {
		return pageNoCntPerPage;
	}
	public void setPageNoCntPerPage(int pageNoCntPerPage) {
		this.pageNoCntPerPage = pageNoCntPerPage;
	}
	
	
}
