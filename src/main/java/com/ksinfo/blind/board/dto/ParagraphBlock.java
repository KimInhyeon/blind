package com.ksinfo.blind.board.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public final class ParagraphBlock extends PostBlock {
	public static final class ParagraphData extends Data {
		private final StringBuilder text;

		public ParagraphData(@JsonProperty("text") StringBuilder text) {
			this.text = text;
		}

		public String getText() {
			return text.toString();
		}

		public void escapeDoubleQuote() {
			for (int i = text.length() - 1; i > -1; --i) {
				if (text.charAt(i) == '\"') {
					text.insert(i, '\\');
				}
			}
		}

		public void escapeATag() {
			for (int i = text.length() - 1; i > -1; --i) {
				switch (text.charAt(i)) {
					case '<':
						if (text.charAt(i + 1) == 'a') {
							text.setCharAt(i + 1, 'p');
						}
						break;
					case '>':
						if (text.charAt(i - 1) == 'a') {
							text.setCharAt(i - 1, 'p');
						}
						break;
				}
			}
		}

		public void setATagTarget() {
//			<a href="#"></a> 最小16文字
			for (int i = text.length() - 17; i > -1; --i) {
				if (text.charAt(i) == '<' && text.charAt(i + 1) == 'a') {
					text.insert(i + 3, "target=\"_blank\" ");
				}
			}
		}

		@Override
		public String toString() {
			return "{\"text\":\"" + text + "\"}";
		}
	}

	public ParagraphBlock(@JsonProperty("type") String type, @JsonProperty("data") ParagraphData data) {
		super(type, data);
	}
}