package com.ksinfo.blind.manage.mapper;

import com.ksinfo.blind.manage.dto.ReportSearchDto;
import com.ksinfo.blind.manage.dto.ReportVerifyDto;
import com.ksinfo.blind.manage.vo.ReportVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface ReportMapper {
	int getPostReportTotalRecord(ReportSearchDto reportSearchDto);

	int getReplyReportTotalRecord(ReportSearchDto reportSearchDto);

	int getReviewReportTotalRecord(ReportSearchDto reportSearchDto);

	int getReportTotalRecord(ReportSearchDto reportSearchDto);

	List<ReportVO> getPostReportList(RowBounds rowBounds, ReportSearchDto reportSearchDto);

	List<ReportVO> getReplyReportList(RowBounds rowBounds, ReportSearchDto reportSearchDto);

	List<ReportVO> getReviewReportList(RowBounds rowBounds, ReportSearchDto reportSearchDto);

	List<ReportVO> getReportList(RowBounds rowBounds, ReportSearchDto reportSearchDto);

	Map<String, Object> getReport(char type, long targetId);

	void verifyReport(ReportVerifyDto verifyData);
}