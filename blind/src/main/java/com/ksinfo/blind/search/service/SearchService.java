package com.ksinfo.blind.search.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.search.dto.CompanyDto;
import com.ksinfo.blind.search.dto.PostDto;
import com.ksinfo.blind.search.dto.SearchDto;
import com.ksinfo.blind.search.mapper.SearchMapper;

@Service 
public class SearchService {

	//출력시 페이징 관연을 위해 필요.
	private final int countPerPage = 10;
	private final int pagePerGroup = 5;
	
	@Autowired 
	public SearchMapper mapper;  //SearchMapper.java
	
	public List<CompanyDto> getSearchCompany() { 
		return mapper.getSearchCompany();     //searchMapper.java mapper확ㅈ
	}
	public List<PostDto>  getSearchPosts() { 
		return mapper.getSearchPosts();     //searchMapper.java mapper확ㅈ
	}
}


