package com.ksinfo.blind.alert.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.alert.dto.ReportReasonDto;
import com.ksinfo.blind.alert.mapper.AlertMapper;


@Service 
public class AlertService {
	@Autowired 
	public AlertMapper mapper; 
	
	public List<ReportReasonDto> getAlertReasonList(int alertType) { 
		return mapper.getAlertReasonList(alertType);    
	}
	
}
