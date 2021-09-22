package com.ksinfo.blind.search.dto;

public class CompanyDto {
	//4.COMPANY_MGT 기업관리 테이블 생성
	private int companyId; //company_id bigint GENERATED ALWAYS AS IDENTITY
	private String companyName; //company_name character varying(50) not null
	private String businessTypeCode; // business_type_code character(2)
	private String companyAddress; // company_address character varying(200)
	private float allPointAvg;		//총점평균(특정기업에 대한 n명의 총평점의 평균점수. 특정1인의 총평점이 아님.)

	public float getAllPointAvg() {
		return allPointAvg;
	}

	public void setAllPointAvg(float allPoint) {
		this.allPointAvg = allPoint;
	}

	public int getCompanyId() {
		return companyId;
	}

	public void setCompanyId(int companyId) {
		this.companyId = companyId;
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