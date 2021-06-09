package com.ksinfo.blind.search.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.test.dto.TestDto;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller

public class SearchController {

	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);
	@RequestMapping("/test_sqlView")
    public String test_postgreDataSelect() {
		logger.info("postgre SQL 출력 테스트 페이지 이동");
	return "/search/test_sqlView";
	}    
    /*
	@RequestMapping(value = "/search", method = RequestMethod.GET)
    public String search(Model model)
    	 {	
    			logger.info("검색결과 출력페이지");
    			int total= dao.noticeSelectCount(searchText);
    			
    			//페이징 담당자, navi!!!
    			PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
    			
    			//[페이징 않을경우] // ArrayList<Notice> list = dao.noticeSelectList();
    			//검색어가 잇을 경우 searchText의 내용에 따라 검색이 진행됩니다.
    			ArrayList<Notice> list = dao.noticeSelectList(searchText, navi.getStartRecord(), navi.getCountPerPage());
    			model.addAttribute("list", list);
    			model.addAttribute("navi", navi);			
    			model.addAttribute("searchText", searchText);	//검색후 페이지 이동해도 값을 유지하도록 실시.
    			
    			logger.info("noticeList(Model model) model :{}",model);

    			return "notice/noticeList";
    	}
        
    }*/
}



