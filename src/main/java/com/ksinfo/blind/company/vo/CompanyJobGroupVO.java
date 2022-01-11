package com.ksinfo.blind.company.vo;

public final class CompanyJobGroupVO {
	private final String jobGroupCode;
	private final String jobGroupName;

	public CompanyJobGroupVO(String jobGroupCode, String jobGroupName) {
		this.jobGroupCode = jobGroupCode;
		this.jobGroupName = jobGroupName;
	}

	public String getJobGroupCode() {
		return jobGroupCode;
	}

	public String getJobGroupName() {
		return jobGroupName;
	}

	/*
	//orignal code
	private final String jobGroupCode;
	private final String jobGroupName;
	private final boolean exist;

	public CompanyJobGroupVO(String jobGroupCode, String jobGroupName, boolean exist) {
		this.jobGroupCode = jobGroupCode;
		this.jobGroupName = jobGroupName;
		this.exist = exist;
	}

	public String getJobGroupCode() {
		return jobGroupCode;
	}

	public String getJobGroupName() {
		return jobGroupName;
	}

	public boolean isExist() {
		return exist;
	}
	*/
}