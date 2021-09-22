package com.ksinfo.blind.common.vo;

public final class SearchCompanyVO {
	private final long companyId;
	private final String companyName;
	private final String companyAddress;
	private final Float allPointAvg;
	private final Float allPoint;
	private final String jobGroupName;
	private final String simpleComment;
	private final String disadvantages;

	public SearchCompanyVO(
		long companyId, String companyName, String companyAddress, Float allPointAvg,
		Float allPoint, String jobGroupName, String simpleComment, String disadvantages
	) {
		this.companyId = companyId;
		this.companyName = companyName;
		this.companyAddress = companyAddress;
		this.allPointAvg = allPointAvg;
		this.allPoint = allPoint;
		this.jobGroupName = jobGroupName;
		this.simpleComment = simpleComment;
		this.disadvantages = disadvantages;
	}

	public long getCompanyId() {
		return companyId;
	}

	public String getCompanyName() {
		return companyName;
	}

	public String getCompanyAddress() {
		return companyAddress;
	}

	public Float getAllPointAvg() {
		return allPointAvg;
	}

	public Float getAllPoint() {
		return allPoint;
	}

	public String getJobGroupName() {
		return jobGroupName;
	}

	public String getSimpleComment() {
		return simpleComment;
	}

	public String getDisadvantages() {
		return disadvantages;
	}

	@Override
	public String toString() {
		return "SearchCompanyVO{" +
				"companyId=" + companyId +
				", companyName='" + companyName + '\'' +
				", companyAddress='" + companyAddress + '\'' +
				", allPointAvg=" + allPointAvg +
				", allPoint=" + allPoint +
				", jobGroupName='" + jobGroupName + '\'' +
				", simpleComment='" + simpleComment + '\'' +
				", disadvantages='" + disadvantages + '\'' +
				'}';
	}
}