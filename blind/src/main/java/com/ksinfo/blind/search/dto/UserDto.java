package com.ksinfo.blind.search.dto;

public class UserDto {
	//3.USER_MGT //�������� ���̺�
	private String userUserId;				//user_id bigint GENERATED ALWAYS AS IDENTITY		//�ۼ������� ��ġȮ��
	private String userNickName;			// user_nickName character varying(30)
	private String nickNamechangeDate;	// nickName_change_date date not null
	private String companyId;				// company_id bigint
	private char   userLogicalDelFlag; 	    // logical_del_flag character(1) not null


	//3.USER_MGT //�������� ���̺�	
	public String getUserUserId() {
		return userUserId;
	}

	public void setUserUserId(String userUserId) {
		this.userUserId = userUserId;
	}

	public char getUserLogicalDelFlag() {
		return userLogicalDelFlag;
	}

	public void setUserLogicalDelFlag(char userLogicalDelFlag) {
		this.userLogicalDelFlag = userLogicalDelFlag;
	}

}
