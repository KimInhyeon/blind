package com.ksinfo.blind.company.dto;

public final class CompanyAnnualIncomeSearchDto {
	private final long companyId;
	private final String jobGroupCode;

	public CompanyAnnualIncomeSearchDto(long companyId, String jobGroupCode) {
		this.companyId = companyId;
		this.jobGroupCode = jobGroupCode;
	}

	public long getCompanyId() {
		return companyId;
	}

	public String getJobGroupCode() {
		return jobGroupCode;
	}
}