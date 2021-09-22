package com.ksinfo.blind.company.dto;

public final class CompanyReviewWriteDto {
	private long userId;
	private final long companyId;
	private String jobGroupCode;
	private final float allPoint;
	private final byte careerPoint;
	private final byte workLifeBalancePoint;
	private final byte payPoint;
	private final byte companyCulturePoint;
	private final byte headPoint;
	private final String workStartDate;
	private final String workEndDate;
	private final String simpleComment;
	private final String resignReason;
	private final String workArea;
	private final String advantages;
	private final String disadvantages;

	public CompanyReviewWriteDto(
		long companyId, String jobGroupCode, byte careerPoint, byte workLifeBalancePoint,
		byte payPoint, byte companyCulturePoint, byte headPoint, String workStartDate, String workEndDate,
		String simpleComment, String resignReason, String workArea, String advantages, String disadvantages
	) {
		this.companyId = companyId;
		allPoint = (float) (careerPoint + workLifeBalancePoint + payPoint + companyCulturePoint + headPoint) / 5;
		this.jobGroupCode = jobGroupCode;
		this.careerPoint = careerPoint;
		this.workLifeBalancePoint = workLifeBalancePoint;
		this.payPoint = payPoint;
		this.companyCulturePoint = companyCulturePoint;
		this.headPoint = headPoint;
		this.workStartDate = workStartDate;
		this.workEndDate = workEndDate;
		this.simpleComment = simpleComment;
		this.resignReason = resignReason;
		this.workArea = workArea;
		this.advantages = advantages;
		this.disadvantages = disadvantages;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public void setJobGroupCode(String jobGroupCode) {
		this.jobGroupCode = jobGroupCode;
	}

	public long getUserId() {
		return userId;
	}

	public long getCompanyId() {
		return companyId;
	}

	public String getJobGroupCode() {
		return jobGroupCode;
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

	public byte getPayPoint() {
		return payPoint;
	}

	public byte getCompanyCulturePoint() {
		return companyCulturePoint;
	}

	public byte getHeadPoint() {
		return headPoint;
	}

	public String getWorkStartDate() {
		return workStartDate;
	}

	public String getWorkEndDate() {
		return workEndDate;
	}

	public String getSimpleComment() {
		return simpleComment;
	}

	public String getResignReason() {
		return resignReason;
	}

	public String getWorkArea() {
		return workArea;
	}

	public String getAdvantages() {
		return advantages;
	}

	public String getDisadvantages() {
		return disadvantages;
	}

	@Override
	public String toString() {
		return "CompanyReviewWriteDto{" +
				"userId=" + userId +
				", companyId=" + companyId +
				", jobGroupCode='" + jobGroupCode + '\'' +
				", allPoint=" + allPoint +
				", careerPoint=" + careerPoint +
				", workLifeBalancePoint=" + workLifeBalancePoint +
				", payPoint=" + payPoint +
				", companyCulturePoint=" + companyCulturePoint +
				", headPoint=" + headPoint +
				", workStartDate='" + workStartDate + '\'' +
				", workEndDate='" + workEndDate + '\'' +
				", simpleComment='" + simpleComment + '\'' +
				", resignReason='" + resignReason + '\'' +
				", workArea='" + workArea + '\'' +
				", advantages='" + advantages + '\'' +
				", disadvantages='" + disadvantages + '\'' +
				'}';
	}
}