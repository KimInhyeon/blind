package com.ksinfo.blind.member.dto;

import java.time.LocalDate;
import java.util.Date;

public class MemberDto {
	private long userId;
	private int userGeneration;
	private String userNickname;
	private LocalDate nicknameChangeDate;

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public int getUserGeneration() {
		return userGeneration;
	}

	public void setUserGeneration(int userGeneration) {
		this.userGeneration = userGeneration;
	}

	public String getUserNickname() {
		return userNickname;
	}

	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}

	public LocalDate getNicknameChangeDate() {
		return nicknameChangeDate;
	}

	public void setNicknameChangeDate(LocalDate nicknameChangeDate) {
		this.nicknameChangeDate = nicknameChangeDate;
	}
}
