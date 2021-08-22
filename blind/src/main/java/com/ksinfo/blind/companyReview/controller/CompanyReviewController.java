package com.ksinfo.blind.companyReview.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.companyReview.dto.CompanyDto;
import com.ksinfo.blind.companyReview.dto.CompanyJoinDto;
import com.ksinfo.blind.companyReview.dto.CompanyMainViewDto;
import com.ksinfo.blind.companyReview.service.CompanyReviewService;
import com.ksinfo.blind.companyReview.service.CompanyReviewWriteService;
import com.ksinfo.blind.search.dto.PostDto;
import com.ksinfo.blind.search.service.SearchService;
import com.ksinfo.blind.security.Account;
import com.ksinfo.blind.util.MessageUtils;
import com.ksinfo.blind.util.PageNavigator;

@Controller
public class CompanyReviewController {
	@Autowired
	CompanyReviewService companyReviewService;
	
	@Autowired
	CompanyReviewWriteService companyReviewWriteService;
	
	@Autowired
	MessageUtils msg;
	
	@Autowired 
	SearchService searchService; // 본래 SearchService.java에서 선언&사용. 검색기능 활용 및 게시글(포스트)의 출력등을 위해 

	
	@RequestMapping(value = "companyReviewMain", method = RequestMethod.GET)
	public ModelAndView companyReviewMain(HttpServletRequest req) throws Exception {
		ModelAndView mav = new ModelAndView();
		List<CompanyDto> companyList = companyReviewService.companySearchAll();
		List<CompanyMainViewDto> companyJoinDto = companyReviewService.companySearchPopular();
		mav.addObject("companyJoinPopular",companyJoinDto);
		mav.addObject("companyList", companyList);
		mav.setViewName("main/companyReview/companyReview");

		return mav;
	}

	@RequestMapping(value = "companyReviewMain", method = RequestMethod.POST)
	public ModelAndView companyReviewSearch(HttpServletRequest req) throws Exception {
		ModelAndView mav = new ModelAndView();
		/*
		 * String paramString = (String) req.getParameter("searchKeyword");
		 * List<CompanyDto> companyDto =
		 * companyReviewService.companySearch(paramString); mav.addObject("companyDto",
		 * companyDto);
		 */
		mav.setViewName("main/companyReview/companyReview");

		return mav;
	}

	

