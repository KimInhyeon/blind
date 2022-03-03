package com.ksinfo.blind.member.dto;

public final class RegisterMemberDto {
	private String userEmail;
	private String userPassword;
	private final String userNickname;
	private final String userAuth;

	public RegisterMemberDto(String username, String password, String nickname, String role) {
		userEmail = username;
		userPassword = password;
		userNickname = nickname;
		switch (role) {
			case "NM":
				userAuth = "ROLE_NM";
				break;
			case "RM":
				userAuth = "ROLE_RM";
				break;
			case "SV":
				userAuth = "ROLE_SV";
				break;
			default:
				userAuth = null;
				break;
		}
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getUserNickname() {
		return userNickname;
	}

	public String getUserAuth() {
		return userAuth;
	}

}