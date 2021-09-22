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
}