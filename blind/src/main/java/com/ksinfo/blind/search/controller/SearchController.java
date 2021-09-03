package com.ksinfo.blind.search.controller;

import com.ksinfo.blind.search.dto.BoardDto;
import com.ksinfo.blind.search.dto.CompanyDto;
import com.ksinfo.blind.search.dto.CompanyReviewDto;
import com.ksinfo.blind.search.dto.CompanyVoteResultDto;
import com.ksinfo.blind.search.dto.PostDto;
import com.ksinfo.blind.search.service.SearchService;
import com.ksinfo.blind.security.Account;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

@Controller
public class SearchController {

	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);

	@Autowired SearchService searchService; // SearchService.java에서 선언된 DB의 자료형


	//유저가 검색된 기업에 대하여 근무를 추천/비추천 버튼 클릭한 값에 따라 추천/비추천 한 정보를 insert실시 및 기업의 추천도를 리턴.
	@RequestMapping(value = "companyRecommendVote", method = RequestMethod.POST)
	@ResponseBody
	public List<CompanyVoteResultDto> companyRecommendPush(int companyId, @AuthenticationPrincipal Account account, int companyVoteValue) {

		//로그인한 유저인지 체크(로그인 않은 유저의 경우에는 로그인 페이지로 이동하는 등의 조처를 하도록 작성예정.
		int userId = (int) account.getUserId();

		// companyRecommendValue : 기업추천여부를 갖는 값.( 1:기업추천 / 0:기업 비추천)
		searchService.setCompanyRecommendVote(userId, companyId, companyVoteValue);

		List<CompanyVoteResultDto> companyRecommendVoteResult = searchService.getCompanyRecommendVoteResult(companyId);

		//선호도를 %로 출력하기 위한 코드. xml에서 SQL을 통해 %로 바로 리턴되도록 수정하는대로 삭제할 예정.
		float tempDenominator = companyRecommendVoteResult.get(0).getVoteCountOfGood()+ companyRecommendVoteResult.get(0).getVoteCountOfBad();
		companyRecommendVoteResult.get(0).setVoteCountOfGood((companyRecommendVoteResult.get(0).getVoteCountOfGood() / tempDenominator) * 100);
		companyRecommendVoteResult.get(0).setVoteCountOfBad((companyRecommendVoteResult.get(0).getVoteCountOfBad() / tempDenominator) * 100);

		return companyRecommendVoteResult; //투표에 참여한 유저에게 기업의 선호도를 출력하기 위한 값들을 리턴.
	}


	@RequestMapping(value = "bookmarkChanege", method = RequestMethod.GET)
	@ResponseBody
	public int bookmarkChanege() { //나중에 리턴형을 BookmarkDto으로 할지 여부 결정필요.
		//북마크 설정 mapper.xml을 통해 SQL 수정실시하도록 갱신예정.
		return 1; //성공시 flag 개념으로 1을 성공의 개념으로 리턴.
	}

	//포스트-1개의 토픽(board) 선택시 해당하는 게시판만 출력되도록 실행.
	@RequestMapping(value = "viewPostsSelectedTopic", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<PostDto> viewPostsSelectedTopic(int selectBoardId, String searchKeyword) {
		logger.info("viewPostsSelectedTopic start");
		logger.info("selectBoardId : " + selectBoardId + "  searchKeyword : " + searchKeyword);

		//선택한 토픽에 대한 포스트들만 리턴실시.
		//<!-- 2.2.포스트-토픽선택(왼쪽드롭박스) : 1개의 토픽만 선택시 리턴 -->
		List<PostDto> searchResultPostsSelectTopic = searchService.getPostSelectTopic(selectBoardId, searchKeyword);
		logger.info("viewPostsOfOneTopic-END(Returns searchResultPostsOfOneTopic) ");

		return searchResultPostsSelectTopic;
	}

	//오른쪽 드롭박스(추천순/최신일 정렬)
	@RequestMapping(value = "sortPosts", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<PostDto> sortPosts(int sortPostOption, String searchKeyword, int selectBoardId) {
		logger.info("sortPosts 시작");
		logger.info("sortPostOption : " + sortPostOption + "   searchKeyword : " + searchKeyword + "   selectBoardId : " + selectBoardId);
		List<PostDto> searchResultSortedPosts; //재검색을 실시하여 해당 SQL의 order by등이 적용된 출력.

		if (sortPostOption == 1) {
			logger.info("sortPosts-정렬옵션 : 최신일 기준");
			//<!-- 2.3. 콤보박스의 정렬기준 옵션_추천순 -->
			//<!-- 2.3.1. 콤보박스의 포스트-정렬옵션-최신일  -->
			searchResultSortedPosts = searchService.getSortPostBylatestDate(selectBoardId, searchKeyword);
			return searchResultSortedPosts;
		} else {
			logger.info("sortPosts-정렬옵션 : 추천수 기준");
			//<!-- 2.3.2. 콤보박스의 포스트-정렬옵션-추천순  -->
			searchResultSortedPosts = searchService.getSortPostByRecommend(selectBoardId, searchKeyword);
			return searchResultSortedPosts;
		}
	}

	//search.jsp에서 검색어를 입력시 작동하는 기능
	@RequestMapping("/search")
	public ModelAndView search(String searchKeyword, ModelAndView mav) {
		//토픽메인에서 입력한 검색어를 검색실시.

		//기업정보 관련 데이터 준비
		//<!-- 1.1.회사의 프로필 정보 수신 -->
		List<CompanyDto> searchResultCompany = searchService.getSearchCompany(searchKeyword); //기업프로필
		List<CompanyReviewDto> companyReviews =  new ArrayList<>();	

		//기업정보여부 플래그(검색어가 기업을 검색했는지 여부를 알리는 용도)
		int searchResultCompanyDataFlag = 0; //값이 1일시 회사정보 있음
		if (!(searchResultCompany.isEmpty())) {
			//<!-- 1.2.회사의 리뷰정보 수신 -->
			companyReviews = searchService.getCompanyReviews(searchResultCompany.get(0).getCompanyId()); //기업에 대한 기업리뷰 수신
			searchResultCompanyDataFlag = 1;
		} else {
			//확인결과: 회사정보 없을시 실시사항.
			searchResultCompanyDataFlag = 0;
		}

		//2.포스트출력관련

		//<!-- 2.1.게시글 출력관련 -->
		//<!-- 2.1.1. 기본검색(포스트-정렬옵션-최신일순 정렬) -->
		List<PostDto> searchResultPosts = searchService.getSearchPosts(searchKeyword); //게시글의 제목검색&정렬기준: 최신일

		//<!-- 2.1.2. [왼쪽드롭박스버튼] 토픽개수및 포스트들의 갯수 카운트 리턴 -->
		List<BoardDto> boardNameAndIdAndCount = searchService.getBoardNameAndIdAndCount(searchKeyword); //토픽의 이름 수신

		// mav를 통해 값을 jsp에게 리턴할 수 있도록 mavadd 실시.
		logger.info("데이터준비 3단계. mav에게 searchResultPosts가 받은 정보를 입력. 웹페이지에 출력할 수 있도록 실시.");

		//0.이전검색어 그대로 전달.
		mav.addObject("pastSearchKeyword", searchKeyword); //이전의 검색어.

		//1.기업정보 관련
		mav.addObject("searchResultCompanyDataFlag", searchResultCompanyDataFlag); //기업정보 여부애 떠라 jsp페이지에서 기업정보관련 출력여부 결정.
		mav.addObject("searchResultCompany", searchResultCompany); //기업정보를 갖는 오브젝트.
		mav.addObject("companyReviews", companyReviews); //검색된 기업에 대한 기업리뷰

		//2.포스트관련 정보
		//2.1 포스트출력
		mav.addObject("boardNameAndIdAndCount", boardNameAndIdAndCount); //검색어에 검색된 포스트들의 토픽(게시판) 이름들 저장. //boardTopicName
		//2.2.포스트-토픽선택(왼쪽드롭박스)
		//2.2.1. [왼쪽드롭박스버튼] 토픽개수및 포스트들의 갯수 카운트 리턴 <jsp 페이지에서 연산시 문제가 되지 않을까 우려 있음.>
		mav.addObject("searchResultPosts", searchResultPosts); //검색어와 관련된 포스트(게시글)들 전달.
		mav.addObject("searchResultPostsLastNumber", searchResultPosts.size() - 1);

		logger.info("출력할 경로 설정.");
		mav.setViewName("main/search/search");
		return mav;

	}

	@RequestMapping("/search/testView")
	public ModelAndView testView(ModelAndView mav) {
		mav.setViewName("main/search/testView");
		return mav;
	}

}
