package com.ksinfo.blind.alert.controller;

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
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.alert.dto.PostReportDto;
import com.ksinfo.blind.alert.dto.ReplyReportDto;
import com.ksinfo.blind.alert.dto.ReportReasonDto;
import com.ksinfo.blind.alert.dto.ReviewReportDto;
import com.ksinfo.blind.alert.service.AlertService;


@Controller
public class AlertController {
	
	private static final Logger logger = LoggerFactory.getLogger(AlertController.class);

	@Autowired AlertService alertService;  
	
	//1.신고버튼 클릭시 해당 신고유형에 맞는 신고리스트들을 리턴.			
	@RequestMapping(value="/loadAlertReasonList",method=RequestMethod.POST)
	@ResponseBody
	public List<ReportReasonDto> loadAlertReasonList(@RequestParam Map<String, Object> param){ 
		logger.info("loadAlertReasonList 시작.");

	    logger.info("alertType : "+param.get("alertType"));
	    String alertType = (String) param.get("alertType"); //형변환 (Object->String) 
	      
	    //입력된 신고유형은 xml의 where문을 활용하여 분류실시.(따라서 switch문 실시않음)
		//신고유형에 해당하는 신고사유들을 리턴.
	    List<ReportReasonDto> alertReasonList = alertService.getAlertReasonList( alertType );

	    logger.info("loadAlertReasonList 종료.");
		return alertReasonList;   
	}

	//2.수신된 신고사항을 DB에 저장
	@RequestMapping(value="/sendAlert",method=RequestMethod.POST)
	@ResponseBody
	public int receiveAlert(@RequestParam Map<String, Object> param){ 
		logger.info("receiveAlert 시작.");			
	      
	    //수신된 정보 확인위한 로그코드
	    logger.info("postId : "+param.get("postId")); 								//게시글의 id
	    logger.info("companyReviewId : "+param.get("companyReviewId")); 			//기업리뷰글 id
	    logger.info("replyId : "+param.get("replyId")); 							//댓글 id	
        logger.info("userId : "+param.get("userId")); 								//신고자의 id(닉네임이 아님)
	    logger.info("selectAlertReason : "+param.get("reportReasonCode"));			//신고사유 코드번호
	    logger.info("alertType : "+param.get("alertType"));							//신고유형(1:포스트/2:기업리뷰/3:포스트댓글)
	    logger.info("reportReasonContent : "+param.get("report_reason_content"));	//textarea의 작성내용.
	
	      
	    // 작성편의 및 post/review/reply ReportDto에 맞도록 변수를 저장. 
	    int postId = Integer.parseInt(param.get("postId").toString()) ;
	    int companyReviewId = Integer.parseInt(param.get("companyReviewId").toString()) ;
	    int replyId = Integer.parseInt(param.get("replyId").toString());
	    int userId = Integer.parseInt(param.get("userId").toString());
	    String reportReasonCode = param.get("reportReasonCode").toString();
	    String alertType = param.get("alertType").toString();
	    String reportReasonContent = param.get("report_reason_content").toString();
	      
	    switch(alertType) {
	    	case "0006" :  //post신고
	      		PostReportDto postReport = new PostReportDto();  
	      		postReport.setPostId(postId);
	      		postReport.setUserId(userId);
	      		postReport.setReportReasonCode(reportReasonCode);
	      		postReport.setReportReasonContent(reportReasonContent);
	      		
	      		alertService.setPostReport(postReport);
	      		return 1; //정상적으로 신고접수.
	      		
	      	case "0008" :  //기업리뷰 신고
	      		ReviewReportDto reviewReport = new ReviewReportDto();  
	      		reviewReport.setCompanyReviewId(companyReviewId);
	      		reviewReport.setUserId(userId);
	      		reviewReport.setReportReasonCode(reportReasonCode);
	      		reviewReport.setReportReasonContent(reportReasonContent);
	      		
	      		alertService.setReviewReport(reviewReport);	
	      		return 1; //정상적으로 신고접수.

	      	case "0012" :  //댓글 신고
	      		ReplyReportDto replyReport = new ReplyReportDto();  
	      		replyReport.setReplyId(replyId);
	      		replyReport.setUserId(userId);
	      		replyReport.setReportReasonCode(reportReasonCode);
	      		replyReport.setReportReasonContent(reportReasonContent);
	      		
	      		alertService.setReplyReport(replyReport);
	      		return 1; //정상적으로 신고접수.
	      }
	
	      return 0; //에러발생으로 판단.
	}
	
	//신고하기 테스트 페이지로 이동
	@RequestMapping("/alert/alert_modal")  
	public ModelAndView alert_modal(ModelAndView mav){			
	
		//임의의 데이터 추가.
		int userId = 9990; 			//신고자의 id(닉네임이 아님)
		mav.addObject("userId",userId);		

		int postId = 1000;			//게시글의 id
		mav.addObject("postId",postId);		
		
	    int companyReviewId = 2000;//기업리뷰글의 id
		mav.addObject("companyReviewId",companyReviewId);		

		int replyId = 3000;		   //댓글의 id
		mav.addObject("replyId",replyId);		
		
		
		mav.setViewName("main/alert/alert_modal");
		return mav;	
	}
}
