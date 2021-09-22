package com.ksinfo.blind.common.mapper;

import com.ksinfo.blind.security.Account;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NicknameMapper {
	boolean isDuplicatedNickname(String newNickname);

	int invalidateOldNickname(Account account);

	void validateNewNickname(Account account);
}