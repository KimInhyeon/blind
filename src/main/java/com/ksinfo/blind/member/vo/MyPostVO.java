package com.ksinfo.blind.member.vo;

public final class MyPostVO {
	private final String type;
	private final long postId;
	private final String postTitle;
	private final String companyName; // type='新規ポスト履歴':boardTopicName
	private final String userNickname; // type='通報履歴':reporterUserNickname
	private final String recCreateDate;

	public MyPostVO(String type, long postId, String postTitle, String companyName, String userNickname, String recCreateDate) {
		this.type = type;
		this.postId = postId;
		this.postTitle = postTitle;
		this.companyName = companyName;
		this.userNickname = userNickname;
		this.recCreateDate = recCreateDate;
	}

	public String getType() {
		return type;
	}

	public long getPostId() {
		return postId;
	}

	public String getPostTitle() {
		return postTitle;
	}

	public String getCompanyName() {
		return companyName;
	}

	public String getUserNickname() {
		return userNickname;
	}

	public String getRecCreateDate() {
		return recCreateDate;
	}
}