package com.ksinfo.blind.alert.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.alert.dto.PostReportDto;
import com.ksinfo.blind.alert.dto.ReplyReportDto;
import com.ksinfo.blind.alert.dto.ReportReasonDto;
import com.ksinfo.blind.alert.dto.ReviewReportDto;

import java.util.List;

@Repository
@Mapper 
public interface AlertMapper {
	List<ReportReasonDto> getAlertReasonList(String alertType);

	void setPostReport(PostReportDto postReport);    //게시글 신고등록
	void setReviewReport(ReviewReportDto reviewReport);  //기업리뷰 신고등록
	void setReplyReport(ReplyReportDto replyReport);    //댓글 신고등록
}
