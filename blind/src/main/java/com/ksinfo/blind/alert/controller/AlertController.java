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
import com.ksinfo.blind.alert.dto.ReplyReportDto;
import com.ksinfo.blind.alert.dto.ReportReasonDto;
import com.ksinfo.blind.alert.dto.ReviewReportDto;
import com.ksinfo.blind.alert.mapper.AlertMapper;
import com.ksinfo.blind.alert.service.AlertService;
import com.ksinfo.blind.search.controller.SearchController;
import com.ksinfo.blind.search.dto.PostDto;
import com.ksinfo.blind.search.service.SearchService;

@Controller
public class AlertController {
	
	private static final Logger logger = LoggerFactory.getLogger(AlertController.class);

	@Autowired AlertService alertService;  
	
	//1.신고버튼 클릭시 해당 신고유형에 맞는 신고리스트들을 리턴.			
	@RequestMapping(value="/loadAlertReasonList",method=RequestMethod.POST)
	@ResponseBody
	public List<ReportReasonDto> loadAlertReasonList(@RequestParam Map<String, Object> param){ 
		logger.info("loadAlertReasonList 시작.");
	    logger.info("입력된 신고 유형(0006:포스트/0008:기업리뷰/0012:포스트댓글)에 따라 신고사유들을 리턴.");

	    logger.info("alertType : "+param.get("alertType"));
	    String alertType = (String) param.get("alertType"); //형변환 (Object->String) 
	      
	    //입력된 신고유형은 xml의 where문을 활용하여 분류실시.(따라서 switch문 실시않음)
	    List<ReportReasonDto> alertReasonList = alertService.getAlertReasonList( alertType );
	     
		logger.info("신고유형 따라 신고사유들을 리턴.");
	    logger.info("loadAlertReasonList 종료.");
		return alertReasonList;   
	}

	//2.수신된 신고사항을 DB에 저장
	@RequestMapping(value="/sendAlert",method=RequestMethod.POST)
	@ResponseBody
	public int receiveAlert(@RequestParam Map<String, Object> param){ 
		logger.info("receiveAlert 시작.");			
	      
	    //수신된 정보 확인위한 로그코드
	    logger.info("postId : "+param.get("postId")); 							//게시글의 id
	    logger.info("companyReviewId : "+param.get("companyReviewId")); 			//기업리뷰글 id
	    logger.info("replyId : "+param.get("replyId")); 							//댓글 id	
        logger.info("userId : "+param.get("userId")); 							//신고자의 id(닉네임이 아님)
	    logger.info("selectAlertReason : "+param.get("reportReasonCode"));		//신고사유 코드번호
	    logger.info("alertType : "+param.get("alertType"));						//신고유형(1:포스트/2:기업리뷰/3:포스트댓글)
	    logger.info("reportReasonContent : "+param.get("report_reason_content"));	//textarea의 작성내용.
	
	      
	    // 작성의 편의 및 Post/review/reply ReportDto에 맞도록 변수를 저장. 
	    int postId = Integer.parseInt(param.get("postId").toString()) ;
	    int companyReviewId = Integer.parseInt(param.get("companyReviewId").toString()) ;
	    int replyId = Integer.parseInt(param.get("replyId").toString());
	    int userId = Integer.parseInt(param.get("userId").toString());
	    String reportReasonCode = param.get("reportReasonCode").toString();
	    String alertType = param.get("alertType").toString();
	    String reportReasonContent = param.get("report_reason_content").toString();
	      
	    switch(alertType) {
	    	case "0006" :  //post신고
	      		logger.info("post신고로 확인, POST_REPORT_MGT에 insert시작."); 	
	      		PostReportDto postReport = new PostReportDto();  
	      		postReport.setPostId(postId);
	      		postReport.setUserId(userId);
	      		postReport.setReportReasonCode(reportReasonCode);
	      		postReport.setReportReasonContent(reportReasonContent);
	      		
	      		alertService.setPostReport(postReport);
	      		logger.info("POST_REPORT_MGT insert종료."); 	
	      		break;
	      		
	      	case "0008" :  //기업리뷰 신고
	      		logger.info("review(기업리뷰)신고로 확인, REVIEW_REPORT_MGT에 insert시작."); 	
	      		ReviewReportDto reviewReport = new ReviewReportDto();  
	      		reviewReport.setCompanyReviewId(companyReviewId);
	      		reviewReport.setUserId(userId);
	      		reviewReport.setReportReasonCode(reportReasonCode);
	      		reviewReport.setReportReasonContent(reportReasonContent);
	      		
	      		alertService.setReviewReport(reviewReport);	
	      		logger.info("REVIEW_REPORT_MGT insert종료."); 	
	      		break;

	      	case "0012" :  //댓글 신고
	    		logger.info("reply신고로 확인, REPLY_REPORT_MGT에 insert시작."); 		    	  
	      		ReplyReportDto replyReport = new ReplyReportDto();  
	      		replyReport.setReplyId(replyId);
	      		replyReport.setUserId(userId);
	      		replyReport.setReportReasonCode(reportReasonCode);
	      		replyReport.setReportReasonContent(reportReasonContent);
	      		
	      		alertService.setReplyReport(replyReport);
	    		logger.info("REPLY_REPORT_MGT insert종료."); 		    	  	      		
	      		break;
	      	
	      	default :
	      		logger.info("정의되지 않은 신고유형입니다."); 
	      		break;
	      }
	
	      return 1; //여기에서는 성공했다는 의미로 ajax에게 알리기 위해 1을 리턴.
	}
	
	//신고하기 테스트 페이지로 이동
	@RequestMapping("/alert/test_alert_modal")  
	public ModelAndView test_alert_modal_style2(ModelAndView mav){			
		//	List<PostDto> searchResultPostsSelectTopic = searchService.getPostSelectTopic(selectBoardId, searchKeyword);
		//	mav.addObject("searchResultPosts",searchResultPosts);			//검색어와 관련된 포스트(게시글)들 전달.
		
		//임의의 데이터 추가.
		//1.현 사용자의 id
		int userId = 9990; 			//신고자의 id(닉네임이 아님)
		mav.addObject("userId",userId);		
		
		//2.포스트신고관련 필요정보
		int postId = 1000;			//게시글의 id
		mav.addObject("postId",postId);		
		
		//3.기업리뷰 신고관련 필요정보 
	    int companyReviewId = 2000;//기업리뷰글의 id
		mav.addObject("companyReviewId",companyReviewId);		

		//4.댓글 신고관련 	
	    int replyId = 3000;		   //댓글의 id
		mav.addObject("replyId",replyId);		
		
	    //selectAlertReason(신고사유 코드번호)는 신고시 추가되므로 생략.

		logger.info("test_alert_modal 페이지 이동");
		mav.setViewName("main/alert/test_alert_modal");
		return mav;	
	}
}
