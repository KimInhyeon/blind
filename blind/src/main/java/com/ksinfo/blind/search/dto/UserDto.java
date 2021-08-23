package com.ksinfo.blind.search.dto;

public class UserDto {
	//3.USER_MGT //유저관리 테이블 그대로
	private int userId; //user_id bigint GENERATED ALWAYS AS IDENTITY //작성자인지 일치확인
	private String userNickName;  // user_nickName character varying(30)
	private String nickNamechangeDate; //nickName_change_date date not null
	private int companyId; //company_id bigint
	private char logicalDelFlag; //logical_del_flag character(1) not null
	//임의추가
	private String userCompanyName; //이전의 writerCompany

	// get/set메소드 모음

	public int getUserId() {
		return userId;
	}

	public String getUserCompanyName() {
		return userCompanyName;
	}

	public void setUserCompanyName(String userCompanyName) {
		this.userCompanyName = userCompanyName;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUserNickName() {
		return userNickName;
	}

	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}

	public String getNickNamechangeDate() {
		return nickNamechangeDate;
	}

	public void setNickNamechangeDate(String nickNamechangeDate) {
		this.nickNamechangeDate = nickNamechangeDate;
	}

	public int getCompanyId() {
		return companyId;
	}

	public void setCompanyId(int companyId) {
		this.companyId = companyId;
	}

	public char getLogicalDelFlag() {
		return logicalDelFlag;
	}

	public void setLogicalDelFlag(char logicalDelFlag) {
		this.logicalDelFlag = logicalDelFlag;
	}
}