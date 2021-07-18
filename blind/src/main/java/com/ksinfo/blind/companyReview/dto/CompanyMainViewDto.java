package com.ksinfo.blind.companyReview.dto;

public class CompanyMainViewDto {
	private long companyId;
	private String companyName;
	private int allPoint;
	private float realAllPoint;
	public float getRealAllPoint() {
		return realAllPoint;
	}
	public void setRealAllPoint(float realAllPoint) {
		this.realAllPoint = realAllPoint;
	}
	public long getCompanyId() {
		return companyId;
	}
	public void setCompanyId(long companyId) {
		this.companyId = companyId;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public int getAllPoint() {
		return allPoint;
	}
	public void setAllPoint(int allPoint) {
		this.allPoint = allPoint;
	}
}
