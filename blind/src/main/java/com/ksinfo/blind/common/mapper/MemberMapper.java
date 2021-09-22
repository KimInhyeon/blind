package com.ksinfo.blind.common.mapper;

import com.ksinfo.blind.security.Account;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {
	Account findMemberByEmail(String userEmail);

	int registNewMember(java.util.Map<String, Object> paramMap);
}