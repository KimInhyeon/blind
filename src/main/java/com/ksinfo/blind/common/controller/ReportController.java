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

	//신고하기 테스트 페이지로 이동
	@GetMapping
	public ModelAndView reportModal() {
		ModelAndView modelAndView = new ModelAndView("main/common/reportModal");
		modelAndView.addObject("title", "Report Modal");

		//임의의 데이터 추가.
		int userId = 9990;            //신고자의 id(닉네임이 아님)
		modelAndView.addObject("userId", userId);

		int postId = 1000;            //게시글의 id
		modelAndView.addObject("postId", postId);

		int companyReviewId = 2000;//기업리뷰글의 id
		modelAndView.addObject("companyReviewId", companyReviewId);

		int replyId = 3000;           //댓글의 id
		modelAndView.addObject("replyId", replyId);

		return modelAndView;
	}

	//1.신고버튼 클릭시 해당 신고유형에 맞는 신고리스트들을 리턴.
	@ResponseBody
	@PostMapping("list")
	public List<ReportReasonDto> getReportReasonList(@RequestParam Map<String, Object> param) {
		logger.info("getReportReasonList 시작.");

		logger.info("reportType : " + param.get("reportType"));
		String reportType = (String) param.get("reportType"); //형변환 (Object->String)

		//입력된 신고유형은 xml의 where문을 활용하여 분류실시.(따라서 switch문 실시않음)
		//신고유형에 해당하는 신고사유들을 리턴.
		List<ReportReasonDto> reportReasonList = reportService.getReportReasonList(reportType);

		logger.info("getReportReasonList 종료.");

		return reportReasonList;
	}

	//2.수신된 신고사항을 DB에 저장
	@ResponseBody
	@PostMapping
	public int report(@RequestParam Map<String, Object> param, @AuthenticationPrincipal Account account) {
		// 작성편의 및 post/review/reply ReportDto에 맞도록 변수를 저장.
		long postId = Long.parseLong(param.get("postId").toString());
		long companyReviewId = Long.parseLong(param.get("companyReviewId").toString());
		long replyId = Long.parseLong(param.get("replyId").toString());
		long userId = account.getUserId();

		String reportReasonCode = param.get("reportReasonCode").toString();
		String reportType = param.get("reportType").toString();
		String reportReasonContent = param.get("report_reason_content").toString();

		switch (reportType) {
			case "0006":  //post신고
				PostReportDto postReport = new PostReportDto();
				postReport.setPostId(postId);
				postReport.setUserId(userId);
				postReport.setReportReasonCode(reportReasonCode);
				postReport.setReportReasonContent(reportReasonContent);

				reportService.setPostReport(postReport);
				return 1; //정상적으로 신고접수.

			case "0008":  //기업리뷰 신고
				ReviewReportDto reviewReport = new ReviewReportDto();
				reviewReport.setCompanyReviewId(companyReviewId);
				reviewReport.setUserId(userId);
				reviewReport.setReportReasonCode(reportReasonCode);
				reviewReport.setReportReasonContent(reportReasonContent);

				reportService.setReviewReport(reviewReport);
				return 1; //정상적으로 신고접수.

			case "0012":  //댓글 신고
				ReplyReportDto replyReport = new ReplyReportDto();
				replyReport.setReplyId(replyId);
				replyReport.setUserId(userId);
				replyReport.setReportReasonCode(reportReasonCode);
				replyReport.setReportReasonContent(reportReasonContent);

				reportService.setReplyReport(replyReport);
				return 1; //정상적으로 신고접수.
		}

		return 0; //에러발생으로 판단.
	}
}