package com.ksinfo.blind.search.dto;

public class UserDto {
	//3.USER_MGT //�������� ���̺� �״��
	private int    userId;				//user_id bigint GENERATED ALWAYS AS IDENTITY		//�ۼ������� ��ġȮ��
	private String userNickName;		// user_nickName character varying(30)
	private String nickNamechangeDate;	// nickName_change_date date not null
	private int companyId;			// company_id bigint
	private char   logicalDelFlag; 		// logical_del_flag character(1) not null
	//�����߰�
	private String userCompanyName;		//������ writerCompany

	// get/set�޼ҵ� ����
	
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
