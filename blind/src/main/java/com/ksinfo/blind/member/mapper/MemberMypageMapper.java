package com.ksinfo.blind.member.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface MemberMypageMapper {
	String getUsersCompanyName(int companyId);
}
