package com.ksinfo.blind.board.vo;

import java.util.List;

public final class PostAndReplyVO {
	private final PostVO post;
	private final List<ReplyVO> replyList;

	public PostAndReplyVO(PostVO post, List<ReplyVO> replyList) {
		this.post = post;
		this.replyList = replyList;
	}

	public PostVO getPost() {
		return post;
	}

	public List<ReplyVO> getReplyList() {
		return replyList;
	}
}