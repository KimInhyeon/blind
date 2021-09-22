package com.ksinfo.blind.mytask.mapper;

import com.ksinfo.blind.mytask.dto.BookmarkDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Mapper
@Repository
public interface BookmarkMapper {
	List<BookmarkDto> bookmarkList(long userId);

	BookmarkDto searchBookmark(HashMap<String, Object> map);

	void insertBookmark(long userId, long postId);

	void updateBookmark(BookmarkDto searchBookmark);

<<<<<<< HEAD
	//2021-09-07 추가
	public void insertBookmark(HashMap<String, Object> map);				//새로 북마크row추가

	public BookmarkDto searchPostRecommend(HashMap<String, Object> map);
=======
	BookmarkDto searchPostRecommend(HashMap<String, Object> map);
>>>>>>> changju.lee

	long insertPostRecommend(HashMap<String, Object> map);

	long updatePostRecommend(HashMap<String, Object> map);
}