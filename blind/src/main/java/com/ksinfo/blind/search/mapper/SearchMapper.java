package com.ksinfo.blind.search.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.search.dto.SearchDto;

@Repository
@Mapper 
public interface SearchMapper {
	//(1)���� ���   -> mapper�� ���� �ǽ��� SQL���� �̸��� ����.
	List<SearchDto> getCompanyProfile();  //searchMapper.xml���� xml�� selectid�� ���Ͻ�Ų��.
	List<SearchDto> getBoard_topic_name_test(); 


	//(2)â�ִ԰�� ->������ ����� ������ ī��Ʈ
	//int getTotalRecordsCount(CompanySearchVO companySearchVO); //CompanySearchVO.java�� ���� ��ü ����. ������ ������ �𸣰ڴ�.
	//List<CompanyVO>getCompanyList(RowBounds rowBounds, CompanySearchVO companySearchVO);
}
