package com.ksinfo.blind.companyIntroduction.dto;

public class CompanyAverageDto {
	public long getCompanyReviewId() {
		return companyReviewId;
	}
	public void setCompanyReviewId(long companyReviewId) {
		this.companyReviewId = companyReviewId;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public long getCompanyId() {
		return companyId;
	}
	public void setCompanyId(long companyId) {
		this.companyId = companyId;
	}
	public String getJobGroupCode() {
		return jobGroupCode;
	}
	public void setJobGroupCode(String jobGroupCode) {
		this.jobGroupCode = jobGroupCode;
	}
	public float getAllPoint() {
		return allPoint;
	}
	public void setAllPoint(float allPoint) {
		this.allPoint = allPoint;
	}
	public float getCareerPoint() {
		return careerPoint;
	}
	public void setCareerPoint(float careerPoint) {
		this.careerPoint = careerPoint;
	}
	public float getWorkLifeBalancePoint() {
		return workLifeBalancePoint;
	}
	public void setWorkLifeBalancePoint(float workLifeBalancePoint) {
		this.workLifeBalancePoint = workLifeBalancePoint;
	}
	public float getPayPoint() {
		return payPoint;
	}
	public void setPayPoint(float payPoint) {
		this.payPoint = payPoint;
	}
	public float getCompanyCulturePoint() {
		return companyCulturePoint;
	}
	public void setCompanyCulturePoint(float companyCulturePoint) {
		this.companyCulturePoint = companyCulturePoint;
	}
	public float getHeadPoint() {
		return headPoint;
	}
	public void setHeadPoint(float headPoint) {
		this.headPoint = headPoint;
	}
	public float getRealAllPoint() {
		return realAllPoint;
	}
	public void setRealAllPoint(float realAllPoint) {
		this.realAllPoint = realAllPoint;
	}
	public String getWorkStartDate() {
		return workStartDate;
	}
	public void setWorkStartDate(String workStartDate) {
		this.workStartDate = workStartDate;
	}
	public String getWorkEndDate() {
		return workEndDate;
	}
	public void setWorkEndDate(String workEndDate) {
		this.workEndDate = workEndDate;
	}
	public String getSimpleComment() {
		return simpleComment;
	}
	public void setSimpleComment(String simpleComment) {
		this.simpleComment = simpleComment;
	}
	public String getResignReason() {
		return resignReason;
	}
	public void setResignReason(String resignReason) {
		this.resignReason = resignReason;
	}
	public String getWorkArea() {
		return workArea;
	}
	public void setWorkArea(String workArea) {
		this.workArea = workArea;
	}
	public String getAdvantages() {
		return advantages;
	}
	public void setAdvantages(String advantages) {
		this.advantages = advantages;
	}
	public String getDisadvantages() {
		return disadvantages;
	}
	public void setDisadvantages(String disadvantages) {
		this.disadvantages = disadvantages;
	}
	public char getVerifyFlag() {
		return verifyFlag;
	}
	public void setVerifyFlag(char verifyFlag) {
		this.verifyFlag = verifyFlag;
	}
	public char getCompleteFlag() {
		return completeFlag;
	}
	public void setCompleteFlag(char completeFlag) {
		this.completeFlag = completeFlag;
	}
	private long companyReviewId;
	private long userId;
	private long companyId;
	private String jobGroupCode;
	private float allPoint;
	private float careerPoint;
	private float workLifeBalancePoint;
	private float payPoint;
	private float companyCulturePoint;
	private float headPoint;
	private float realAllPoint;
	private String workStartDate;
	private String workEndDate;
	private String simpleComment;
	private String resignReason;
	private String workArea;
	private String advantages;
	private String disadvantages;
	private char verifyFlag;
	private char completeFlag;
}
