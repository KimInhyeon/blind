package com.ksinfo.blind.common.dto;

import com.ksinfo.blind.security.Account;

public final class NicknameChangeDto {
	private final long userId;
	private final int userGeneration;
	private final String userPassword;
	private final String userEmail;
	private final String userNickname;
	private final long companyId;
	private final String userAuth;
	private final int reportedCount;

	public NicknameChangeDto(String newNickname, Account account) {
		userId = account.getUserId();
		userGeneration = account.getUserGeneration() + 1;
		userPassword = account.getPassword();
		userEmail = account.getUserEmail();
		userNickname = newNickname;
		companyId = account.getCompanyId();
		userAuth = account.getUserAuth();
		reportedCount = account.getReportedCount();
	}

	public long getUserId() {
		return userId;
	}

	public int getUserGeneration() {
		return userGeneration;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public String getUserNickname() {
		return userNickname;
	}

	public long getCompanyId() {
		return companyId;
	}

	public String getUserAuth() {
		return userAuth;
	}

	public int getReportedCount() {
		return reportedCount;
	}
}