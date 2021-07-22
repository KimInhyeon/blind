package com.ksinfo.blind.manage.service;

import com.ksinfo.blind.manage.dto.ReportSearchDto;
import com.ksinfo.blind.manage.dto.ReportVerifyDto;
import com.ksinfo.blind.manage.mapper.ReportMapper;
import com.ksinfo.blind.manage.vo.ReportVO;
import com.ksinfo.blind.util.PageNavigator;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class ReportService {
	private static final int recordLimit = 10;
	private static final int pagination = 5;
	private final ReportMapper reportMapper;

	@Autowired
	public ReportService(ReportMapper reportMapper) {
		this.reportMapper = reportMapper;
	}

	public PageNavigator getNavigator(int page, char type, ReportSearchDto reportSearchDto) {
		int totalRecord;
		switch (type) {
			case '1':
				totalRecord = reportMapper.getPostReportTotalRecord(reportSearchDto);
				break;
			case '2':
				totalRecord = reportMapper.getReplyReportTotalRecord(reportSearchDto);
				break;
			case '3':
				totalRecord = reportMapper.getReviewReportTotalRecord(reportSearchDto);
				break;
			default:
				totalRecord = reportMapper.getReportTotalRecord(reportSearchDto);
				break;
		}

		return new PageNavigator(page, totalRecord, recordLimit, pagination);
	}

	public List<ReportVO> getReportList(int page, char type, ReportSearchDto reportSearchDto) {
		int offset = (page - 1) * recordLimit;
		RowBounds rowBounds = new RowBounds(offset, recordLimit);
		switch (type) {
			case '1':
				return reportMapper.getPostReportList(rowBounds, reportSearchDto);
			case '2':
				return reportMapper.getReplyReportList(rowBounds, reportSearchDto);
			case '3':
				return reportMapper.getReviewReportList(rowBounds, reportSearchDto);
			default:
				return reportMapper.getReportList(rowBounds, reportSearchDto);
		}
	}

	public Map<String, Object> getReport(char type, long targetId) {
		return reportMapper.getReport(type, targetId);
	}

	@Transactional
	public boolean verifyReport(ReportVerifyDto verifyData) {
		try {
			reportMapper.verifyReport(verifyData);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}