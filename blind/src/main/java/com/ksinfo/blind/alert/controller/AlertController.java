package com.ksinfo.blind.alert.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.alert.dto.PostReportDto;
import com.ksinfo.blind.alert.dto.ReportReasonDto;
import com.ksinfo.blind.alert.mapper.AlertMapper;
import com.ksinfo.blind.alert.service.AlertService;
import com.ksinfo.blind.search.controller.SearchController;
import com.ksinfo.blind.search.dto.PostDto;
import com.ksinfo.blind.search.service.SearchService;

@Controller
public class AlertController {
	
	private static final Logger logger = LoggerFactory.getLogger(AlertController.class);

	@Autowired AlertService alertService;  
	
	
	//1.신고버튼(포스트신고) 클릭시 해당 신고
	//1.1. 신고하기 팝업창 					
	@RequestMapping(value="/loadAlertReasonList",method=RequestMethod.POST)
	   @ResponseBody
	   public List<ReportReasonDto> loadAlertReasonList(@RequestParam Map<String, Object> param){ 
	      logger.info("loadAlertReasonList 시작.");
	      logger.info("입력된 신고 유형(1:포스트/2:기업리뷰/3:포스트댓글)에 따라 신고사유들을 리턴.");
	      logger.info("alertType : "+param.get("alertType"));
	      logger.info("alertType : "+param.get("test2"));
	      List<ReportReasonDto> alertReasonList = alertService.getAlertReasonList();
	      return alertReasonList;   
	   }


	//수신된 신고사항을 DB에 저장
	@RequestMapping(value="/sendAlert",method=RequestMethod.POST)
	   @ResponseBody
	   public int receiveAlert(@RequestParam Map<String, Object> param){ 
	      logger.info("receiveAlert 시작.");			
	      
	      //수신된 정보 확인
	      logger.info("postId : "+param.get("postId")); 						//게시글의 id
	      logger.info("userId : "+param.get("userId")); 						//신고자의 id(닉네임이 아님)
	      logger.info("selectAlertReason : "+param.get("reportReasonCode"));	//신고사유 코드번호
	      logger.info("alertType : "+param.get("alertType"));					//신고유형(1:포스트/2:기업리뷰/3:포스트댓글)
	      logger.info("reportReasonContent : "+param.get("report_reason_content"));		//textarea의 작성내용.

	      
	      // 작성의 편의 및 PostReportDto의 변수에 맞도록 정정. 
	      int postId = Integer.parseInt(param.get("postId").toString()) ;
	      int userId = Integer.parseInt(param.get("userId").toString()) ;
	      String reportReasonCode = param.get("reportReasonCode").toString();
	      int alertType = Integer.parseInt(param.get("alertType").toString()) ;
	      String reportReasonContent = param.get("report_reason_content").toString();
	      
	      
	      //신고유형(v포스트)에 따라 신고를 저장할 테이블을 구분
	      switch( alertType ) {
	      	case 1:	//대상 테이블(1)포스트 -> POST_REPORT_MGT에 저장
	      		logger.info("post신고로 확인, POST_REPORT_MGT에 insert시작."); 	
	      		PostReportDto postReport = new PostReportDto();  
	      		postReport.setPostId(postId);
	      		postReport.setUserId(userId);
	      		postReport.setReportReasonCode(reportReasonCode);
	      		postReport.setReportReasonContent(reportReasonContent);
	      		
	      		alertService.setPostReport(postReport);
	      		break;
	      	default: 
	      		logger.info("정의되지 않은 신고유형입니다."); 	
	      		break;
	      }		      
	      return 1;
	}
	
	
	//신고하기 테스트 페이지로 이동
	@RequestMapping("/alert/test_alert")  
	public ModelAndView test_alert(ModelAndView mav){	
		logger.info("test_alert 페이지 이동");
		
//	List<PostDto> searchResultPostsSelectTopic = searchService.getPostSelectTopic(selectBoardId, searchKeyword);
//	mav.addObject("searchResultPosts",searchResultPosts);			//검색어와 관련된 포스트(게시글)들 전달.
		
		
		//임의의 데이터 추가.
		//1.포스트신고관련 필요정보
		int postId = 1000;			//게시글의 id
	    int userId = 2000; 			//신고자의 id(닉네임이 아님)
	    //selectAlertReason(신고사유 코드번호)는 신고시 추가되므로 생략.
		
		
		
		
		mav.addObject("postId",postId);		
		mav.addObject("userId",userId);		
		mav.setViewName("main/alert/test_alert");
		return mav;	
	}
}
