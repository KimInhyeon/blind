package com.ksinfo.blind.search.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class SearchController {

	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);

	@RequestMapping("/test_sqlView")
    public String test_postgreDataSelect() {
		logger.info("postgre SQL 출력 테스트 페이지 이동");
	return "main/test_sqlView";
	}

	@RequestMapping("/search")
	public String search() {
		logger.info("검색결과를 출력");
	return "main/search";
	}
}
