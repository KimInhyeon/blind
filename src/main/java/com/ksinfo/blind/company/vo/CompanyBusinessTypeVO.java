package com.ksinfo.blind.company.vo;

public class CompanyBusinessTypeVO {
    private String businessTypeName;
    private String businessTypeCode;

    public CompanyBusinessTypeVO(String businessTypeCode, String businessTypeName )
    {
        this.businessTypeCode = businessTypeCode;
        this.businessTypeName = businessTypeName;
    }

    public String getBusinessTypeCode() { return businessTypeCode; }
    public String getBusinessTypeName() { return businessTypeName; }
}
