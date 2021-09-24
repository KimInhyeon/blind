package com.ksinfo.blind.company.vo;

public final class CompanyIntroductionVO {
	private final long companyId;
	private final String companyName;
	private final String companyHomepage;
	private final String businessTypeName;
	private final String companyAddress;
	private final String foundingDate;
	private final String workersCount;
	private final String companyExplain;

	public CompanyIntroductionVO(
		long companyId, String companyName, String companyHomepage, String businessTypeName,
		String companyAddress, String foundingDate, String workersCount, String companyExplain
	) {
		this.companyId = companyId;
		this.companyName = companyName;
		this.companyHomepage = companyHomepage;
		this.businessTypeName = businessTypeName;
		this.companyAddress = companyAddress;
		this.foundingDate = foundingDate;
		this.workersCount = workersCount;
		this.companyExplain = companyExplain;
	}

	public long getCompanyId() {
		return companyId;
	}

	public String getCompanyName() {
		return companyName;
	}

	public String getCompanyHomepage() {
		return companyHomepage;
	}

	public String getBusinessTypeName() {
		return businessTypeName;
	}

	public String getCompanyAddress() {
		return companyAddress;
	}

	public String getFoundingDate() {
		return foundingDate;
	}

	public String getWorkersCount() {
		return workersCount;
	}

	public String getCompanyExplain() {
		return companyExplain;
	}
}