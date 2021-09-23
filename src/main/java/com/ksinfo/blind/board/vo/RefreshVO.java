package com.ksinfo.blind.board.vo;

import java.util.List;

public final class RefreshVO {
	private final int postCount;
	private final int replyCount;
	private final int postRecommendCount;
	private List<ReplyVO> replyList;

	public RefreshVO(int postCount, int replyCount, int postRecommendCount) {
		this.postCount = postCount;
		this.replyCount = replyCount;
		this.postRecommendCount = postRecommendCount;
	}

	public void setReplyList(List<ReplyVO> replyList) {
		this.replyList = replyList;
	}

	public int getPostCount() {
		return postCount;
	}

	public int getReplyCount() {
		return replyCount;
	}

	public int getPostRecommendCount() {
		return postRecommendCount;
	}

	public List<ReplyVO> getReplyList() {
		return replyList;
	}
}