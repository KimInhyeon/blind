package com.ksinfo.blind.search.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.ksinfo.blind.search.dto.SearchDto;
import com.ksinfo.blind.search.service.SearchService;

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
	public ModelAndView search(String searchTarget,String searchKeyword, ModelAndView mav,
		@RequestParam(name="curentPage",  defaultValue="1") int currentPage,
		@RequestParam(name="vertifyFlag", defaultValue="0") byte vertifyFlag,
		@RequestParam(name="closingFlag", defaultValue="0") byte closingFlag) throws Exception
	{	
		logger.info("SearchController-search 시작");	

		logger.info("1단계. searchCompany 선언 및 DB에게 정보를 받음.");		
		List<SearchDto> searchCompany = searchService.getCompanyProfile();	//Mapper.java를 통해 mapper.xml과 연계, DB로부터 데이터 로트간,ㅇ
		
		logger.info("2단계. mav에게 searchCompany가 받은 정보를 입력. 웹페이지에 출력할 수 있도록 실시.");				
		mav.addObject("boardTopicName", searchCompany.get(0).getBoardTopicName()); //searchList가 DB에게 받은 정보를 mav에게도 공유.
		Map<String,Object> testMap = new HashMap<String,Object>();
		testMap = mav.getModel();
		String test1007 = testMap.get("boardTopicName").toString();
		logger.info("boardTopicName : " + test1007 );
		//위의 테스트코드 작동됨 확인하면 아래의 회사자료부터 로딩되도록 할 예정.
		//mav.addObject("companyName", searchCompany.get(0).getCompanyCompanyName());
		//mav.addObject("companyAddress", searchCompany.get(0).getCompanyCompanyAddress());

		
				
		logger.info("3단계. 출력할 경로 설정.");		
		mav.setViewName("main/search/search");
		return mav;	
	}
	

	@RequestMapping("/test_sqlView")
    public ModelAndView test_postgreDataSelect(HttpSession session, ModelAndView mav) throws Exception{
		logger.info("SearchController-test_postgreDataSelect ");

		
		List<SearchDto> searchList = searchService.getBoard_topic_name_test();
		mav.addObject("testMessage_searchList", searchList.get(0).getBoardTopicName()); //searchList가 DB에게 받은 정보를 mav에게도 공유.
		mav.setViewName("main/search/test_sqlView");

		return mav;
	}
}
