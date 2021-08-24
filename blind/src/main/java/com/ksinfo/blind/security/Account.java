package com.ksinfo.blind.security;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;

public class Account implements UserDetails {
	private static final long serialVersionUID = 1L;

	private long userId;
	private int userGeneration;
	private String lastGenerationFlag;
	private String userPassword;
	private String userEmail;
	private String userNickname;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private java.util.Date nicknameChangeDate;
	private long companyId;
	private String userAuth;
	private int reportedCount;
	private Collection<? extends GrantedAuthority> authorities;

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return this.authorities;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return this.userPassword;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return userEmail;
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}

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

	public String getLastGenerationFlag() {
		return lastGenerationFlag;
	}

	public void setLastGenerationFlag(String lastGenerationFlag) {
		this.lastGenerationFlag = lastGenerationFlag;
	}

	public String getUserNickname() {
		return userNickname;
	}

	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}

	public java.util.Date getNicknameChangeDate() {
		return nicknameChangeDate;
	}

	public void setNicknameChangeDate(java.util.Date nicknameChangeDate) {
		this.nicknameChangeDate = nicknameChangeDate;
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

	public void setAuthorities(Collection<? extends GrantedAuthority> authorities) {
		this.authorities = authorities;
	}
}