package com.ksinfo.blind.myPage_temp.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMyPageMapper {
	String getUsersCompanyName(long companyId);

	int getPostCountsThisMonth(long userId);

	int getPostLikeCountThisMonth(long userId);

	//int getPostReplyCountThisMonth(int userId); //관련 데이터를 먼저 작성후 테스트.
	float getSalaryRankingData(long userId);

	String getCurrentPassword(long userId);

	void updateToNewPassword(java.util.Map<String, Object> paramMap);
}