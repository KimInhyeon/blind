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
	
	
	//�Ű��ư(����Ʈ�Ű�) Ŭ���� �ش� �Ű�
	//						
	@RequestMapping(value="/loadAlertReasonList",method=RequestMethod.POST)
	   @ResponseBody
	   public Map<String, Object> loadAlertReasonList(@RequestParam Map<String, Object> param){ 
	      logger.info("loadAlertReasonList ����.");
	      logger.info("�Էµ� �Ű� ����(1:����Ʈ/2:�������/3:����Ʈ���)�� ���� �Ű�������� ����.");
	      logger.info("alertType : "+param.get("alertType"));
	      logger.info("alertType : "+param.get("test2"));
	      List<ReportReasonDto> alertReasonList = alertService.getAlertReasonList(alertType);
	      return alertReasonList;   
	   }

	@RequestMapping("/alert/test_alert")  
	public ModelAndView test_alert(ModelAndView mav){	
		logger.info("test_alert ������ �̵�");
	mav.setViewName("main/alert/test_alert");
	return mav;	
	}
}
