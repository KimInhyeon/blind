package com.ksinfo.blind.annualIncome.dto;

public class CompanyDto {
	//4.COMPANY_MGT
	private int companyId;		//company_id bigint GENERATED ALWAYS AS IDENTITY
	private int userId;			//user_id bigint not null						
	private String companyName;  	//company_name character varying(50) not null
	private String businessTypeCode;	// business_type_code character(2)
	private String companyAddress;	// company_address character varying(200)
	
	public int getCompanyId() {
		return companyId;
	}
	public void setCompanyId(int companyId) {
		this.companyId = companyId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getBusinessTypeCode() {
		return businessTypeCode;
	}
	public void setBusinessTypeCode(String businessTypeCode) {
		this.businessTypeCode = businessTypeCode;
	}
	public String getCompanyAddress() {
		return companyAddress;
	}
	public void setCompanyAddress(String companyAddress) {
		this.companyAddress = companyAddress;
	}


}

