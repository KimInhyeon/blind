package com.ksinfo.blind.manage.vo;

public final class CompanyReviewVO {
	private final String userNickname;
	private final String companyName;
	private final String jobGroupName;
	private final String simpleComment;

	public CompanyReviewVO(String userNickname, String companyName, String jobGroupName, String simpleComment) {
		this.userNickname = userNickname;
		this.companyName = companyName;
		this.jobGroupName = jobGroupName;
		this.simpleComment = simpleComment;
	}

	public String getUserNickname() {
		return userNickname;
	}

	public String getCompanyName() {
		return companyName;
	}

	public String getJobGroupName() {
		return jobGroupName;
	}

	public String getSimpleComment() {
		return simpleComment;
	}
}