package com.ksinfo.blind.search.dto;

public class CompanyReviewDto {
	//���������� ���̺� ����
	//"blind".COMPANY_REVIEW_MGT 
	
	private String userId;			//�����ۼ�����id//user_id bigint not null
	private String companyId;		//ȸ����id	//company_id bigint not null
	private int jobGroupCode;		//�����ڵ�		//job_group_code character(2) not null
	private String allPoint;		//����		//all_point numeric(2, 1) not null
	private String simpleComment;  //������ 		// simple_comment character varying(60) not null
	private String disadvantages;	//�����򰡳���	// disadvantages character varying(400) not null	
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
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

	//������ ��ɵ��� ��� ���.
	//career_point integer not null
	//work_life_balance_point integer not null
	//pay_point integer not null
	// company_culture_point integer not null
	// head_point integer not null
	// work_start_date date not null
	// work_end_date date not null
	// resign_reason character varying(150) not null
	// work_area character varying(50) not null
	// advantages character varying(400) not null
	// verify_flag character(1) not null
	// complete_flag character(1) not null
	//logical_del_flag character(1) not null
}