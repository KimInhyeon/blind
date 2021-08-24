package com.ksinfo.blind.common.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.security.Account;

@Repository
@Mapper 
public interface MemberMapper {
	Account findMemberByEmail(String userEmail);

	int registNewMember(java.util.Map<String, Object> paramMap);
}