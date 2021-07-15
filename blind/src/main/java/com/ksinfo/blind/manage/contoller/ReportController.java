package com.ksinfo.blind.manage.contoller;

import com.ksinfo.blind.manage.dto.ReportSearchDto;
import com.ksinfo.blind.manage.dto.ReportVerifyDto;
import com.ksinfo.blind.manage.service.ReportService;
import com.ksinfo.blind.manage.vo.ReportVO;
import com.ksinfo.blind.security.Account;
import com.ksinfo.blind.util.PageNavigator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;

@RestController
public class ReportController {
	private final ReportService reportService;

	@Autowired
	public ReportController(ReportService reportService) {
		this.reportService = reportService;
	}

	@GetMapping(value = "manage/report")
	public ModelAndView report(String searchTarget, String searchKeyword,
		@RequestParam(name = "page", defaultValue = "1") int page,
		@RequestParam(name = "verifyFlag", defaultValue = "0") char verifyFlag,
		@RequestParam(name = "type", defaultValue = "0") char type
	) {
		ReportSearchDto reportSearchDto = new ReportSearchDto(verifyFlag, searchTarget, searchKeyword);
		PageNavigator navi = reportService.getNavigator(page, type, reportSearchDto);
		List<ReportVO> reportList = reportService.getReportList(navi.getCurrentPage(), type, reportSearchDto);

		ModelAndView modelAndView = new ModelAndView("main/manage/report");
		modelAndView.addObject("navi", navi);
		modelAndView.addObject("reportList", reportList);

		return modelAndView;
	}

	@GetMapping(value = "manage/report/{type}/{targetId}")
	public Map<String, Object> getReport(@PathVariable("type") char type, @PathVariable("targetId") long targetId) {
		Map<String, Object> result = reportService.getReport(type, targetId);

		return result;
	}

	@PatchMapping(value = "manage/report")
	public boolean verifyReport(@RequestBody ReportVerifyDto verifyData, @AuthenticationPrincipal Account account) {
		verifyData.setUserId(account.getUserId());

		return reportService.verifyReport(verifyData);
	}
}