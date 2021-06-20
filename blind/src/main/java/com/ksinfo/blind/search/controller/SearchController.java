package com.ksinfo.blind.search.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.search.dto.BoardDto;
import com.ksinfo.blind.search.dto.BookmarkDto;
import com.ksinfo.blind.search.dto.CompanyDto;
import com.ksinfo.blind.search.dto.CompanyReviewDto;
import com.ksinfo.blind.search.dto.PostCountInfDto;
import com.ksinfo.blind.search.dto.PostDto;
import com.ksinfo.blind.search.dto.ReplyDto;
import com.ksinfo.blind.search.dto.SearchDto;
import com.ksinfo.blind.search.dto.UserDto;
import com.ksinfo.blind.search.service.SearchService;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@Controller
public class SearchController {
	
	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);

	@Autowired SearchService searchService;  // SearchService.java에서 선언된 DB의 자료형  
	

	@RequestMapping(value = "bookmarkChanege", method = RequestMethod.GET)
	@ResponseBody 	
	public int bookmarkChanege() { //나중에 리턴형을 BookmarkDto으로 할지 여부 결정필요.
		//북마크 설정 mapper.xml을 통해 SQL 수정실시하도록 갱신예정.
		return 1; //성공시 flag 개념으로 1을 성공의 개념으로 리턴.
	}
	
	@RequestMapping(value = "sortPosts", method = RequestMethod.POST)
	@ResponseBody 	
	public ModelAndView sortPosts(int sortPostOption, String searchKeyword,  ModelAndView mav){ //나중에 리턴형을 BookmarkDto으로 할지 여부 결정필요.
		logger.info("sortPosts");
		logger.info("sortPostOption : "+sortPostOption + "searchKeyword : "+searchKeyword);
		List<PostDto> searchResultPosts  = new ArrayList<>();  //검색을 재실시 한 다음 
		
		switch(sortPostOption) {
			case 1 :
				searchResultPosts = searchService.getsortPostBylatestDate(searchKeyword);	//검색을 재실시 한 다음 
				mav.addObject("searchResultPosts", searchResultPosts);					
				logger.info("sortPosts 리턴 데이터 설정.");		
				break;
				
			case 2 :  break;
			default : break;
		}

		mav.setViewName("main/search/search");
		return mav;	
	}
	
	
	@RequestMapping("/search")  
	public ModelAndView search(String searchKeyword, ModelAndView mav){	
		logger.info("SearchController-search 시작");	
		
		logger.info("기업정보 관련 데이터 준비");	
		List<CompanyDto> searchResultCompany = searchService.getSearchCompany(searchKeyword);	//기업프로필
		List<CompanyReviewDto> companyReviews = searchService.getCompanyReviews(searchKeyword);	//기업에 대한 기업리뷰
		List<String> jobGroupNameOfCompanyReviewer = new ArrayList<>(); 						//기업리뷰-리뷰작성자의 직군명 정보 저장.
		
		
		logger.info("데이터준비 2단계. 회사정보여부 플래그");	
		int searchResultCompanyDataFlag=0; //값이 1일시 회사정보 있음
		if( !(searchResultCompany.isEmpty()) && !(searchResultCompany.get(0).getCompanyName().isEmpty())) { //!(searchResultCompany.isEmpty())가 0이다 회사정보가 있음.
			logger.info("확인결과: 회사정보 있음");	
			searchResultCompanyDataFlag=1;
		}
		else {
			logger.info("확인결과: 회사정보 없음");	
			searchResultCompanyDataFlag=0;
		}
		
		//기업리뷰를 작성한 사람의 직군명(jobGroupName)을 저장.
		for(int i=0; i<companyReviews.size() ;i++ ) {
			jobGroupNameOfCompanyReviewer.addAll(i, searchService.getJobGroupNameOfCompanyReviewer(companyReviews.get(i).getJobGroupCode()));
		}
		
		
		
		//포스트 작성자의 닉네임 및 근무기업, 추천수,댓글수는 관련INF테이블에서 로드 불가관계로 select 시 count 명령통해 카운트하여 리턴하는 형태로 진행.	
		List<PostDto> searchResultPosts = searchService.getSearchPosts(searchKeyword);				
		List<PostCountInfDto> viewCountOfPosts = new ArrayList<>(); //조회수(테이블 : POST_COUNT_INF)	 
		List<UserDto> writerDataOfPosts =  new ArrayList<>(); 		//post의 작성자의 정보 저장. jsp페이지에 닉네임 출력도 담당.
		List<String>  writerCompany =  new ArrayList<>();			//post 작성자의 근무회사 정보 저장.
		List<Integer> recommendCountOfPosts = new ArrayList<>();	//추천수(테이블 : POST_RECOMMEND_INF)
		List<Integer> replyCountOfPosts = new ArrayList<>(); 		//댓글수(각 포스트별 댓글 카운트.)
		
		//드롭버튼 관련 기능들
		List<BoardDto> boardTopicName = new ArrayList<>(); //토픽의 이름 수신
		List<Integer> boardTopicCount = new ArrayList<>(); //토픽별 포스트의 갯수 카운트(총갯수 제외)
		int	boardTopicCountOfAll=0;						   //토픽별 포스트의 총갯수 카운트
		//드롭버튼 토픽의 이름 집계
		for(int i=0; i<searchResultPosts.size() ;i++ ) {
			boardTopicName.addAll(i, searchService.getBoardTopicName(searchResultPosts.get(i).getBoardId()) );
		}
		//드롭버튼의 토픽별 포스트의 갯수 집계
		
		for(int i=0; i<searchResultPosts.size() ;i++ ) {
			boardTopicCount.addAll(i, searchService.getBoardTopicCount(searchResultPosts.get(i).getBoardId()) );
			boardTopicCountOfAll=boardTopicCountOfAll+boardTopicCount.get(i);
		}


		//포스트 목록 출력시 관련 정보수집
		
		//포스트를 작성한 유저의 닉네임과 근무하는 기업 정보를 로드.
		for(int i=0; i<searchResultPosts.size() ;i++ ) {
			writerDataOfPosts.addAll(i, searchService.getWriterDataOfPosts(Integer.parseInt(searchResultPosts.get(i).getUserId() )));
		}
		//포스트 작성자의 근무기업 정보를 저장.
		for(int i=0; i<searchResultPosts.size() ;i++ ) {
			writerCompany.addAll(i, searchService.getWriterCompany(Integer.parseInt(writerDataOfPosts.get(i).getCompanyId() )));
		}
		
		//각 포스트별 조회수 확인 
		for(int i=0; i<searchResultPosts.size() ;i++ ) {
	        viewCountOfPosts.addAll(i, searchService.getViewCountOfPosts(Integer.parseInt(searchResultPosts.get(i).getPostId()) ) );
		}
		//포스트별 추천수 카운트
		for(int i=0; i < searchResultPosts.size() ;i++ ) {
			recommendCountOfPosts.addAll(i, searchService.getReplyCountsOfPosts(Integer.parseInt(searchResultPosts.get(i).getPostId())) );			
		}		
		//포스트별 댓글수 카운트
		for(int i=0; i < searchResultPosts.size() ;i++ ) {
			replyCountOfPosts.addAll(i, searchService.getReplyCountsOfPosts(Integer.parseInt(searchResultPosts.get(i).getPostId())) );			
		}		
		
		
		logger.info("데이터준비 3단계. mav에게 searchResultPosts가 받은 정보를 입력. 웹페이지에 출력할 수 있도록 실시.");		
		//이전검색어 그대로 전달.
		mav.addObject("pastSearchKeyword", searchKeyword); //이전의 검색어.
		
		//1.기업정보 관련	
		mav.addObject("searchResultCompanyDataFlag",searchResultCompanyDataFlag); 		//기업정보 여부애 떠라 jsp페이지에서 기업정보관련 출력여부 결정.
 		mav.addObject("searchResultCompany",searchResultCompany); 						//기업정보를 갖는 오브젝트.
		mav.addObject("companyReviews",companyReviews);									//검색된 기업에 대한 기업리뷰
		mav.addObject("jobGroupNameOfCompanyReviewer",jobGroupNameOfCompanyReviewer);	//리뷰를 작성한 유저의 직군명
		
 		//2.포스트관련 정보
		//2.1 드롭다운버튼관련
		mav.addObject("boardTopicName",boardTopicName);			//검색어에 검색된 포스트들의 토픽(게시판) 이름들 저장.
		mav.addObject("boardTopicCountOfAll",boardTopicCountOfAll);
		mav.addObject("boardTopicCount",boardTopicCount);
			
		//2.2 포스트출력
		mav.addObject("searchResultPosts",searchResultPosts);			//검색어와 관련된 포스트(게시글)들 전달.
		mav.addObject("writerDataOfPosts",writerDataOfPosts);			//포스트 작성자의 닉네임 정보
		mav.addObject("writerCompany",writerCompany);			//포스트 작성자의 근무회사 정보		
		mav.addObject("viewCountOfPosts", viewCountOfPosts);			//각 포스트별 조회수 정보전달
		mav.addObject("recommendCountOfPosts",recommendCountOfPosts);	//각 포스트별 추천수 정보전달
		mav.addObject("replyCountOfPosts", replyCountOfPosts);			//각 포스트별 댓글수 정보전달
		
			
		logger.info("출력할 경로 설정.");		
		mav.setViewName("main/search/search");
		return mav;	

	}
}
