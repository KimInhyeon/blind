package com.ksinfo.blind.search.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.search.dto.SearchDto;
import com.ksinfo.blind.search.mapper.SearchMapper;

@Service 
public class SearchService {

	
	@Autowired 
	public SearchMapper mapper;  //SearchMapper.java
	
	
	//테스트용으로 임시생성. 차훼 삭제할 것.
	public List<SearchDto>  getBoard_topic_name() { 
		return mapper.getBoard_topic_name();      //testMapper.xml의 <select id="id명" ~~~> 부분을 참고
	}
	
	
	
	//테스트용으로 임시생성. 차훼 삭제할 것.
	public List<SearchDto>  getBoard_topic_name_test() { 
		return mapper.getBoard_topic_name_test();      //testMapper.xml의 <select id="id명" ~~~> 부분을 참고
	}
}


