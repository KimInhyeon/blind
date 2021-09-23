package com.ksinfo.blind.board.vo;

import java.util.ArrayList;
import java.util.List;

public final class ReplyVO {
	private final long replyId;
	private final long companyId;
	private final String companyName;
	private final String userNickname;
	private final Long targetReplyId;
	private final String targetNickname;
	private final List<String> replyContents;
	private final char replyBlindFlag;
	private final String recCreateDate;
	private final boolean visible;
	private final String replyFileUrl;
	private final boolean replyRecommended;
	private final int replyRecommendCount;
	private final int nestedCount;
	private final int depth;
	private final boolean writer;

	public ReplyVO(
		long replyId, long companyId, String companyName, String userNickname,
		Long targetReplyId, String targetNickname, String replyContents, char replyBlindFlag,
		String recCreateDate, boolean visible, String replyFileUrl, boolean replyRecommended,
		int replyRecommendCount, int nestedCount, int depth, boolean writer
	) {
		this.replyId = replyId;
		this.companyId = companyId;
		this.companyName = companyName;
		this.userNickname = userNickname;
		this.targetReplyId = targetReplyId;
		this.targetNickname = targetNickname;
		this.replyContents = new ArrayList<>();
		StringBuilder sb = new StringBuilder();
		for (int i = 0, length = replyContents.length() - 1; i < length; ++i) {
			char c = replyContents.charAt(i);
			switch (c) {
				case '>':
					sb.append("&gt;");
					break;
				case '<':
					sb.append("&lt;");
					break;
				case '\n':
					this.replyContents.add(sb.toString());
					sb.setLength(0);
					break;
				default:
					sb.append(c);
					break;
			}
		}
		this.replyContents.add(sb.toString());
		this.replyBlindFlag = replyBlindFlag;
		this.recCreateDate = recCreateDate;
		this.visible = visible;
		this.replyFileUrl = replyFileUrl;
		this.replyRecommended = replyRecommended;
		this.replyRecommendCount = replyRecommendCount;
		this.nestedCount = nestedCount;
		this.depth = depth;
		this.writer = writer;
	}

	public long getReplyId() {
		return replyId;
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

	public Long getTargetReplyId() {
		return targetReplyId;
	}

	public String getTargetNickname() {
		return targetNickname;
	}

	public List<String> getReplyContents() {
		return replyContents;
	}

	public char getReplyBlindFlag() {
		return replyBlindFlag;
	}

	public String getRecCreateDate() {
		return recCreateDate;
	}

	public boolean isVisible() {
		return visible;
	}

	public String getReplyFileUrl() {
		return replyFileUrl;
	}

	public boolean isReplyRecommended() {
		return replyRecommended;
	}

	public int getReplyRecommendCount() {
		return replyRecommendCount;
	}

	public int getNestedCount() {
		return nestedCount;
	}

	public int getDepth() {
		return depth;
	}

	public boolean isWriter() {
		return writer;
	}
}