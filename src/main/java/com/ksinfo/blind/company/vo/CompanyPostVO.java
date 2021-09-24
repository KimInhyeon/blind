package com.ksinfo.blind.company.vo;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ksinfo.blind.board.dto.ParagraphBlock;
import com.ksinfo.blind.board.dto.PostBlock;

import java.util.ArrayList;
import java.util.List;

public final class CompanyPostVO {
	private final long postId;
	private final String postTitle;
	private final List<PostBlock> postContents;
	private final String userNickname;
	private final long companyId;
	private final String companyName;
	private final String postCreateDate;
	private final int postCount;
	private final int postRecommendCount;
	private final int replyCount;
	private final boolean bookmarked;

	public CompanyPostVO(
		long postId, String postTitle, String postContents, String userNickname, long companyId, String companyName,
		String postCreateDate, int postCount, int postRecommendCount, int replyCount, boolean bookmarked
	) throws JsonProcessingException {
		this.postId = postId;
		this.postTitle = postTitle;
		this.postContents = new ArrayList<>(2);
		List<PostBlock> postBlockList = new ObjectMapper().readValue(postContents, new TypeReference<>() {});
		for (int i = 0, count = 0, size = postBlockList.size(); i < size && count < 2; ++i) {
			PostBlock postBlock = postBlockList.get(i);
			if (postBlock instanceof ParagraphBlock) {
				((ParagraphBlock.ParagraphData) postBlock.getData()).escapeATag();
				this.postContents.add(postBlock);
				++count;
			}
		}
		this.userNickname = userNickname;
		this.companyId = companyId;
		this.companyName = companyName;
		this.postCreateDate = postCreateDate;
		this.postCount = postCount;
		this.postRecommendCount = postRecommendCount;
		this.replyCount = replyCount;
		this.bookmarked = bookmarked;
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

	public String getUserNickname() {
		return userNickname;
	}

	public long getCompanyId() {
		return companyId;
	}

	public String getCompanyName() {
		return companyName;
	}

	public String getPostCreateDate() {
		return postCreateDate;
	}

	public int getPostCount() {
		return postCount;
	}

	public int getPostRecommendCount() {
		return postRecommendCount;
	}

	public int getReplyCount() {
		return replyCount;
	}

	public boolean isBookmarked() {
		return bookmarked;
	}
}