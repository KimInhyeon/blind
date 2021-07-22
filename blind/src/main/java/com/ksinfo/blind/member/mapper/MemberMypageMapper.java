package com.ksinfo.blind.member.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.member.dto.SalaryRankingDto;

@Repository
@Mapper
public interface MemberMypageMapper {
	String getUsersCompanyName(int companyId);
	int getPostCountsThisMonth(int userId);
	int getPostLikeCountThisMonth(int userId);
	//int getPostReplyCountThisMonth(int userId); //관련 데이터를 먼저 작성후 테스트.
	List<SalaryRankingDto> getSalaryRankingData();
}
