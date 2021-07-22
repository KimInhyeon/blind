package com.ksinfo.blind.common.service;

import com.ksinfo.blind.common.dto.NicknameChangeDto;
import com.ksinfo.blind.common.mapper.NicknameMapper;
import com.ksinfo.blind.security.Account;
import com.ksinfo.blind.util.BadWordsUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.Collection;

@Service
public class NicknameService {
	private final NicknameMapper nicknameMapper;
	private final BadWordsUtil badWordsUtil;

	@Autowired
	public NicknameService(NicknameMapper nicknameMapper, BadWordsUtil badWordsUtil) {
		this.nicknameMapper = nicknameMapper;
		this.badWordsUtil = badWordsUtil;
	}

	public boolean checkNickname(String newNickname) {
		return badWordsUtil.isContainsBadWord(newNickname) || nicknameMapper.checkNickname(newNickname);
	}

	public boolean changeNickname(String newNickname, Account account) {
		if (newNickname.length() > 0 && !badWordsUtil.isContainsBadWord(newNickname)) {
			LocalDate possibleDate = new Date(account.getNicknameChangeDate().getTime()).toLocalDate().plusMonths(3);
			if (LocalDate.now().compareTo(possibleDate) > -1 && !nicknameMapper.checkNickname(newNickname)) {
				try {
					NicknameChangeDto nicknameChangeDto = new NicknameChangeDto(newNickname, account);
					Collection<? extends GrantedAuthority> authorities = account.getAuthorities();
					account = nicknameMapper.changeNickname(nicknameChangeDto);
					account.setAuthorities(authorities);
					SecurityContextHolder.getContext().setAuthentication(
						new UsernamePasswordAuthenticationToken(account, account.getPassword(), account.getAuthorities())
					);
					return true;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return false;
	}
}