package com.ksinfo.blind.mytask.service;

import com.ksinfo.blind.mytask.dto.BookmarkDto;
import com.ksinfo.blind.mytask.dto.MyTopicDto;
import com.ksinfo.blind.mytask.mapper.BookmarkMapper;
import com.ksinfo.blind.mytask.mapper.MyTopicMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class BookmarkService {

	@Autowired
	private BookmarkMapper bookmarkMapper;

	public List<BookmarkDto> bookmarkList(long userId) {

		return bookmarkMapper.bookmarkList(userId);
	}

	public BookmarkDto searchBookmark(long userId, long postId){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("postId", postId);
		return bookmarkMapper.searchBookmark(map);
	}

//	public long insertBookmark(BookmarkDto searchBookmark){
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		map.put("logicalDelFlag", searchBookmark.getLogicalDelFlag());
//		map.put("postId", searchBookmark.getPostId());
//		map.put("userId", searchBookmark.getUserId());
//		return bookmarkMapper.insertBookmark(map);
//	}

	public long updateBookmark(BookmarkDto searchBookmark){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("logicalDelFlag", searchBookmark.getLogicalDelFlag());
		map.put("userId", searchBookmark.getUserId());
		map.put("bookmarkId", searchBookmark.getBookmarkId());
		return bookmarkMapper.updateBookmark(map);
	}

	//북마크 컨트롤러에서 searchBookmark 실시결과 null이 나온경우 신규추가를 실시.
	public void insertBookmark(int userId, int postId){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("postId", postId );
		map.put("userId", userId );
		bookmarkMapper.insertBookmark(map);
	}

	public int checkNowBookmarkFlag(BookmarkDto searchBookmark){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("postId", searchBookmark.getPostId());
		map.put("userId", searchBookmark.getUserId());
		return bookmarkMapper.checkNowBookmarkFlag(map);
	}

	public BookmarkDto searchPostRecommend(long userId, long postId){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("postId", postId);
		return bookmarkMapper.searchPostRecommend(map);
	}

	public long insertPostRecommend(long userId, long postId){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("postId", postId);
		return bookmarkMapper.insertPostRecommend(map);
	}

	public long updatePostRecommend(BookmarkDto searchPostRecommend){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("postRecommendId", searchPostRecommend.getPostRecommendId());
		return bookmarkMapper.updatePostRecommend(map);
	}
}
