package com.ksinfo.blind.company.vo;

public final class CompanyMenuVO {
	private final long companyId;
	private final String companyName;
	private final float allPointAvg;
	private final int reviewCount;

	public CompanyMenuVO(long companyId, String companyName, float allPointAvg, int reviewCount) {
		this.companyId = companyId;
		this.companyName = companyName;
		this.allPointAvg = allPointAvg;
		this.reviewCount = reviewCount;
	}

	public long getCompanyId() {
		return companyId;
	}

	public String getCompanyName() {
		return companyName;
	}

	public float getAllPointAvg() {
		return allPointAvg;
	}

	public int getReviewCount() {
		return reviewCount;
	}
}