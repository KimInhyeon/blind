package com.ksinfo.blind.annualIncome.dto;

public class JobGroupDto {
	//"blind".JOB_GROUP_MST(직군마스터 테이블)
	private int jobGroupId; 		//job_group_id bigint GENERATED ALWAYS AS IDENTITY
	private String jobGroupCode;	//, job_group_code character(2) not null
	private String jobGroupName;	//, job_group_name character varying(100) not null	//, logical_del_flag character(1) not null
	public int getJobGroupId() {
		return jobGroupId;
	}
	public void setJobGroupId(int jobGroupId) {
		this.jobGroupId = jobGroupId;
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
