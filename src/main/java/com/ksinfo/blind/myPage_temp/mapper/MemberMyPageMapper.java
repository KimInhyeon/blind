package com.ksinfo.blind.myPage_temp.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface MemberMyPageMapper {
	String getUsersCompanyName(long companyId);

	int getPostCountsThisMonth(long userId);

	int getPostLikeCountThisMonth(long userId);

	//int getPostReplyCountThisMonth(long userId); //관련 데이터를 먼저 작성후 테스트.
	float getSalaryRankingData(long userId);

	String getCurrentPassword(long userId);

	void updateToNewPassword(Map<String, Object> paramMap);
}