package com.ksinfo.blind.alert.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.alert.dto.PostReportDto;
import com.ksinfo.blind.alert.dto.ReplyReportDto;
import com.ksinfo.blind.alert.dto.ReportReasonDto;
import com.ksinfo.blind.alert.dto.ReviewReportDto;
import com.ksinfo.blind.alert.mapper.AlertMapper;


@Service 
public class AlertService {
	@Autowired 
	public AlertMapper mapper; 

	public List<ReportReasonDto> getAlertReasonList(String alertType) { 
		return mapper.getAlertReasonList(alertType);    
	}

	public void setPostReport(PostReportDto postReport) { 
		mapper.setPostReport(postReport);    
	}
	
	public void setReviewReport(ReviewReportDto reviewReport){//기업리뷰 신고등록
		mapper.setReviewReport(reviewReport);
	}  
	public void setReplyReport(ReplyReportDto replyReport){//댓글 신고등록
		mapper.setReplyReport(replyReport);
	}    
	
}
