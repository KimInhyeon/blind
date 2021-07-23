package com.ksinfo.blind.manage.vo;

public final class ReviewVO {
	private final long companyReviewId;
	private final char verifyFlag;
	private final char completeFlag;
	private final char lastGenerationFlag;
	private final byte allPoint;
	private final String companyName;
	private final String jobGroupName;
	private final String simpleComment;
	private final String userNickname;
	private final String recCreateDate;

	public ReviewVO(
		long companyReviewId, char verifyFlag, char completeFlag, char lastGenerationFlag, byte allPoint,
		String companyName, String jobGroupName, String simpleComment, String userNickname, String recCreateDate
	) {
		this.companyReviewId = companyReviewId;
		this.verifyFlag = verifyFlag;
		this.completeFlag = completeFlag;
		this.lastGenerationFlag = lastGenerationFlag;
		this.allPoint = allPoint;
		this.companyName = companyName;
		this.jobGroupName = jobGroupName;
		this.simpleComment = simpleComment;
		this.userNickname = userNickname;
		this.recCreateDate = recCreateDate;
	}

	public long getCompanyReviewId() {
		return companyReviewId;
	}

	public char getVerifyFlag() {
		return verifyFlag;
	}

	public char getCompleteFlag() {
		return completeFlag;
	}

	public char getLastGenerationFlag() {
		return lastGenerationFlag;
	}

	public byte getAllPoint() {
		return allPoint;
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

	public String getUserNickname() {
		return userNickname;
	}

	public String getRecCreateDate() {
		return recCreateDate;
	}
}