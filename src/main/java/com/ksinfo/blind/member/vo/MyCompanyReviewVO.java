package com.ksinfo.blind.member.vo;

public final class MyCompanyReviewVO {
	private final long companyReviewId;
	private final String companyName;
	private final String recCreateDate;
	private final char completeFlag;

	public MyCompanyReviewVO(long companyReviewId, String companyName, String recCreateDate, char completeFlag) {
		this.companyReviewId = companyReviewId;
		this.companyName = companyName;
		this.recCreateDate = recCreateDate;
		this.completeFlag = completeFlag;
	}

	public long getCompanyReviewId() {
		return companyReviewId;
	}

	public String getCompanyName() {
		return companyName;
	}

	public String getRecCreateDate() {
		return recCreateDate;
	}

	public char getCompleteFlag() {
		return completeFlag;
	}
}