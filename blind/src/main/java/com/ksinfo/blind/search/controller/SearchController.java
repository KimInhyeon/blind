package com.ksinfo.blind.search.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.search.dto.CompanyDto;
import com.ksinfo.blind.search.dto.CompanyReviewDto;
import com.ksinfo.blind.search.dto.PostDto;
import com.ksinfo.blind.search.dto.SearchDto;
import com.ksinfo.blind.search.service.SearchService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestParam;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@Controller
public class SearchController {
	
	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);

	@Autowired SearchService searchService;  // SearchService.java에서 선언된 DB의 자료형  
	
	
	@RequestMapping("/search")  
	public ModelAndView search(String searchKeyword, ModelAndView mav){	
		logger.info("SearchController-search 시작");	
		
		logger.info("데이터준비 1단계. postgreDB에게 정보를 받음.");	
		List<CompanyDto> searchResultCompany = searchService.getSearchCompany(searchKeyword);
		List<CompanyReviewDto> companyReviews = searchService.getCompanyReviews(searchKeyword);	
		List<PostDto> searchResultPosts = searchService.getSearchPosts(searchKeyword);					

		
		logger.info("데이터준비 2단계.드롭버튼(토픽선택)의 카운트");	
		//[문의] 컨트롤러내에서 카운트 하기보다는 SQL로 하는 것 나은지 여부 
		int countPostAll=0;
		int countPostofBoard1=0;
		int countPostofBoard2=0;
		int countPostofBoard3=0;
		int countPostofBoard4=0;
		
		for(int i=0; i < searchResultPosts.size() ; i++) {
			countPostAll++;
			
			if(searchResultPosts.get(i).getBoardId().equals("1") ) {
				countPostofBoard1++;
			}
			else if(searchResultPosts.get(i).getBoardId().equals("2") ) {
				countPostofBoard2++;
			}
			else if(searchResultPosts.get(i).getBoardId().equals("3") ) {
				countPostofBoard3++;
			}
			else if(searchResultPosts.get(i).getBoardId().equals("4") ) {
				countPostofBoard4++;
			}
		}

		
		logger.info("데이터준비 3단계. mav에게 searchResultPosts가 받은 정보를 입력. 웹페이지에 출력할 수 있도록 실시.");		
		mav.addObject("searchResultCompany",searchResultCompany);
		mav.addObject("searchResultPosts",searchResultPosts);
		mav.addObject("companyReviews",companyReviews);
		
		
		mav.addObject("pastSearchKeyword", searchKeyword); //이전의 검색어.
		mav.addObject("countPostAll", countPostAll);
		mav.addObject("countPostofBoard1", countPostofBoard1);
		mav.addObject("countPostofBoard2", countPostofBoard2);
		
		
		//mav.addObject("sample",searchResultPosts.get(0).getPostTitle());

		logger.info("출력할 경로 설정.");		
		mav.setViewName("main/search/search");
		return mav;	

	}
	/*[참고] 로거에 데이터값 출력하는 방법.
	List<SearchDto> searchResultCompany = searchService.getCompanyProfile();	//Mapper.java를 통해 mapper.xml과 연계, DB로부터 데이터 로트간,ㅇ
	mav.addObject("boardTopicName", searchResultCompany.get(0).getBoardTopicName()); //searchList가 DB에게 받은 정보를 mav에게도 공유.
	Map<String,Object> testMap = new HashMap<String,Object>();
	testMap = mav.getModel();
	String test1007 = testMap.get("boardTopicName").toString();
	logger.info("boardTopicName : " + test1007 );
	*/
}
