package com.ksinfo.blind.company.vo;

public final class CompanySearchVO {
	private final long companyId;
	private final String companyName;

	public CompanySearchVO(long companyId, String companyName) {
		this.companyId = companyId;
		this.companyName = companyName;
	}

	public long getCompanyId() {
		return companyId;
	}

	public String getCompanyName() {
		return companyName;
	}
}