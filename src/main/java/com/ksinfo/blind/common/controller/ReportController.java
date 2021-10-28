package com.ksinfo.blind.common.controller;

import com.ksinfo.blind.common.dto.PostReportDto;
import com.ksinfo.blind.common.dto.ReplyReportDto;
import com.ksinfo.blind.common.dto.ReportReasonDto;
import com.ksinfo.blind.common.dto.ReviewReportDto;
import com.ksinfo.blind.common.service.ReportService;
import com.ksinfo.blind.security.Account;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("report")
public final class ReportController {
	private static final Logger logger = LoggerFactory.getLogger(ReportController.class);
	private final ReportService reportService;

	@Autowired
	public ReportController(ReportService reportService) {
		this.reportService = reportService;
	}

	//1. return List of ReportTypes.
	@ResponseBody
	@PostMapping("list")
	public List<ReportReasonDto> getReportReasonList(@RequestParam Map<String, Object> param) {
		String reportType = (String) param.get("reportType"); //type change.(Object->String)

		//reportType(Post/companyReview/Reply) check, return report lists.
		List<ReportReasonDto> reportReasonList = reportService.getReportReasonList(reportType);

		return reportReasonList;
	}

	//2.save ReportData send by Users.
	@ResponseBody
	@PostMapping
	public int report(@RequestParam Map<String, Object> param, @AuthenticationPrincipal Account account) {
		long postId = Long.parseLong(param.get("postId").toString());
		long companyReviewId = Long.parseLong(param.get("companyReviewId").toString());
		long replyId = Long.parseLong(param.get("replyId").toString());
		long userId = account.getUserId();

		String reportReasonCode = param.get("reportReasonCode").toString();
		String reportType = param.get("reportType").toString();
		String reportReasonContent = param.get("report_reason_content").toString();

		switch (reportType) {
			case "0006":  //reportType:post
				PostReportDto postReport = new PostReportDto();
				postReport.setPostId(postId);
				postReport.setUserId(userId);
				postReport.setReportReasonCode(reportReasonCode);
				postReport.setReportReasonContent(reportReasonContent);

				reportService.setPostReport(postReport);
				return 1; // 1:ReportSuccess.

			case "0008":  //reportType:CompanyReview
				ReviewReportDto reviewReport = new ReviewReportDto();
				reviewReport.setCompanyReviewId(companyReviewId);
				reviewReport.setUserId(userId);
				reviewReport.setReportReasonCode(reportReasonCode);
				reviewReport.setReportReasonContent(reportReasonContent);

				reportService.setReviewReport(reviewReport);
				return 1; // 1:ReportSuccess.

			case "0012":  //reportType:Reply
				ReplyReportDto replyReport = new ReplyReportDto();
				replyReport.setReplyId(replyId);
				replyReport.setUserId(userId);
				replyReport.setReportReasonCode(reportReasonCode);
				replyReport.setReportReasonContent(reportReasonContent);

				reportService.setReplyReport(replyReport);
				return 1; // 1:ReportSuccess.
		}

		return 0; // 0:ReportFailed.
	}
}