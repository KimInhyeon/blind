package com.ksinfo.blind.board.vo;

public final class ReplyRecommendVO {
	private final int replyRecommendCount;
	private final boolean recommended;

	public ReplyRecommendVO(int replyRecommendCount, boolean recommended) {
		this.replyRecommendCount = replyRecommendCount;
		this.recommended = recommended;
	}

	public int getReplyRecommendCount() {
		return replyRecommendCount;
	}

	public boolean isRecommended() {
		return recommended;
	}
}