	@RequestMapping(value = "companyReviewWrite", method = RequestMethod.GET)
	public ModelAndView companyReviewWrite(HttpServletRequest req) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("main/companyReview/companyReviewWrite");
		return mav;
	}
	
	  @RequestMapping(value="companyReviewWrite",method = RequestMethod.POST)
	  public ModelAndView companyReviewJoin(HttpServletRequest req, @AuthenticationPrincipal Account account) throws Exception{
		  ModelAndView mav= new ModelAndView();

		// int allPoint = Integer.parseInt(req.getParameter("hdnAllPoint")); 총점은 소수 여기서 나누기 5
		  int careerPoint = Integer.parseInt(req.getParameter("hdnCareerPoint"));
		  int workLifeBalancePoint = Integer.parseInt(req.getParameter("hdnWorkLifeBalancePoint"));
		  int payPoint = Integer.parseInt(req.getParameter("hdnPayPoint"));
		  int companyCulturePoint = Integer.parseInt(req.getParameter("hdnCompanyCulturePoint"));
		  int headPoint = Integer.parseInt(req.getParameter("hdnHeadPoint"));
		  float allPoint = (careerPoint + workLifeBalancePoint + payPoint + companyCulturePoint + headPoint)/5;
		  String simpleComment =(String)req.getParameter("oneWriteReview");
		  String advantages =(String)req.getParameter("strongPoint");
		  String disadvantages=(String)req.getParameter("weakPoint");		  
		  String resignReason =(String)req.getParameter("resignReason");
		  String workStartDate =(String)req.getParameter("hdnStartDate");
		  String workEndDate = (String)req.getParameter("hdnFinishDate");
		  String workArea = (String)req.getParameter("workArea");
		  long companyId= Long.parseLong(req.getParameter("hdnCompanyId"));
		  CompanyJoinDto inputDto = new CompanyJoinDto();
		  inputDto.setUserId(account.getUserId());
		  inputDto.setCompanyId(companyId);
		  inputDto.setJobGroupCode("01");
		  inputDto.setVerifyFlag((char)0);
		  inputDto.setCompleteFlag((char)0);
		  inputDto.setAllPoint(allPoint);
		  inputDto.setCareerPoint(careerPoint);
		  inputDto.setWorkLifeBalancePoint(workLifeBalancePoint);
		  inputDto.setPayPoint(payPoint);
		  inputDto.setCompanyCulturePoint(companyCulturePoint);
		  inputDto.setHeadPoint(headPoint);
		  inputDto.setSimpleComment(simpleComment);
		  inputDto.setAdvantages(advantages);
		  inputDto.setDisadvantages(disadvantages);
		  inputDto.setResignReason(resignReason);
		  inputDto.setWorkStartDate(workStartDate);
		  inputDto.setWorkEndDate(workEndDate);
		  inputDto.setWorkArea(workArea);
		  int insertCount = companyReviewWriteService.companyReviewJoin(inputDto);
		  
		  if (insertCount > 0) {
			  String message = msg.getMessage("BLIND_SCS_MSG_001");
			  mav.addObject("successMessage", message);
		  } else {
			  String message = msg.getMessage("BLIND_ERR_MSG_001");
			  mav.addObject("exceptionMessage", message);
		  }
		  
		  mav.setViewName("main/companyReview/companyReviewWrite");
		  return mav;
	 }
	   
	  @RequestMapping(value = "searchCompanyByCompanyName", method = RequestMethod.POST, produces="application/json")
	  @ResponseBody//ajax통신할때 제공,html통신으로 body로 넘긴다.화면이 제로딩되지않고 html부분만 바뀐다.    
	  public List<CompanyDto> searchCompanyByCompanyName(String companyName){ 
		  
		List<CompanyDto> companyDto = companyReviewService.companySearch(companyName);
		  
	      return companyDto;
	  }
	  
	  
	  //기업리뷰-포스트로 이동하였을 때 최초 작동.
	  //사용자가 기업리뷰페이지에서 "포스트"탭을 클릭했다는 상황으로 생각하여 진행.
	  @RequestMapping(value = "companyReviewPost", method = RequestMethod.GET)
	  public ModelAndView companyReviewPost(Integer companyId, String searchKeyword,
			  								@RequestParam(name = "page", defaultValue = "1") int page,
			  								ModelAndView mav) throws Exception { 
		  //Integer companyId    : 유저가 이전페이지(기업리뷰 소속의 페이지)에서 넘어온 경우 기업값을 받아오도록 실시.(int는 null값 에러로 인식되어 Integer 사용 
		  //String searchKeyword : 본 게시판페이지에서 유저가 입력한 검색어. 검색어 입력시 검색어를 중점으로 출력하도록 한다.
		  
		  
		  //0.임시 정보(제작위해 임시적으로 설정)
		  companyId = 1; 														// company_id=2 : トヨタ株式会社(각 DB 설정상 다를 수 있습니다)
		  String companyName=companyReviewService.getCompanyName(companyId);	

		  
		  //1.기본정보 설정
		  List<PostDto> companyPosts;  	  //회사리뷰의 게시글(post)들을 출력.

		  
		  //2.검색어 여부 확인. 검색어가 없다면 회사명으로 기본검색을 수행, 사용자가 입력한 검색어가 있다면 사용자가 입력한 검색어로 검색 실시.
		  if(searchKeyword == null || searchKeyword.equals("")) {
			  //1.1. 검색어 없음(유저가 게시판의 검색창에 검색어를 입력한 경우/타 링크 통해 타고 최초 접속)	
			  companyPosts = searchService.getSearchPosts(companyName);	//기본설정(기업명) 으로 검색
		  }
		  
		  else {
			  //1.2. 검색어 있음(유저가 게시판의 검색창에 검색어를 입력한 경우)
			  companyPosts = searchService.getSearchPosts(searchKeyword);//사용자가 입력한 검색어로 검색
		  }

		  PageNavigator navi = companyReviewService.getNavigator(page, companyPosts.size());

		  mav.addObject("navi", navi);
	 	  
		  mav.addObject("company_name", companyName);	  
		  mav.addObject("company_posts", companyPosts);
			
		  mav.setViewName("main/companyReview/companyReviewPost");
		  return mav;
		}
	  
	  
	  //검색창 밑의 키워드를 클릭한 경우 키워드를 검색어로 활용하여 검색작업을 실시하여 페이지를 재출력실시.
	  @RequestMapping(value = "companyReviewPostByRecommendKeyWord", method = RequestMethod.POST, produces="application/json")
	  @ResponseBody
	  public List<PostDto> companyReviewPostByRecommendKeyWord(String selectRecommendKeyword) throws Exception { 
	  //String selectRecommendKeyword : 기업게시판의 검색창하단의 추천어. 유저가 클릭한 추천어가 검색어로 적용된다.
		  
		  List<PostDto> companyPosts;  	  //회사리뷰의 게시글(post)들을 출력.
		  companyPosts = searchService.getSearchPosts(selectRecommendKeyword);//클릭한 추천어로 검색 결과를 리턴.


		  return companyPosts;		  
		  
	  }
	  
}
