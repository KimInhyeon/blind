package com.ksinfo.blind.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.member.mapper.MemberMypageMapper;

@Service
public class MemberMypageService {
	
	@Autowired
	public MemberMypageMapper mapper;
	@Autowired
	PasswordEncoder passwordEncoder;
	
	public String getUsersCompanyName(int companyId) {
		return mapper.getUsersCompanyName(companyId);
	}
	
	public int getPostCountsThisMonth(int userId) {
		return  mapper.getPostCountsThisMonth(userId);
	}
	
	public int getPostLikeCountThisMonth(int userId) {
		return  mapper.getPostLikeCountThisMonth(userId);
	}

	//게시글에 대한 댓글 카운트 
	/*DB의 데이터를 먼저 작성후 테스트 진행예정
	public int getPostReplyCountThisMonth(int userId) {
		return  mapper.getPostReplyCountThisMonth(userId);
	}*/

	public float getSalaryRankingData(int userId){
		return mapper.getSalaryRankingData(userId);
	}
	
}
