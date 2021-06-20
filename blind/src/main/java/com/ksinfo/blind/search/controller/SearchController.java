package com.ksinfo.blind.search.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.search.dto.CompanyDto;
import com.ksinfo.blind.search.dto.CompanyReviewDto;
import com.ksinfo.blind.search.dto.PostCountInfDto;
import com.ksinfo.blind.search.dto.PostDto;
import com.ksinfo.blind.search.dto.ReplyDto;
import com.ksinfo.blind.search.dto.SearchDto;
import com.ksinfo.blind.search.service.SearchService;

import java.util.ArrayList;
import java.util.Arrays;
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

		//조회수, 추천수, 댓글수는 반복문을 활용하여 각 Post마다 적절한것만 매칭시키도록 설정.
		//조회수는 POST_COUNT_INF테이블 통해 바로 로딩.
		List<PostCountInfDto> viewCountOfPosts = new ArrayList<>(); //조회수(테이블 : POST_COUNT_INF)	 
		
		//															//추천수(테이블 : POST_RECOMMEND_INF)
		
		
		//List<ReplyDto> replysOfPosts = new ArrayList<>();			//각 포스트에 해당하는 댓글들의 정보들을 모두 로드(테이블 : REPLY_MGT)
		List<Integer>  replyCountOfPosts  = new ArrayList<>(); 		//각 포스트별 댓글 카운트.

		
		//각 포스트별 조회수 확인 
		for(int i=0; i<searchResultPosts.size() ;i++ ) {
	        viewCountOfPosts.addAll(i, searchService.getViewCountOfPosts(Integer.parseInt(searchResultPosts.get(i).getPostId()) ) );
		}

		/*댓글의 모든 정보 로드(포스트에 해당하는 댓글들만)
		for(int i=0; i < searchResultPosts.size() ;i++ ) {
			replysOfPosts.addAll(i, searchService.getReplysOfPosts(Integer.parseInt(searchResultPosts.get(i).getPostId()) ));
		}
		*/
		
		//포스트별 댓글수 카운트
		for(int i=0; i < searchResultPosts.size() ;i++ ) {
			replyCountOfPosts.addAll(i, searchService.getReplyCountsOfPosts(Integer.parseInt(searchResultPosts.get(i).getPostId())) );			
		}		
		
		

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
		
		logger.info("데이터준비 2단계.드롭버튼(토픽선택)의 카운트");	
		//[문의] 컨트롤러내에서 카운트 하기보다는 SQL로 하는 것 나은지 여부.  
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

		
		//조회수(게시글의 조회수 정보) : [테이블] POST_COUNT_INF
		//추천수(게시글의 추천수 정보) :
		//댓글수(게시글의 댓글수 정보) : 
		
		
		logger.info("데이터준비 3단계. mav에게 searchResultPosts가 받은 정보를 입력. 웹페이지에 출력할 수 있도록 실시.");		

		//mav.addObject("searchKeyword",searchKeyword); //필요여부 체크

		//이전검색어 그대로 전달.
		mav.addObject("pastSearchKeyword", searchKeyword); //이전의 검색어.

		
		//1.기업정보 관련
		mav.addObject("searchResultCompanyDataFlag",searchResultCompanyDataFlag); 	//기업정보 여부애 떠라 jsp페이지에서 기업정보관련 출력여부 결정.
 		mav.addObject("searchResultCompany",searchResultCompany); 					//기업정보를 갖는 오브젝트.
		mav.addObject("companyReviews",companyReviews);

 		
		
 		//2.포스트관련 정보
		//드롭다운버튼관련
		mav.addObject("countPostAll", countPostAll);			
		mav.addObject("countPostofBoard1", countPostofBoard1);
		mav.addObject("countPostofBoard2", countPostofBoard2);

		
		
		mav.addObject("searchResultPosts",searchResultPosts);	//검색어와 관련된 포스트(게시글)들 전달.
		mav.addObject("viewCountOfPosts", viewCountOfPosts);	//각 포스트별 조회수 정보전달
		mav.addObject("replyCountOfPosts", replyCountOfPosts);	//각 포스트별 댓글수 정보전달
		
		
		
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
