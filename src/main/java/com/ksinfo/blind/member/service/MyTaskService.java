package com.ksinfo.blind.member.service;

import com.ksinfo.blind.member.mapper.MyTaskMapper;
import com.ksinfo.blind.member.vo.MyCompanyReviewVO;
import com.ksinfo.blind.member.vo.MyReportVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class MyTaskService {
	private final MyTaskMapper mytaskMapper;

	@Autowired
	public MyTaskService(MyTaskMapper mytaskMapper) {
		this.mytaskMapper = mytaskMapper;
	}

	@Transactional(readOnly = true)
	public List<MyCompanyReviewVO> getMyCompanyReviewList(long userId){

		return mytaskMapper.getMyCompanyReviewList(userId);
	}

	@Transactional(readOnly = true)
	public List<MyReportVO> getMyReportList(long userId){

		return mytaskMapper.getMyReportList(userId);
	}
}