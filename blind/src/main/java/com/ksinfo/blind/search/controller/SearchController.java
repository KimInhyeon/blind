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
import com.ksinfo.blind.search.dto.PostAlignDto;
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
	
	//포스트-1개의 토픽(board) 선택시 해당하는 게시판만 출력되도록 실행.
	@RequestMapping(value = "viewPostsOfOneTopic", method = RequestMethod.POST, produces="application/json")
	@ResponseBody 	
	public List<PostDto> viewPostsOfOneTopic(int selectBoardId, String searchKeyword ){ 
		logger.info("viewPostsOfOneTopic start");
		logger.info("selectBoardId : "+ selectBoardId + "  searchKeyword : "+searchKeyword);
		
		//List<PostDto> searchResultPosts = searchService.getSearchPosts(searchKeyword);	//게시글 제목 기준 검색

		if(selectBoardId ==-1) {//-1 : 전체선택
			List<PostDto> searchResultAllPosts= searchService.getSearchPosts(searchKeyword);	
			logger.info("viewPostsOfOneTopic-END(Returns searchResultAllPosts) ");
			return searchResultAllPosts;
		}
		else {
			List<PostDto> searchResultPostsOfOneTopic = searchService.getPostsOfOneTopic(selectBoardId, searchKeyword);			
			logger.info("viewPostsOfOneTopic-END(Returns searchResultPostsOfOneTopic) ");
			return searchResultPostsOfOneTopic;
		}

	}
	
	@RequestMapping(value = "sortPosts", method = RequestMethod.POST, produces="application/json")
	@ResponseBody 	
	public List<PostDto> sortPosts(int sortPostOption, String searchKeyword, int selectBoardId){ 
		logger.info("sortPosts 시작");
		logger.info("sortPostOption : "+sortPostOption + "   searchKeyword : "+searchKeyword + "   selectBoardId : " +selectBoardId);

		List<PostDto>  searchResultSortedPosts  = new ArrayList<>();  		//재검색을 실시하여 해당 SQL의 order by등이 적용된 출력.
		switch(sortPostOption) {	//추천순/최신일 순으로 구별.
			case 1 : // 1: 최신일
				// 정렬출력-최신일 기준으로 실시.
				// 모든 토픽(borad)들을 출력
				logger.info("sortPosts 리턴 데이터 설정.");	
				if(selectBoardId == -1){
					searchResultSortedPosts = searchService.getSortPostAllTopicBylatestDate(searchKeyword);
					return searchResultSortedPosts;	
				}
				else {
				// 정렬출력-최신일 기준으로 실시.
				// 1개의 토픽(borad)만 최신일정렬 출력
					searchResultSortedPosts = searchService.getSortPostOneTopicBylatestDate(searchKeyword,selectBoardId);
					return searchResultSortedPosts;	
				}
				//	break;			
	
			case 2 : // 2: 추천순
				logger.info("sortPosts-2번 선택. 아직 실행사항 미작성.");		
			break;
			
			default : break;
		}
		return searchResultSortedPosts;	
	}
	
	
	//search.jsp에서 검색어를 입력시 작동하는 기능
	@RequestMapping("/search")  
	public ModelAndView search(String searchKeyword, ModelAndView mav){	
		logger.info("SearchController-search 시작");	
		
		logger.info("기업정보 관련 데이터 준비");	
		List<CompanyDto> searchResultCompany = searchService.getSearchCompany(searchKeyword);	//기업프로필
		List<CompanyReviewDto> companyReviews =  new ArrayList<>();	
		
		logger.info("기업정보여부 플래그(검색어가 기업을 검색했는지 여부를 알리는 용도)");	
		int searchResultCompanyDataFlag=0; //값이 1일시 회사정보 있음
		if( !(searchResultCompany.isEmpty()) && !(searchResultCompany.get(0).getCompanyName().isEmpty())) { //!(searchResultCompany.isEmpty())가 0이다 회사정보가 있음.
			logger.info("확인결과: 회사정보 있음");	
			companyReviews = searchService.getCompanyReviews(searchResultCompany.get(0).getCompanyId());	//기업에 대한 기업리뷰
			searchResultCompanyDataFlag=1;
		}
		else {
			logger.info("확인결과: 회사정보 없음");	
			searchResultCompanyDataFlag=0;
		}

		
		//2.포스트관련 정보
		//2.1 포스트출력
		List<PostDto> searchResultPosts = searchService.getSearchPosts(searchKeyword);	//게시글 제목 기준 검색

		//2.2 드롭다운버튼관련
		List<BoardDto> boardNameAndIdAndCount = searchService.getBoardNameAndIdAndCount(searchKeyword); //토픽의 이름 수신

		logger.info("데이터준비 3단계. mav에게 searchResultPosts가 받은 정보를 입력. 웹페이지에 출력할 수 있도록 실시.");				
		//0.이전검색어 그대로 전달.
		mav.addObject("pastSearchKeyword", searchKeyword); //이전의 검색어.
					
		//1.기업정보 관련	
		mav.addObject("searchResultCompanyDataFlag",searchResultCompanyDataFlag); 		//기업정보 여부애 떠라 jsp페이지에서 기업정보관련 출력여부 결정.
 		mav.addObject("searchResultCompany",searchResultCompany); 						//기업정보를 갖는 오브젝트.
		mav.addObject("companyReviews",companyReviews);								//검색된 기업에 대한 기업리뷰		
 
		//2.포스트관련 정보
		//2.1 드롭다운버튼관련
		mav.addObject("boardNameAndIdAndCount",boardNameAndIdAndCount);			//검색어에 검색된 포스트들의 토픽(게시판) 이름들 저장. //boardTopicName
		//2.2 포스트출력
		mav.addObject("searchResultPosts",searchResultPosts);			//검색어와 관련된 포스트(게시글)들 전달.
		
			
		logger.info("출력할 경로 설정.");		
		mav.setViewName("main/search/search");
		return mav;	

	}
}
