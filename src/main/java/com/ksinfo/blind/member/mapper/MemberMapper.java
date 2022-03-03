package com.ksinfo.blind.member.mapper;

import com.ksinfo.blind.member.dto.MemberDto;
import com.ksinfo.blind.member.vo.MemberVO;
import com.ksinfo.blind.security.Account;
import com.ksinfo.blind.member.dto.RegisterMemberDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {
	Account loadUserByUsername(String inputEmail);

	Account getLatestMemberInformation(Account account);

	void registerNewMember(RegisterMemberDto member);

	boolean isDuplicatedNickname(String newNickname);

	int invalidateOldNickname(Account account);

	int invalidateOldNicknameApp(MemberVO memberVO);

	void validateNewNickname(Account account);

	void validateNewNicknameApp(MemberVO memberVO);

	MemberVO getmodifyProfileApp(long userId);
}