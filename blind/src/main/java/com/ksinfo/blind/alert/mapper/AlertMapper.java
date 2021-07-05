package com.ksinfo.blind.alert.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.alert.dto.PostReportDto;
import com.ksinfo.blind.alert.dto.ReportReasonDto;
import java.util.List;

@Repository
@Mapper 
public interface AlertMapper {
	List<ReportReasonDto> getAlertReasonList(String alertType);
	void setPostReport(PostReportDto postReport);
}
