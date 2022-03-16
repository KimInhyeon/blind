package com.ksinfo.blind.member.vo;

<<<<<<< HEAD
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
=======
import java.util.Date;
>>>>>>> origin/master

public final class MemberVO {
	private long userId;
	private int userGeneration;
	private String userNickname;
	private Date nicknameChangeDate;
	private int reportedCount;
	private String userPassword;
	private String userEmail;
	private long companyId;
	private String userAuth;


	public long getUserId() {
		return userId;
	}

	public String getUserNickname() {
		return userNickname;
	}

	public int getUserGeneration() {
		return userGeneration;
	}

	public Date getNicknameChangeDate() {
		return nicknameChangeDate;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public void setUserGeneration(int userGeneration) {
		this.userGeneration = userGeneration;
	}

	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}

	public void setNicknameChangeDate(Date nicknameChangeDate) {
		this.nicknameChangeDate = nicknameChangeDate;
	}

	public int getReportedCount() {
		return reportedCount;
	}

	public void setReportedCount(int reportedCount) {
		this.reportedCount = reportedCount;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(long companyId) {
		this.companyId = companyId;
	}

	public String getUserAuth() {
		return userAuth;
	}

	public void setUserAuth(String userAuth) {
		this.userAuth = userAuth;
	}
}
