package com.ksinfo.blind.common.mapper;

import com.ksinfo.blind.common.dto.NicknameChangeDto;
import com.ksinfo.blind.security.Account;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface NicknameMapper {
	boolean checkNickname(String newNickname);

	Account changeNickname(NicknameChangeDto nicknameChangeDto);
}