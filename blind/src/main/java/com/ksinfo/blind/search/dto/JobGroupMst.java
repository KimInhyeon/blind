package com.ksinfo.blind.search.dto;

public class JobGroupMst {
	private int job_group_id;		//job_group_id bigint GENERATED ALWAYS AS IDENTITY
	private String job_group_code;	//, job_group_code character(2) not null
	private String job_group_name;  //, job_group_name character varying(100) not null
	private char logical_del_flag;  //, logical_del_flag character(1) not null

	
	public int getJob_group_id() {
		return job_group_id;
	}
	public void setJob_group_id(int job_group_id) {
		this.job_group_id = job_group_id;
	}
	public String getJob_group_code() {
		return job_group_code;
	}
	public void setJob_group_code(String job_group_code) {
		this.job_group_code = job_group_code;
	}
	public String getJob_group_name() {
		return job_group_name;
	}
	public void setJob_group_name(String job_group_name) {
		this.job_group_name = job_group_name;
	}
	public char getLogical_del_flag() {
		return logical_del_flag;
	}
	public void setLogical_del_flag(char logical_del_flag) {
		this.logical_del_flag = logical_del_flag;
	}
}
