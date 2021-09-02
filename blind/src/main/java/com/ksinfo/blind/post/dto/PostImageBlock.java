package com.ksinfo.blind.post.dto;

import com.fasterxml.jackson.annotation.JsonCreator;

public final class PostImageBlock extends PostBlock {
	public static final class ImageData extends Data {
		private final String url;
		private final String caption;
		private final boolean withBorder;
		private final boolean withBackground;
		private final boolean stretched;

		@JsonCreator
		public ImageData(String url, String caption, boolean withBorder, boolean withBackground, boolean stretched) {
			this.url = url;
			this.caption = caption;
			this.withBorder = withBorder;
			this.withBackground = withBackground;
			this.stretched = stretched;
		}

		public String getUrl() {
			return url;
		}

		public String getCaption() {
			return caption;
		}

		public boolean isWithBorder() {
			return withBorder;
		}

		public boolean isWithBackground() {
			return withBackground;
		}

		public boolean isStretched() {
			return stretched;
		}

		@Override
		public String toString() {
			return "{url:\'" + url + "\',caption:\'" + caption + "\',withBorder:" + withBorder +
					",withBackground:" + withBackground + ",stretched:" + stretched + '}';
		}
	}

	public PostImageBlock(String type, ImageData data) {
		super(type, data);
	}
}