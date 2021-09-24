package com.ksinfo.blind.manage.service;

import com.ksinfo.blind.manage.dto.ReportSearchDto;
import com.ksinfo.blind.manage.dto.ReportVerifyDto;
import com.ksinfo.blind.manage.mapper.ManageReportMapper;
import com.ksinfo.blind.manage.vo.ReportVO;
import com.ksinfo.blind.util.PageNavigator;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class ManageReportService {
	private static final int recordLimit = 10;
	private static final int pagination = 5;
	private final ManageReportMapper manageReportMapper;

	@Autowired
	public ManageReportService(ManageReportMapper manageReportMapper) {
		this.manageReportMapper = manageReportMapper;
	}

	@Transactional(readOnly = true)
	public PageNavigator getNavigator(int page, char type, ReportSearchDto reportSearchDto) {
		int totalRecord;
		switch (type) {
			case '1':
				totalRecord = manageReportMapper.getTotalPostReportRecord(reportSearchDto);
				break;
			case '2':
				totalRecord = manageReportMapper.getTotalReplyReportRecord(reportSearchDto);
				break;
			case '3':
				totalRecord = manageReportMapper.getTotalReviewReportRecord(reportSearchDto);
				break;
			default:
				totalRecord = manageReportMapper.getTotalReportRecord(reportSearchDto);
				break;
		}

		return new PageNavigator(page, totalRecord, recordLimit, pagination);
	}

	@Transactional(readOnly = true)
	public List<ReportVO> getReportList(int page, char type, ReportSearchDto reportSearchDto) {
		int offset = (page - 1) * recordLimit;
		RowBounds rowBounds = new RowBounds(offset, recordLimit);
		switch (type) {
			case '1':
				return manageReportMapper.getPostReportList(rowBounds, reportSearchDto);
			case '2':
				return manageReportMapper.getReplyReportList(rowBounds, reportSearchDto);
			case '3':
				return manageReportMapper.getReviewReportList(rowBounds, reportSearchDto);
			default:
				return manageReportMapper.getReportList(rowBounds, reportSearchDto);
		}
	}

	@Transactional(readOnly = true)
	public Map<String, Object> getReport(char type, long targetId) {
		return manageReportMapper.getReport(type, targetId);
	}

	@Transactional(isolation = Isolation.SERIALIZABLE)
	public boolean verifyReport(ReportVerifyDto verifyData) {
		try {
			manageReportMapper.verifyReport(verifyData);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}