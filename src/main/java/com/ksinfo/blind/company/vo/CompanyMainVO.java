package com.ksinfo.blind.company.vo;

public final class CompanyMainVO {
	private final long companyId;
	private final String companyName;
	private final int allPoint;
	private final float realAllPoint;

	public CompanyMainVO(long companyId, String companyName, int allPoint, float realAllPoint) {
		this.companyId = companyId;
		this.companyName = companyName;
		this.allPoint = allPoint;
		this.realAllPoint = realAllPoint;
	}

	public long getCompanyId() {
		return companyId;
	}

	public String getCompanyName() {
		return companyName;
	}

	public int getAllPoint() {
		return allPoint;
	}

	public float getRealAllPoint() {
		return realAllPoint;
	}
}