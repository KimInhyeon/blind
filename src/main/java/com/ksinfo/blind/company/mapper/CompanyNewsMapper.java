package com.ksinfo.blind.company.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface CompanyNewsMapper {
	@Select("SELECT company_name FROM blind.company_mgt WHERE company_id = #{companyId} AND verify_flag = '1' AND logical_del_flag = '0';")
	String getCompanyName(long companyId);
}