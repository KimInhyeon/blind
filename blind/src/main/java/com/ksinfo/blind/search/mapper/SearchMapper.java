package com.ksinfo.blind.search.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.search.dto.CompanyDto;
import com.ksinfo.blind.search.dto.CompanyReviewDto;
import com.ksinfo.blind.search.dto.PostDto;
import com.ksinfo.blind.search.dto.SearchDto;

@Repository
@Mapper 
public interface SearchMapper {
	//(1)���� ���   -> mapper�� ���� �ǽ��� SQL���� �̸��� ����.
	List<CompanyDto>getSearchCompany();  //searchMapper.xml���� xml�� selectid�� ���Ͻ�Ų��.	
	List<PostDto> getSearchPosts(); 
	List<CompanyReviewDto> getCompanyReviews();

	//(2)â�ִ԰�� ->������ ����� ������ ī��Ʈ
	//int getTotalRecordsCount(CompanySearchVO companySearchVO); //CompanySearchVO.java�� ���� ��ü ����. ������ ������ �𸣰ڴ�.
	//List<CompanyVO>getCompanyList(RowBounds rowBounds, CompanySearchVO companySearchVO);
}
