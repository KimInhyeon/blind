package com.ksinfo.blind.search.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.search.dto.SearchDto;
import com.ksinfo.blind.search.mapper.SearchMapper;

@Service 
public class SearchService {

	//��½� ����¡ ������ ���� �ʿ�.
	private final int countPerPage = 10;
	private final int pagePerGroup = 5;
	
	
	@Autowired 
	public SearchMapper mapper;  //SearchMapper.java
	
	
	public List<SearchDto>  getCompanyProfile() { 
		return mapper.getCompanyProfile();     //searchMapper.java mapperȮ��
	}
	

	public List<SearchDto>  getBoard_topic_name_test() { 
		return mapper.getBoard_topic_name_test(); 
	}
}


