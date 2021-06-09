package com.ksinfo.blind.search.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.search.mapper.SearchMapper;

@Service 
public class SearchService {

	/*TestService.java 예제 샘플
	@Autowired 
	public TestMapper mapper; 
	
	public List<TestDto> findTestData() {   TestDto.java의 선언참고.
		return mapper.findTestData();       testMapper.xml의 <select id="id명" ~~~> 부분을 참고
	} 
	*/
	
	@Autowired 
	public SearchMapper mapper; 
	
	public List<TestDto> showTestSQL() { 
		return mapper.showTestSQL();         //  testMapper.xml의 <select id="id명" ~~~> 부분을 참고
	} 
	
}


