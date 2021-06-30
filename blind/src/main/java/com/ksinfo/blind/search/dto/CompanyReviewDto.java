package com.ksinfo.blind.search.dto;

public class CompanyReviewDto {
	//���������� ���̺� ����
	//1."blind".COMPANY_REVIEW_MGT���� ������
	private int userId;			//�����ۼ�����id//user_id bigint not null
	private int companyId;		//ȸ����id	//company_id bigint not null
	private int jobGroupCode;		//�����ڵ�	//job_group_code character(2) not null
	private String allPoint;		//����	//all_point numeric(2, 1) not null
	private String simpleComment;  //������ 	// simple_comment character varying(60) not null
	private String disadvantages;	//����	// disadvantages character varying(400) not null	
	private String careerPoint;				//career_point integer not null
	private String workLifeBalancePoint;	//work_life_balance_point integer not null
	private String payPoint;				//pay_point integer not null
	private String companyCulturePoint;		// company_culture_point integer not null
	private String headPoint;				// head_point integer not null
	private String workStartDate;			// work_start_date date not null
	private String workEndDate;				// work_end_date date not null
	private String resignReason;			// resign_reason character varying(150) not null
	private String workArea;				// work_area character varying(50) not null
	private String advantages;				// advantages character varying(400) not null
	private char verifyFlag;				// verify_flag character(1) not null
	private char completeFlag;				// complete_flag character(1) not null
	private char logicalDelFlag;			//logical_del_flag character(1) not null
	//2.����� ���� ���Ƿ� �߰�.
	private String jobGroupName;			//���� SQL DDL���� �����ϴ�. ������信 �������� ������� �߰��� �κ��Դϴ�.
	
	//���� get/set �޼ҵ� -----
	public String getJobGroupName() {
		return jobGroupName;
	}
	public void setJobGroupName(String jobGroupName) {
		this.jobGroupName = jobGroupName;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getCompanyId() {
		return companyId;
	}
	public void setCompanyId(int companyId) {
		this.companyId = companyId;
	}
	public int getJobGroupCode() {
		return jobGroupCode;
	}
	public void setJobGroupCode(int jobGroupCode) {
		this.jobGroupCode = jobGroupCode;
	}
	public String getAllPoint() {
		return allPoint;
	}
	public void setAllPoint(String allPoint) {
		this.allPoint = allPoint;
	}
	public String getSimpleComment() {
		return simpleComment;
	}
	public void setSimpleComment(String simpleComment) {
		this.simpleComment = simpleComment;
	}
	public String getDisadvantages() {
		return disadvantages;
	}
	public void setDisadvantages(String disadvantages) {
		this.disadvantages = disadvantages;
	}
	public String getCareerPoint() {
		return careerPoint;
	}
	public void setCareerPoint(String careerPoint) {
		this.careerPoint = careerPoint;
	}
	public String getWorkLifeBalancePoint() {
		return workLifeBalancePoint;
	}
	public void setWorkLifeBalancePoint(String workLifeBalancePoint) {
		this.workLifeBalancePoint = workLifeBalancePoint;
	}
	public String getPayPoint() {
		return payPoint;
	}
	public void setPayPoint(String payPoint) {
		this.payPoint = payPoint;
	}
	public String getCompanyCulturePoint() {
		return companyCulturePoint;
	}
	public void setCompanyCulturePoint(String companyCulturePoint) {
		this.companyCulturePoint = companyCulturePoint;
	}
	public String getHeadPoint() {
		return headPoint;
	}
	public void setHeadPoint(String headPoint) {
		this.headPoint = headPoint;
	}
	public String getWorkStartDate() {
		return workStartDate;
	}
	public void setWorkStartDate(String workStartDate) {
		this.workStartDate = workStartDate;
	}
	public String getWorkEndDate() {
		return workEndDate;
	}
	public void setWorkEndDate(String workEndDate) {
		this.workEndDate = workEndDate;
	}
	public String getResignReason() {
		return resignReason;
	}
	public void setResignReason(String resignReason) {
		this.resignReason = resignReason;
	}
	public String getWorkArea() {
		return workArea;
	}
	public void setWorkArea(String workArea) {
		this.workArea = workArea;
	}
	public String getAdvantages() {
		return advantages;
	}
	public void setAdvantages(String advantages) {
		this.advantages = advantages;
	}
	public char getVerifyFlag() {
		return verifyFlag;
	}
	public void setVerifyFlag(char verifyFlag) {
		this.verifyFlag = verifyFlag;
	}
	public char getCompleteFlag() {
		return completeFlag;
	}
	public void setCompleteFlag(char completeFlag) {
		this.completeFlag = completeFlag;
	}
	public char getLogicalDelFlag() {
		return logicalDelFlag;
	}
	public void setLogicalDelFlag(char logicalDelFlag) {
		this.logicalDelFlag = logicalDelFlag;
	}


}
