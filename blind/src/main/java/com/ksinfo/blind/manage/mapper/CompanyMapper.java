package com.ksinfo.blind.manage.mapper;

import com.ksinfo.blind.manage.vo.CompanySearchVO;
import com.ksinfo.blind.manage.vo.CompanyVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface CompanyMapper {

	int getTotalRecordsCount(CompanySearchVO companySearchVO);

	List<CompanyVO> getCompanyList(RowBounds rowBounds, CompanySearchVO companySearchVO);
}