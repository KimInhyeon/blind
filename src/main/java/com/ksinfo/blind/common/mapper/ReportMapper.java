package com.ksinfo.blind.common.mapper;

import com.ksinfo.blind.common.dto.PostReportDto;
import com.ksinfo.blind.common.dto.ReplyReportDto;
import com.ksinfo.blind.common.dto.ReportReasonDto;
import com.ksinfo.blind.common.dto.ReviewReportDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReportMapper {
	List<ReportReasonDto> getReportReasonList(String reportType); //신고목록을 리턴(게시글/기업리뷰/댓글 조금씩 다름)

	void setPostReport(PostReportDto postReport); //게시글 신고등록

	void setReviewReport(ReviewReportDto reviewReport); //기업리뷰 신고등록

	void setReplyReport(ReplyReportDto replyReport); //댓글 신고등록
}