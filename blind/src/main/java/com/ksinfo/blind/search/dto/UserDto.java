package com.ksinfo.blind.search.dto;

public class UserDto {
	//3.USER_MGT //유저관리 테이블
	private int    userId;				//user_id bigint GENERATED ALWAYS AS IDENTITY		//작성자인지 일치확인
	private String userNickName;		// user_nickName character varying(30)
	private String nickNamechangeDate;	// nickName_change_date date not null
	private String companyId;			// company_id bigint
	private char   userLogicalDelFlag; 	// logical_del_flag character(1) not null


	//3.USER_MGT //유저관리 테이블	


	public char getUserLogicalDelFlag() {
		return userLogicalDelFlag;
	}

	public int getUserId() {
		return userId;
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

	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	public void setUserLogicalDelFlag(char userLogicalDelFlag) {
		this.userLogicalDelFlag = userLogicalDelFlag;
	}

}
