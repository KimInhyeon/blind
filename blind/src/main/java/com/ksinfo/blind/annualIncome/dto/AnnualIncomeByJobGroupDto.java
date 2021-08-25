package com.ksinfo.blind.annualIncome.dto;

public class AnnualIncomeByJobGroupDto {
	private String jobGroupCode;	//, job_group_code character(2) not null
	private int minAnnualIncome;	//직군별 최저임금
	private int avgAnnualIncome;	//직군별 평균임금
	private int maxAnnualIncome;	//직군별 최대임금


	public String getJobGroupCode() {
		return jobGroupCode;
	}
	public void setJobGroupCode(String jobGroupCode) {
		this.jobGroupCode = jobGroupCode;
	}
	public int getMinAnnualIncome() {
		return minAnnualIncome;
	}
	public void setMinAnnualIncome(int minAnnualIncome) {
		this.minAnnualIncome = minAnnualIncome;
	}
	public int getAvgAnnualIncome() {
		return avgAnnualIncome;
	}
	public void setAvgAnnualIncome(int avgAnnualIncome) {
		this.avgAnnualIncome = avgAnnualIncome;
	}
	public int getMaxAnnualIncome() {
		return maxAnnualIncome;
	}
	public void setMaxAnnualIncome(int maxAnnualIncome) {
		this.maxAnnualIncome = maxAnnualIncome;
	}


}