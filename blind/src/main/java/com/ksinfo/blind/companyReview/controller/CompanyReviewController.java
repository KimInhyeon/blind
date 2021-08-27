package com.ksinfo.blind.companyReview.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	//BLIND_0013_企業登録申請(2021-08-05)
	@RequestMapping(value = "sendRequestCompanyRegist", method = RequestMethod.POST, produces="application/json")
	@ResponseBody
	public int sendRequestCompanyRegist(String requestCompnayName, String requestCompnayEmail, @AuthenticationPrincipal Account account){

		int userid = (int)account.getUserId();

		companyReviewService.sendRequestCompanyRegist(requestCompnayName, requestCompnayEmail, userid);

		return 1;//성공시1을 리턴하도록 실시.
	}



	  //BLIND_0017_企業ポストタブ(2021-08-11)
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
		  
		  Map<String, Object> paramMap = new HashMap<>();  //페이징을 위한 파라미터 맵 생성.
		  paramMap.put("companyName", companyName);
		  paramMap.put("searchKeyword", searchKeyword);
		  
		  PageNavigator navi = companyReviewService.getNavigator(page, paramMap);
		  
		  
		  //2.검색어 여부 확인. 검색어가 없다면 회사명으로 기본검색을 수행, 사용자가 입력한 검색어가 있다면 사용자가 입력한 검색어로 검색 실시.
		 // if(searchKeyword == null || searchKeyword.equals("")) {
			  //1.1. 검색어 없음(유저가 게시판의 검색창에 검색어를 입력한 경우/타 링크 통해 타고 최초 접속)	
		//	  companyPosts = searchService.getSearchPosts(companyName);	//기본설정(기업명) 으로 검색
		 // }
		  
		 // else {
			  //1.2. 검색어 있음(유저가 게시판의 검색창에 검색어를 입력한 경우)
			  companyPosts = companyReviewService.getPosts(navi.getCurrentPage(), paramMap);//사용자가 입력한 검색어로 검색
		  //}



		  mav.addObject("navi", navi);
		  
		  mav.addObject("company_name", companyName);	  
		  mav.addObject("company_posts", companyPosts);
		  mav.addObject("pastSearchKeyword", searchKeyword);
		  
		  mav.setViewName("main/companyReview/companyReviewPost");
		  return mav;
		}




	//BLIND_0016 企業レビュー詳細照会(2021-08-25)
	@RequestMapping(value = "companyReviewDetails", method = RequestMethod.POST)
	public ModelAndView companyReviewDetails(Integer companyId, ModelAndView mav) throws Exception {

		//0.임시정보(작동을 위해 임시적으로 구성한 정보입니다.
		companyId = 1;
		//List<CompanyMainViewDto>  companyReviewLists = companyReviewService.getCompanyReviews

		mav.addObject("out",1);
		mav.setViewName("main/companyReview/companyReviewDetails");
		return mav;
	}
}
