package com.ksinfo.blind.board.vo;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ksinfo.blind.board.dto.ImageBlock;
import com.ksinfo.blind.board.dto.ParagraphBlock;
import com.ksinfo.blind.board.dto.PostBlock;

import java.util.ArrayList;
import java.util.List;

public final class BoardPostVO {
	private final long boardId;
	private final String boardTopicName;
	private final long postId;
	private final String postTitle;
	private final List<PostBlock> postContents;
	private final String postFileUrl;
	private final long companyId;
	private final String companyName;
	private final String userNickname;
	private final String postCreateDate;
	private final int postCount;
	private final int postRecommendCount;
	private final int replyCount;
	private final boolean bookmarked;

	public BoardPostVO(
		long boardId, String boardTopicName, long postId, String postTitle, String postContents,
		long companyId, String companyName, String userNickname, String postCreateDate,
		int postCount, int postRecommendCount, int replyCount, boolean bookmarked
	) throws JsonProcessingException {
		this.boardId = boardId;
		this.boardTopicName = boardTopicName;
		this.postId = postId;
		this.postTitle = postTitle;
		this.postContents = new ArrayList<>(2);
		String postFileUrl = null;
		List<PostBlock> postBlockList = new ObjectMapper().readValue(postContents, new TypeReference<>() {});
		for (int i = 0, count = 0, size = postBlockList.size(); i < size && (count < 2 || postFileUrl == null); ++i) {
			PostBlock postBlock = postBlockList.get(i);
			if (postBlock instanceof ParagraphBlock) {
				if (count < 2) {
					((ParagraphBlock.ParagraphData) postBlock.getData()).escapeATag();
					this.postContents.add(postBlock);
					++count;
				}
			} else if (postFileUrl == null) {
				postFileUrl = ((ImageBlock.ImageData) postBlock.getData()).getUrl();
			}
		}
		this.postFileUrl = postFileUrl;
		this.companyId = companyId;
		this.companyName = companyName;
		this.userNickname = userNickname;
		this.postCreateDate = postCreateDate;
		this.postCount = postCount;
		this.postRecommendCount = postRecommendCount;
		this.replyCount = replyCount;
		this.bookmarked = bookmarked;
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

	public int getReplyCount() {
		return replyCount;
	}

	public int getPostRecommendCount() {
		return postRecommendCount;
	}

	public boolean isBookmarked() {
		return bookmarked;
	}

	public String getPostFileUrl() {
		return postFileUrl;
	}
}