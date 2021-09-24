package com.ksinfo.blind.myPage_temp.service;

import com.ksinfo.blind.myPage_temp.mapper.MemberMyPageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;


@Service
public class MemberMyPageService {
	private final MemberMyPageMapper memberMyPageMapper;
	private final PasswordEncoder passwordEncoder;

	@Autowired
	public MemberMyPageService(MemberMyPageMapper memberMyPageMapper, PasswordEncoder passwordEncoder) {
		this.memberMyPageMapper = memberMyPageMapper;
		this.passwordEncoder = passwordEncoder;
	}

	@Transactional(readOnly = true)
	public String getUsersCompanyName(long companyId) {
		return memberMyPageMapper.getUsersCompanyName(companyId);
	}

	@Transactional(readOnly = true)
	public int getPostCountsThisMonth(long userId) {
		return memberMyPageMapper.getPostCountsThisMonth(userId);
	}

	@Transactional(readOnly = true)
	public int getPostLikeCountThisMonth(long userId) {
		return memberMyPageMapper.getPostLikeCountThisMonth(userId);
	}

	//게시글에 대한 댓글 카운트
	/*DB의 데이터를 먼저 작성후 테스트 진행예정
	@Transactional(readOnly = true)
	public int getPostReplyCountThisMonth(long userId) {
		return  mapper.getPostReplyCountThisMonth(userId);
	}*/

	@Transactional(readOnly = true)
	public float getSalaryRankingData(long userId) {
		return memberMyPageMapper.getSalaryRankingData(userId);
	}

	@Transactional(readOnly = true)
	public String getCurrentPassword(long userId) {
		return memberMyPageMapper.getCurrentPassword(userId);
	}

	public void updateToNewPassword(long userId, String inputNewPassword) {
		java.util.Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("userId", userId);
		//passwordEncoder.upgradeEncoding(inputNewPassword) ;
		paramMap.put("newPassword", passwordEncoder.encode(inputNewPassword));
		memberMyPageMapper.updateToNewPassword(paramMap);
	}
}