
package com.ksinfo.blind.common.service;

import com.ksinfo.blind.common.dto.PostReportDto;
import com.ksinfo.blind.common.dto.ReplyReportDto;
import com.ksinfo.blind.common.dto.ReportReasonDto;
import com.ksinfo.blind.common.dto.ReviewReportDto;
import com.ksinfo.blind.common.mapper.ReportMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
public class ReportService {
	private final ReportMapper reportMapper;

	@Autowired
	public ReportService(ReportMapper reportMapper) {
		this.reportMapper = reportMapper;
	}

	@Transactional(readOnly = true)
	public List<ReportReasonDto> getReportReasonList(String reportType) {
		return reportMapper.getReportReasonList(reportType);
	}

	public void setPostReport(PostReportDto postReport) {
		reportMapper.setPostReport(postReport);
	}

	public void setReviewReport(ReviewReportDto reviewReport) {//기업리뷰 신고등록
		reportMapper.setReviewReport(reviewReport);
	}

	public void setReplyReport(ReplyReportDto replyReport) {//댓글 신고등록
		reportMapper.setReplyReport(replyReport);
	}
}