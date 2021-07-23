package com.ksinfo.blind.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.member.dto.SalaryRankingDto;
import com.ksinfo.blind.member.mapper.MemberMypageMapper;

@Service
public class MemberMypageService {
	
	@Autowired
	public MemberMypageMapper mapper;
	
	public String getUsersCompanyName(int companyId) {
		return mapper.getUsersCompanyName(companyId);
	}
	
	public int getPostCountsThisMonth(int userId) {
		return  mapper.getPostCountsThisMonth(userId);
	}
	
	public int getPostLikeCountThisMonth(int userId) {
		return  mapper.getPostLikeCountThisMonth(userId);
	}

	/*DB의 데이터를 먼저 작성후 테스트 진행예정
	public int getPostReplyCountThisMonth(int userId) {
		return  mapper.getPostReplyCountThisMonth(userId);
	}*/

	public float getSalaryRankingData(int userId){
		return mapper.getSalaryRankingData(userId);
	}

}
