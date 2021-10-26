package com.ksinfo.blind.board.vo;

public final class PostRecommendVO {
	private final int postRecommendCount;
	private final boolean recommended;

	public PostRecommendVO(int postRecommendCount, boolean recommended) {
		this.postRecommendCount = postRecommendCount;
		this.recommended = recommended;
	}

	public int getPostRecommendCount() {
		return postRecommendCount;
	}

	public boolean isRecommended() {
		return recommended;
	}
}