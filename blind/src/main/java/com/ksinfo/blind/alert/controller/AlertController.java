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
	
	
	//1.�Ű��ư(����Ʈ�Ű�) Ŭ���� �ش� �Ű�
	//1.1. �Ű��ϱ� �˾�â 					
	@RequestMapping(value="/loadAlertReasonList",method=RequestMethod.POST)
	   @ResponseBody
	   public List<ReportReasonDto> loadAlertReasonList(@RequestParam Map<String, Object> param){ 
	      logger.info("loadAlertReasonList ����.");
	      logger.info("�Էµ� �Ű� ����(1:����Ʈ/2:�������/3:����Ʈ���)�� ���� �Ű�������� ����.");
	      logger.info("alertType : "+param.get("alertType"));
	      logger.info("alertType : "+param.get("test2"));
	      List<ReportReasonDto> alertReasonList = alertService.getAlertReasonList();
	      return alertReasonList;   
	   }


	//���ŵ� �Ű������ DB�� ����
	@RequestMapping(value="/sendAlert",method=RequestMethod.POST)
	   @ResponseBody
	   public int receiveAlert(@RequestParam Map<String, Object> param){ 
	      logger.info("receiveAlert ����.");			
	      
	      //���ŵ� ���� Ȯ��
	      logger.info("postId : "+param.get("postId")); 						//�Խñ��� id
	      logger.info("userId : "+param.get("userId")); 						//�Ű����� id(�г����� �ƴ�)
	      logger.info("selectAlertReason : "+param.get("reportReasonCode"));	//�Ű���� �ڵ��ȣ
	      logger.info("alertType : "+param.get("alertType"));					//�Ű�����(1:����Ʈ/2:�������/3:����Ʈ���)
	      logger.info("reportReasonContent : "+param.get("report_reason_content"));		//textarea�� �ۼ�����.

	      
	      // �ۼ��� ���� �� PostReportDto�� ������ �µ��� ����. 
	      int postId = Integer.parseInt(param.get("postId").toString()) ;
	      int userId = Integer.parseInt(param.get("userId").toString()) ;
	      String reportReasonCode = param.get("reportReasonCode").toString();
	      int alertType = Integer.parseInt(param.get("alertType").toString()) ;
	      String reportReasonContent = param.get("report_reason_content").toString();
	      
	      
	      //�Ű�����(v����Ʈ)�� ���� �Ű� ������ ���̺��� ����
	      switch( alertType ) {
	      	case 1:	//��� ���̺�(1)����Ʈ -> POST_REPORT_MGT�� ����
	      		logger.info("post�Ű�� Ȯ��, POST_REPORT_MGT�� insert����."); 	
	      		PostReportDto postReport = new PostReportDto();  
	      		postReport.setPostId(postId);
	      		postReport.setUserId(userId);
	      		postReport.setReportReasonCode(reportReasonCode);
	      		postReport.setReportReasonContent(reportReasonContent);
	      		
	      		alertService.setPostReport(postReport);
	      		break;
	      	default: 
	      		logger.info("���ǵ��� ���� �Ű������Դϴ�."); 	
	      		break;
	      }		      
	      return 1;
	}
	
	
	//�Ű��ϱ� �׽�Ʈ �������� �̵�
	@RequestMapping("/alert/test_alert")  
	public ModelAndView test_alert(ModelAndView mav){	
		logger.info("test_alert ������ �̵�");
		
//	List<PostDto> searchResultPostsSelectTopic = searchService.getPostSelectTopic(selectBoardId, searchKeyword);
//	mav.addObject("searchResultPosts",searchResultPosts);			//�˻���� ���õ� ����Ʈ(�Խñ�)�� ����.
		
		
		//������ ������ �߰�.
		//1.����Ʈ�Ű���� �ʿ�����
		int postId = 1000;			//�Խñ��� id
	    int userId = 2000; 			//�Ű����� id(�г����� �ƴ�)
	    //selectAlertReason(�Ű���� �ڵ��ȣ)�� �Ű�� �߰��ǹǷ� ����.
		
		
		
		
		mav.addObject("postId",postId);		
		mav.addObject("userId",userId);		
		mav.setViewName("main/alert/test_alert");
		return mav;	
	}
}
