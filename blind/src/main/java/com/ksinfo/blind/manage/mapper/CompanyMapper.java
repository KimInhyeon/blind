package com.ksinfo.blind.manage.mapper;

import com.ksinfo.blind.manage.vo.BusinessTypeVO;
import com.ksinfo.blind.manage.vo.CompanySearchVO;
import com.ksinfo.blind.manage.vo.CompanyVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface CompanyMapper {

	int getTotalRecordsCount(CompanySearchVO companySearchVO);

	List<CompanyVO> getCompanyList(RowBounds rowBounds, CompanySearchVO companySearchVO);

	List<BusinessTypeVO> getBusinessTypeList();

	int applyCompany(Map<String, Object> company);

	int updateCompany(Map<String, Object> data);

	int updateVerify(Map<String, Object> data);
}