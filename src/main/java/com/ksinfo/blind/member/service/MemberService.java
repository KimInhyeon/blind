package com.ksinfo.blind.member.service;

import java.time.LocalDate;
import java.time.ZoneId;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.ksinfo.blind.member.dto.RegisterMemberDto;
import com.ksinfo.blind.member.mapper.MemberMapper;
import com.ksinfo.blind.member.vo.MemberVO;
import com.ksinfo.blind.security.Account;
import com.ksinfo.blind.util.BadWordsUtil;
import com.ksinfo.blind.util.MessageUtils;
import com.ksinfo.blind.util.SecurityUtil;

@Service
public class MemberService implements UserDetailsService {
	private final BadWordsUtil badWordsUtil;
	private final SecurityUtil securityUtil;
	private final PasswordEncoder passwordEncoder;
	private final MessageUtils messages;
	private final MemberMapper memberMapper;

	@Autowired
	public MemberService(
		BadWordsUtil badWordsUtil, SecurityUtil securityUtil, PasswordEncoder passwordEncoder,
		MessageUtils messages, MemberMapper memberMapper
	) {
		this.badWordsUtil = badWordsUtil;
		this.securityUtil = securityUtil;
		this.passwordEncoder = passwordEncoder;
		this.messages = messages;
		this.memberMapper = memberMapper;
	}

	@Override
	@Transactional(readOnly = true)
	public UserDetails loadUserByUsername(String inputEmail) throws UsernameNotFoundException {
		Account account = memberMapper.loadUserByUsername(securityUtil.encryptSHA256(inputEmail));
		if (account == null) {
			throw new UsernameNotFoundException(messages.getMessage("BLIND_ERR_MSG_001"));
		}

		return account;
	}

	@Transactional(readOnly = true)
	public Account getLatestMemberInformation(Account account) {
		return memberMapper.getLatestMemberInformation(account);
	}

	public void registerNewMember(RegisterMemberDto member) {
		// TODO Auto-generated method stub
		member.setUserEmail(securityUtil.encryptSHA256(member.getUserEmail()));
		member.setUserPassword(passwordEncoder.encode(member.getUserPassword()));

		memberMapper.registerNewMember(member);
	}

	@Transactional(readOnly = true)
	public boolean checkNickname(String newNickname) {
		return badWordsUtil.isContainsBadWord(newNickname) || memberMapper.isDuplicatedNickname(newNickname);
	}

	@Transactional(isolation = Isolation.SERIALIZABLE)
	public boolean changeNickname(String newNickname, Account account) {
		if (newNickname.length() > 0 && !badWordsUtil.isContainsBadWord(newNickname)) {
			LocalDate possibleDate = account.getNicknameChangeDate().toLocalDate().plusMonths(3);
			if (LocalDate.now().compareTo(possibleDate) > -1 && !memberMapper.isDuplicatedNickname(newNickname)) {
				String userNickname = account.getUserNickname();
				int userGeneration = account.getUserGeneration();
				try {
					if (memberMapper.invalidateOldNickname(account) > 0) {
						account.setUserNickname(newNickname);
						account.setUserGeneration(userGeneration + 1);
						memberMapper.validateNewNickname(account);
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
	
	@Transactional(isolation = Isolation.SERIALIZABLE)
	public boolean changeNicknameApp(String newNickname, MemberVO memberVO) {
		if (newNickname.length() > 0 && !badWordsUtil.isContainsBadWord(newNickname)) {
			System.out.println(newNickname);
			LocalDate possibleDate = memberVO.getNicknameChangeDate().toInstant()
			.atZone(ZoneId.systemDefault())
					.toLocalDate().plusMonths(3);
			if (LocalDate.now().compareTo(possibleDate) > -1 && !memberMapper.isDuplicatedNickname(newNickname)) {
				String userNickname = memberVO.getUserNickname();
				int userGeneration = memberVO.getUserGeneration();
				try {
					if (memberMapper.invalidateOldNicknameApp(memberVO) > 0) {
						memberVO.setUserNickname(newNickname);
						memberVO.setUserGeneration(userGeneration + 1);
						memberMapper.validateNewNicknameApp(memberVO);
						return true;
					}
				} catch (Exception e) {
					e.printStackTrace();
					memberVO.setUserNickname(userNickname);
					memberVO.setUserGeneration(userGeneration);
				}
			}
		}
		return false;
	}

	public boolean checkPassword(String inputPassword, String targetPassword) {
		return passwordEncoder.matches(inputPassword, targetPassword);
	}
	
	public MemberVO getmodifyProfileApp(long userId){
		return memberMapper.getmodifyProfileApp(userId);
	}
}