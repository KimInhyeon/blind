package com.ksinfo.blind.search.dto;

public class CompanyDto {
	//4.COMPANY_MGT 기업관리 테이블 생성
	private String companyId;		//company_id bigint GENERATED ALWAYS AS IDENTITY
	private String userId;			//user_id bigint not null						
	private String companyName;  	//company_name character varying(50) not null
	private String businessTypeCode;	// business_type_code character(2)
	private String companyAddress;	// company_address character varying(200)
	private String verifyFlag;		// verify_flag character(1) not null
	private String closingFlag;		// closing_flag character(1) not null
	
	
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
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
	public String getVerifyFlag() {
		return verifyFlag;
	}
	public void setVerifyFlag(String verifyFlag) {
		this.verifyFlag = verifyFlag;
	}
	public String getClosingFlag() {
		return closingFlag;
	}
	public void setClosingFlag(String closingFlag) {
		this.closingFlag = closingFlag;
	}

	//4.COMPANY_MGT 기업관리 테이블 생성	


}

