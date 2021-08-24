package com.ksinfo.blind.post.dto;

import com.fasterxml.jackson.annotation.JsonCreator;

public final class PostParagraphBlock extends PostBlock {
	public static final class ParagraphData extends Data {
		private final String text;

		@JsonCreator
		public ParagraphData(String text) {
			this.text = text;
		}

		public String getText() {
			return text;
		}

		@Override
		public String toString() {
			return "{text:\'" + text + "\'}";
		}
	}

	public PostParagraphBlock(String type, ParagraphData data) {
		super(type, data);
	}
}