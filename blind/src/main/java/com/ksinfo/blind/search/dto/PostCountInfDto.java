package com.ksinfo.blind.search.dto;

public class PostCountInfDto {
	private String postCountId;		  //post_count_id bigint GENERATED ALWAYS AS IDENTITY
	private int postId;  			//post_id bigint not null
	private String postCount;  		//post_count bigint not null
	
	
	public String getPostCountId() {
		return postCountId;
	}
	public void setPostCountId(String postCountId) {
		this.postCountId = postCountId;
	}
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public String getPostCount() {
		return postCount;
	}
	public void setPostCount(String postCount) {
		this.postCount = postCount;
	}
	
	

}
