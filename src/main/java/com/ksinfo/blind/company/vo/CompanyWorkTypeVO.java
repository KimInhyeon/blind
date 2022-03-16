package com.ksinfo.blind.company.vo;

public class CompanyWorkTypeVO {
    //private final String workTypeId;
    //private final String workTypeCode;
    private final String workTypeName;

    public CompanyWorkTypeVO(String workTypeName){
        this.workTypeName = workTypeName;
    }

    public String getWorkTypeName(){
        return workTypeName;
    }
}
