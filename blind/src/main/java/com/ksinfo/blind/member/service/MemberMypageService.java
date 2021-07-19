package com.ksinfo.blind.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.member.mapper.MemberMypageMapper;

@Service
public class MemberMypageService {
	
	@Autowired
	public MemberMypageMapper mapper;
	
	public String getUsersCompanyName(int companyId) {
		return mapper.getUsersCompanyName(companyId);
	}
}
