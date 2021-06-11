package com.ksinfo.blind.search.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.ksinfo.blind.search.dto.SearchDto;
import com.ksinfo.blind.search.service.SearchService;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@Controller
public class SearchController {

	@Autowired SearchService searchService;
	
	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);

	@RequestMapping("/search")
	public ModelAndView search(HttpSession session, ModelAndView mav) throws Exception{
		logger.info("SearchController-search 시작");	
		
		
		List<SearchDto> searchList_topic = searchService.getBoard_topic_name();
		logger.info("List<SearchDto> searchList 선언");
		//List<SearchDto> searchList_company = searchService.getBoard_topic_name();
		//logger.info("List<SearchDto> searchList 선언");
		
		
		mav.addObject("testMessage_searchList", searchList_topic.get(0).getBoardTopicName());
		
		mav.setViewName("main/search/search");
		logger.info("검색결과 출력페이지로 이동");	
		return mav;

	
	}

	@RequestMapping("/test_sqlView")
    public ModelAndView test_postgreDataSelect(HttpSession session, ModelAndView mav) throws Exception{
		logger.info("SearchController-test_postgreDataSelect ");
//		ModelAndView mav = new ModelAndView(); //ModelAndView : 모델->view(유저화면)으로 데이터를 이동
		logger.info("mav : ",mav);

		//SearchService.java의 설정체크 필요.
		List<SearchDto> searchList = searchService.getBoard_topic_name_test();
		logger.info("searchList : ",searchList);
		
		mav.addObject("testMessage_searchList", searchList.get(0).getBoardTopicName());
		//[문의드릴부분] java.lang.NullPointerException: null 에러로 발생.
		logger.info("mav-addObject결과 : ",mav);
		mav.setViewName("main/search/test_sqlView");
		
		logger.info("postgre SQL 출력 테스트 페이지 이동");
		return mav;
	}
}
