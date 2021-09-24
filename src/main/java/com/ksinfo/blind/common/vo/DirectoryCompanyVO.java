package com.ksinfo.blind.common.vo;

public final class DirectoryCompanyVO {
	private final long companyId;
	private final String companyName;

	public DirectoryCompanyVO(long companyId, String companyName) {
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