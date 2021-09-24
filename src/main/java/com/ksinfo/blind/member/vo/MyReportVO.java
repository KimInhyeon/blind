package com.ksinfo.blind.member.vo;

public class MyReportVO {
	private final String type;
	private final String title;
	private final String groupName; // type='レビュー': jobGroupName, type='ポスト': boardTopicName
	private final String userNickname;
	private final String companyName;
	private final String recCreateDate;
	private final String status;

	public MyReportVO(
		String type, String title, String groupName, String userNickname,
		String companyName, String recCreateDate, String status
	) {
		this.type = type;
		this.title = title;
		this.groupName = groupName;
		this.userNickname = userNickname;
		this.companyName = companyName;
		this.recCreateDate = recCreateDate;
		this.status = status;
	}

	public String getType() {
		return type;
	}

	public String getTitle() {
		return title;
	}

	public String getGroupName() {
		return groupName;
	}

	public String getUserNickname() {
		return userNickname;
	}

	public String getCompanyName() {
		return companyName;
	}

	public String getRecCreateDate() {
		return recCreateDate;
	}

	public String getStatus() {
		return status;
	}
}