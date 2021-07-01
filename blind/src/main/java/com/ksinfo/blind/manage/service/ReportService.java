package com.ksinfo.blind.manage.service;

import com.ksinfo.blind.manage.mapper.ReportMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReportService {
	private final ReportMapper reportMapper;

	@Autowired
	public ReportService(ReportMapper reportMapper) {
		this.reportMapper = reportMapper;
	}
}