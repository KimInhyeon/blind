package com.ksinfo.blind.company.mapper;

import com.ksinfo.blind.company.dto.CompanyPostSearchDto;
import com.ksinfo.blind.company.vo.CompanyPostVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface CompanyPostMapper {
	int getTotalCompanyPostRecord(CompanyPostSearchDto search);

	List<CompanyPostVO> getCompanyPostList(CompanyPostSearchDto search, RowBounds rowBounds);
}