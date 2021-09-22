package com.ksinfo.blind.board.vo;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ksinfo.blind.board.dto.ParagraphBlock;
import com.ksinfo.blind.board.dto.PostBlock;

import java.util.List;

public final class PostVO {
	private final long boardId;
	private final String boardTopicName;
	private final long postId;
	private final String postTitle;
	private final List<PostBlock> postContents;
	private final long companyId;
	private final String companyName;
	private final String userNickname;
	private final String postCreateDate;
	private final int postCount;
	private final boolean postRecommended;
	private final int postRecommendCount;
	private final boolean bookmarked;
	private final boolean writer;
	private final int replyCount;

	public PostVO(
		long boardId, String boardTopicName, long postId, String postTitle, String postContents,
		long companyId, String companyName, String userNickname, String postCreateDate, int postCount,
		boolean postRecommended, int postRecommendCount, boolean bookmarked, boolean writer, int replyCount
	) throws JsonProcessingException {
		this.boardId = boardId;
		this.boardTopicName = boardTopicName;
		this.postId = postId;
		this.postTitle = postTitle;
		this.postContents = new ObjectMapper().readValue(postContents, new TypeReference<>() {});
		for (int i = this.postContents.size() - 1; i > -1; --i) {
			PostBlock postBlock = this.postContents.get(i);
			if (postBlock instanceof ParagraphBlock) {
				((ParagraphBlock.ParagraphData) postBlock.getData()).setATagTarget();
			}
		}
		this.companyId = companyId;
		this.companyName = companyName;
		this.userNickname = userNickname;
		this.postCreateDate = postCreateDate;
		this.postCount = postCount;
		this.postRecommended = postRecommended;
		this.postRecommendCount = postRecommendCount;
		this.bookmarked = bookmarked;
		this.writer = writer;
		this.replyCount = replyCount;
	}

	public long getBoardId() {
		return boardId;
	}

	public String getBoardTopicName() {
		return boardTopicName;
	}

	public long getPostId() {
		return postId;
	}

	public String getPostTitle() {
		return postTitle;
	}

	public List<PostBlock> getPostContents() {
		return postContents;
	}

	public long getCompanyId() {
		return companyId;
	}

	public String getCompanyName() {
		return companyName;
	}

	public String getUserNickname() {
		return userNickname;
	}

	public String getPostCreateDate() {
		return postCreateDate;
	}

	public int getPostCount() {
		return postCount;
	}

	public boolean isPostRecommended() {
		return postRecommended;
	}

	public int getPostRecommendCount() {
		return postRecommendCount;
	}

	public boolean isBookmarked() {
		return bookmarked;
	}

	public boolean isWriter() {
		return writer;
	}

	public int getReplyCount() {
		return replyCount;
	}
}