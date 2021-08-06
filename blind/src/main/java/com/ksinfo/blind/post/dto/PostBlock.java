package com.ksinfo.blind.post.dto;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;

@JsonTypeInfo(use = JsonTypeInfo.Id.NAME, property = "type", visible = true)
@JsonSubTypes({
	@JsonSubTypes.Type(value = PostParagraphBlock.class, name = "paragraph"),
	@JsonSubTypes.Type(value = PostImageBlock.class, name = "image")
})
public abstract class PostBlock {
	private final String type;
	private final Data data;

	public static abstract class Data {
		public abstract String toString();
	}

	public PostBlock(String type, Data data) {
		this.type = type;
		this.data = data;
	}

	public final String getType() {
		return type;
	}

	public final Data data() {
		return data;
	}

	@Override
	public final String toString() {
		return "{type:\'" + getType() + "\',data:" + data + '}';
	}
}