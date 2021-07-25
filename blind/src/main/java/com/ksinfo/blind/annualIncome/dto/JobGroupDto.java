package com.ksinfo.blind.annualIncome.dto;

public class JobGroupDto {
	//"blind".JOB_GROUP_MST(직군마스터 테이블)
	private String jobGroupCode;	//, job_group_code character(2) not null
	private String jobGroupName;	//, job_group_name character varying(100) not null	//, logical_del_flag character(1) not null

	//임의작성
	private char disableFlag;		// jsp페이지의  select에서 클릭가능여부를 설정하기 위한 변수.
	
	
	public char getDisableFlag() {
		return disableFlag;
	}
	public void setDisableFlag(char disableFlag) {
		this.disableFlag = disableFlag;
	}

	public String getJobGroupCode() {
		return jobGroupCode;
	}
	public void setJobGroupCode(String jobGroupCode) {
		this.jobGroupCode = jobGroupCode;
	}
	public String getJobGroupName() {
		return jobGroupName;
	}
	public void setJobGroupName(String jobGroupName) {
		this.jobGroupName = jobGroupName;
	}
  
	

}
