package com.ksinfo.blind.companyNews.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public final class CompanyNewsVO {
	private final int totalResults;
	private final List<Article> articles;

	public static final class Article {
		private final String author;
		private final String title;
		private final String description;
		private final String url;
		private final String urlToImage;
		private final String publishedAt;

		public Article(
			@JsonProperty("author") String author, @JsonProperty("title") String title,
			@JsonProperty("description") String description, @JsonProperty("url") String url,
			@JsonProperty("urlToImage") String urlToImage, @JsonProperty("publishedAt") String publishedAt
		) {
			this.author = author;
			this.title = title;
			this.description = description;
			this.url = url;
			this.urlToImage = urlToImage;
			this.publishedAt = publishedAt.substring(0, 10);
		}

		public String getAuthor() {
			return author;
		}

		public String getTitle() {
			return title;
		}

		public String getDescription() {
			return description;
		}

		public String getUrl() {
			return url;
		}

		public String getUrlToImage() {
			return urlToImage;
		}

		public String getPublishedAt() {
			return publishedAt;
		}
	}

	public CompanyNewsVO(
		@JsonProperty("totalResults") int totalResults, @JsonProperty("articles") List<Article> articles
	) {
		this.totalResults = totalResults;
		this.articles = articles;
	}

	public int getTotalResults() {
		return totalResults;
	}

	public List<Article> getArticles() {
		return articles;
	}
}