package com.ksinfo.blind.search.dto;

public class CompanyReviewDto {
	//기업리뷰관리 테이블 생성
	//"blind".COMPANY_REVIEW_MGT 
	
	private String userId;			//리뷰작성유저id//user_id bigint not null
	private String companyId;		//회사의id	//company_id bigint not null
	private String jobGroupCode;	//직군코드		//job_group_code character(2) not null
	private String allPoint;		//총점		//all_point numeric(2, 1) not null
	
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
	public String getJobGroupCode() {
		return jobGroupCode;
	}
	public void setJobGroupCode(String jobGroupCode) {
		this.jobGroupCode = jobGroupCode;
	}
	public String getAllPoint() {
		return allPoint;
	}
	public void setAllPoint(String allPoint) {
		this.allPoint = allPoint;
	}

	//나머지 기능들은 잠시 대기.
	//career_point integer not null
	//work_life_balance_point integer not null
	//pay_point integer not null
	// company_culture_point integer not null
	// head_point integer not null
	// work_start_date date not null
	// work_end_date date not null
	// simple_comment character varying(60) not null
	// resign_reason character varying(150) not null
	// work_area character varying(50) not null
	// advantages character varying(400) not null
	// disadvantages character varying(400) not null
	// verify_flag character(1) not null
	// complete_flag character(1) not null
	//logical_del_flag character(1) not null

	
	
	
}
