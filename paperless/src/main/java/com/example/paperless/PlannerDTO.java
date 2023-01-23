package com.example.paperless;

public class PlannerDTO {
	
	private int plan_no;
	private String plan_name;
	private String plan_start_date;
	private String plan_end_date;
	private int emp_no;
	
	
	public int getPlan_no() {
		return plan_no;
	}
	public void setPlan_no(int plan_no) {
		this.plan_no = plan_no;
	}
	public String getPlan_name() {
		return plan_name;
	}
	public void setPlan_name(String plan_name) {
		this.plan_name = plan_name;
	}
	public String getPlan_start_date() {
		return plan_start_date;
	}
	public void setPlan_start_date(String plan_start_date) {
		this.plan_start_date = plan_start_date;
	}
	public String getPlan_end_date() {
		return plan_end_date;
	}
	public void setPlan_end_date(String plan_end_date) {
		this.plan_end_date = plan_end_date;
	}
	public int getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}
	
	
	
}
