package com.ksinfo.blind.manage.dto;

public final class ReviewVerifyDto {
	private long userId;
	private final char verifyFlag;
	private final String reason;
	private final long[] reviewIdList;

	public ReviewVerifyDto(char verifyFlag, String reason, long[] reviewIdList) {
		switch (verifyFlag) {
			case '1':
			case '2':
				this.verifyFlag = verifyFlag;
				break;
			default:
				this.verifyFlag = '2';
				break;
		}
		this.reason = reason;
		this.reviewIdList = reviewIdList;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public long getUserId() {
		return userId;
	}

	public char getVerifyFlag() {
		return verifyFlag;
	}

	public String getReason() {
		return reason;
	}

	public long[] getReviewIdList() {
		return reviewIdList;
	}
}