package com.example.paperless;

import java.util.List;

public class ReportSearchDTO {
	
	private int company_code;
	private int report_code;
	private int emp_no;
	
	private String min_year;
	private String min_month;
	
	private String max_year;
	private String max_month;
	private List<String> approval;
	private List<String> type;
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
	public int getReport_code() {
		return report_code;
	}
	public void setReport_code(int report_code) {
		this.report_code = report_code;
	}
	public int getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}
	public String getMin_year() {
		return min_year;
	}
	public void setMin_year(String min_year) {
		this.min_year = min_year;
	}
	public String getMin_month() {
		return min_month;
	}
	public void setMin_month(String min_month) {
		this.min_month = min_month;
	}
	public String getMax_year() {
		return max_year;
	}
	public void setMax_year(String max_year) {
		this.max_year = max_year;
	}
	public String getMax_month() {
		return max_month;
	}
	public void setMax_month(String max_month) {
		this.max_month = max_month;
	}
	public List<String> getApproval() {
		return approval;
	}
	public void setApproval(List<String> approval) {
		this.approval = approval;
	}
	public List<String> getType() {
		return type;
	}
	public void setType(List<String> type) {
		this.type = type;
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
