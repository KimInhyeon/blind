package com.ksinfo.blind.common.service;

import com.ksinfo.blind.common.mapper.NicknameMapper;
import com.ksinfo.blind.security.Account;
import com.ksinfo.blind.util.BadWordsUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.time.LocalDate;

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
		return badWordsUtil.isContainsBadWord(newNickname) || nicknameMapper.isDuplicatedNickname(newNickname);
	}

	@Transactional
	public boolean changeNickname(String newNickname, Account account) {
		if (newNickname.length() > 0 && !badWordsUtil.isContainsBadWord(newNickname)) {
			LocalDate possibleDate = new Date(account.getNicknameChangeDate().getTime()).toLocalDate().plusMonths(3);
			if (LocalDate.now().compareTo(possibleDate) > -1 && !nicknameMapper.isDuplicatedNickname(newNickname)) {
				String userNickname = account.getUserNickname();
				int userGeneration = account.getUserGeneration();
				try {
					if (nicknameMapper.invalidateOldNickname(account) > 0) {
						account.setUserNickname(newNickname);
						account.setUserGeneration(userGeneration + 1);
						nicknameMapper.validateNewNickname(account);
						return true;
					}
				} catch (Exception e) {
					e.printStackTrace();
					account.setUserNickname(userNickname);
					account.setUserGeneration(userGeneration);
				}
			}
		}
		return false;
	}
}