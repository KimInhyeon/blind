package com.ksinfo.blind.company.vo;

public final class CompanyReviewVO {
	private final long companyReviewId;
	private final float allPoint;
	private final byte careerPoint;
	private final byte workLifeBalancePoint;
	private final byte companyCulturePoint;
	private final byte payPoint;
	private final byte headPoint;
	private final String simpleComment;
	private final boolean working;
	private final String userNickname;
	private final String jobGroupName;
	private final String recCreateDate;
	private final String advantages;
	private final String disadvantages;
	private final boolean recommended;
	private final int helpfulCount;

	public CompanyReviewVO(
		long companyReviewId, float allPoint, byte careerPoint, byte workLifeBalancePoint, byte companyCulturePoint,
		byte payPoint, byte headPoint, String simpleComment, boolean working, String userNickname, String jobGroupName,
		String recCreateDate, String advantages, String disadvantages, boolean recommended, int helpfulCount
	) {
		this.companyReviewId = companyReviewId;
		this.allPoint = allPoint;
		this.careerPoint = careerPoint;
		this.workLifeBalancePoint = workLifeBalancePoint;
		this.companyCulturePoint = companyCulturePoint;
		this.payPoint = payPoint;
		this.headPoint = headPoint;
		this.simpleComment = simpleComment;
		this.working = working;
		this.userNickname = userNickname;
		this.jobGroupName = jobGroupName;
		this.recCreateDate = recCreateDate;
		this.advantages = advantages;
		this.disadvantages = disadvantages;
		this.recommended = recommended;
		this.helpfulCount = helpfulCount;
	}

	public long getCompanyReviewId() {
		return companyReviewId;
	}

	public float getAllPoint() {
		return allPoint;
	}

	public byte getCareerPoint() {
		return careerPoint;
	}

	public byte getWorkLifeBalancePoint() {
		return workLifeBalancePoint;
	}

	public byte getCompanyCulturePoint() {
		return companyCulturePoint;
	}

	public byte getPayPoint() {
		return payPoint;
	}

	public byte getHeadPoint() {
		return headPoint;
	}

	public String getSimpleComment() {
		return simpleComment;
	}

	public boolean isWorking() {
		return working;
	}

	public String getUserNickname() {
		return userNickname;
	}

	public String getJobGroupName() {
		return jobGroupName;
	}

	public String getRecCreateDate() {
		return recCreateDate;
	}

	public String getAdvantages() {
		return advantages;
	}

	public String getDisadvantages() {
		return disadvantages;
	}

	public boolean isRecommended() {
		return recommended;
	}

	public int getHelpfulCount() {
		return helpfulCount;
	}
}