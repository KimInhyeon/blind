package com.ksinfo.blind.manage.mapper;

import com.ksinfo.blind.manage.dto.ReportSearchDto;
import com.ksinfo.blind.manage.dto.ReportVerifyDto;
import com.ksinfo.blind.manage.vo.ReportVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.List;
import java.util.Map;

@Mapper
public interface ManageReportMapper {
	int getTotalPostReportRecord(ReportSearchDto reportSearchDto);

	int getTotalReplyReportRecord(ReportSearchDto reportSearchDto);

	int getTotalReviewReportRecord(ReportSearchDto reportSearchDto);

	int getTotalReportRecord(ReportSearchDto reportSearchDto);

	List<ReportVO> getPostReportList(RowBounds rowBounds, ReportSearchDto reportSearchDto);

	List<ReportVO> getReplyReportList(RowBounds rowBounds, ReportSearchDto reportSearchDto);

	List<ReportVO> getReviewReportList(RowBounds rowBounds, ReportSearchDto reportSearchDto);

	List<ReportVO> getReportList(RowBounds rowBounds, ReportSearchDto reportSearchDto);

	Map<String, Object> getReport(char type, long targetId);

	void verifyReport(ReportVerifyDto verifyData);
}