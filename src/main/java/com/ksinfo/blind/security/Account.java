package com.ksinfo.blind.security;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public final class Account implements UserDetails {
	private static final long serialVersionUID = 1L;

	private long userId;
	private int userGeneration;
	private String userPassword;
	private String userEmail;
	private String userNickname;
	private Date nicknameChangeDate;
	private long companyId;
	private List<GrantedAuthority> authorities;
	private int reportedCount;

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

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserNickname() {
		return userNickname;
	}

	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}

	public Date getNicknameChangeDate() {
		return nicknameChangeDate;
	}

	public void setNicknameChangeDate(Date nicknameChangeDate) {
		this.nicknameChangeDate = nicknameChangeDate;
	}

	public long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(long companyId) {
		this.companyId = companyId;
	}

	@Override
	public List<GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return authorities;
	}

	public void setUserAuth(String userAuth) {
		List<GrantedAuthority> authorities = new ArrayList<>(1);
		authorities.add(new SimpleGrantedAuthority(userAuth));
		this.authorities = authorities;
	}

	public int getReportedCount() {
		return reportedCount;
	}

	public void setReportedCount(int reportedCount) {
		this.reportedCount = reportedCount;
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
		return reportedCount < 3;
	}
}